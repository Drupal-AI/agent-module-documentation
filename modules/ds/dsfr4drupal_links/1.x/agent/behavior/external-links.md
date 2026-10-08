<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# External-link marking — config, hook, and filter

How `dsfr4drupal_links` applies DSFR external-link markup. Two independent code paths share one
setting.

## Install / enable

`drush en dsfr4drupal_links -y`. No dependencies are declared in `dsfr4drupal_links.info.yml`; the
filter plugin extends core `filter`'s `FilterBase`, so the core `filter` module must be enabled
(it normally is). Installing writes the config object below.

## Configuration

- Config object: **`dsfr4drupal_links.settings`** (install default at
  `config/install/dsfr4drupal_links.settings.yml`).
- Single key: **`external_blank`** — boolean, default **`true`**.
  - `true`: force `target="_blank"` on links Drupal considers external (both code paths).
  - `false`: do **not** force `target="_blank"`; the module then only enriches links that are
    *already* `_blank` (the hook still adds `rel`/`title` to pre-existing `_blank` links; the
    filter's `process()` returns early and does nothing — see below).
- **No admin form and no route ship** (there is no `*.routing.yml`, no settings form, `configure`
  is null). Change the value via `drush cset dsfr4drupal_links.settings external_blank 0 -y` or
  configuration import.
- **No `config/schema/`** is provided, so `external_blank` is untyped in config schema. It still
  works, but strict config-schema checks (e.g. in tests) will flag it.

## Mechanism 1 — `hook_link_alter` (Drupal-generated links)

`Dsfr4drupalLinksHooks::linkAlter(array &$variables)` (`src/Hook/Dsfr4drupalLinksHooks.php`),
wired as a service in `dsfr4drupal_links.services.yml` (autowired, `config.factory` injected) and
invoked through the `#[LegacyHook]` wrapper in `dsfr4drupal_links.module`:

1. Reads `$variables['url']` (a `\Drupal\Core\Url`). If `$url->isExternal()` and
   `external_blank` is on → set `$variables['options']['attributes']['target'] = '_blank'`.
2. For any link whose `target === '_blank'` (whether set here or already present):
   - add `rel = 'noopener external'` **only if `rel` is not already set**;
   - add `title = t('@label - new window', ['@label' => strip_tags($variables['text'])])`
     with translation context `'Link title attribute'`, **only if `title` is not already set**.

This covers menu links, field-rendered links, and theme links that pass through Drupal's link
generator. Existing `rel`/`title` are preserved.

## Mechanism 2 — text-format filter (WYSIWYG content)

`ExternaLinks` (`src/Plugin/Filter/ExternaLinks.php`), id **`dsfr4drupal_external_links`**, type
`TYPE_TRANSFORM_IRREVERSIBLE`. Enable it per text format on **Administration › Configuration ›
Content authoring › Text formats and editors**. `process($text, $langcode)`:

1. If `external_blank` is **false**, returns the text unchanged (this filter only acts when
   force-blank is on).
2. Loads the fragment with `Html::load()`, iterates `<a>` elements:
   - skips links with no `href` and `mailto:` links;
   - `isExternalUrl($href)` = not matching `$base_url` **and** `UrlHelper::isExternal($href)` →
     set `target="_blank"`;
   - for `_blank` links, merges `noopener` + `external` into any existing `rel`
     (`array_unique(array_merge(...))`), and sets `title` from the existing title or
     `strip_tags($link->nodeValue)` wrapped in `t('@label - new window', …)->render()`.
3. Returns `Html::serialize($dom)` in the `FilterProcessResult`.

Notes:
- Being `TYPE_TRANSFORM_IRREVERSIBLE`, it should run late and its output is not reversible for the
  editor form — standard for markup-injecting filters.
- The `title` is built with `t()`/`TranslatableMarkup`, so the label is escaped; link text is
  `strip_tags`-ed first.

## What it does NOT do

No blocks, field formatters, entities, permissions, Drush commands, JS, or theme overrides. It
only rewrites `<a>` attributes. `hook_help` returns a one-line About string on
`help.page.dsfr4drupal_links`.
