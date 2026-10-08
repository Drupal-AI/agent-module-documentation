<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DSFR for Drupal - Links (dsfr4drupal_links) — agent index

Adds DSFR (French State Design System) external-link markup — `target="_blank"`,
`rel="noopener external"`, and a translatable `@label - new window` title — to links Drupal
treats as external. Two mechanisms: a `hook_link_alter` implementation for Drupal-generated links
and a text-format **filter** for CKEditor/WYSIWYG content. All server-side, no JavaScript.

- Package **DSFR for Drupal**. Core `^10.3 || ^11 || ^12`. License GPL-2.0-or-later. Version 1.1.0.
- **No composer.json, no dependencies declared** in `.info.yml`. Uses core's `filter` module at
  runtime (the filter plugin extends `filter`'s `FilterBase`); filter is part of core.
- **No routes, no permissions, no admin form, no Drush, no config schema.** One config object with
  one key.

- **Config key, the hook, and the filter — how it all works and how to operate it** →
  [behavior/external-links.md](behavior/external-links.md)

## What it provides (from source)

- **Hook service** `Drupal\dsfr4drupal_links\Hook\Dsfr4drupalLinksHooks` (`dsfr4drupal_links.services.yml`,
  autowired, injects `config.factory`). Implements `hook_help` and `hook_link_alter` via
  `#[Hook(...)]` attributes; `dsfr4drupal_links.module` bridges them with `#[LegacyHook]` wrappers.
  `linkAlter()` sets `target=_blank` on external URLs when `external_blank` is on, then adds
  `rel="noopener external"` and a `@label - new window` title on any `_blank` link (only if unset).
- **Filter plugin** `Drupal\dsfr4drupal_links\Plugin\Filter\ExternaLinks` — id **`dsfr4drupal_external_links`**,
  type `TYPE_TRANSFORM_IRREVERSIBLE`, in `src/Plugin/Filter/ExternaLinks.php`. Applies the same
  markup to `<a>` tags inside editor HTML via `Html::load()`/`Html::serialize()`; skips `mailto:`
  and non-external links; determines "external" with `UrlHelper::isExternal()` plus a `$base_url`
  guard.
- **Config** `dsfr4drupal_links.settings` — single key `external_blank` (default `true`), install
  default in `config/install/dsfr4drupal_links.settings.yml`. No `config/schema` ships.
- Translations: `translations/fr.po` (French).

No blocks, no field formatters, no entities, no plugin types, no theme templates.
