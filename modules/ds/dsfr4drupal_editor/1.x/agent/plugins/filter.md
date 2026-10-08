<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `filter_dsfr4drupal` output filter

Source: `src/Plugin/Filter/FilterDsfr.php` (the module's only PHP file). No libraries, JS, config,
routes, or CKEditor 5 plugin ship with the module.

## Install & enable

- `drush en dsfr4drupal_editor -y` (or the Extend UI). Dependency: core **Editor**
  (`drupal:editor`), which pulls in core **Filter**.
- Go to **Administration → Configuration → Content authoring → Text formats and editors**
  (`/admin/config/content/formats`), edit a format (e.g. *Full HTML*), tick **Apply the DSFR
  recommendations** in *Enabled filters*, and save.
- **Ordering matters** (from the filter's own description): if you also use the *Align/Caption*
  filter (`filter_caption` / `filter_align`, part of core's media embedding), configure **this filter
  to run after it** under *Filter processing order*, so the `align-*` class is already present on the
  `<drupal-media>` tag when this filter rewrites it. The blockquote/table wrappers should generally
  come after any HTML-restricting filter so the injected markup survives.
- The filter exposes **no settings** — it does not implement `settingsForm()` or
  `defaultConfiguration()`, so there is no per-format configuration beyond enabling/ordering it, and
  no config schema is shipped (`provides_config_schema` is false).

## Plugin definition

- Class `FilterDsfr extends \Drupal\filter\Plugin\FilterBase`, declared `strict_types=1`.
- PHP-attribute `#[Filter(...)]` (not annotation):
  - `id: 'filter_dsfr4drupal'`
  - `title: 'Apply the DSFR recommendations'`
  - `description: "Overrides the generated HTML to make it compatible/compliant with DSFR. If used in
    conjunction with the 'Align/Caption' filter, make sure this filter is configured to run after it."`
  - `type: FilterInterface::TYPE_TRANSFORM_IRREVERSIBLE`
- `TYPE_TRANSFORM_IRREVERSIBLE` means it transforms the rendered output and cannot be reversed to the
  source, so it does not affect the value stored/round-tripped by the editor — only what is emitted.

## What `process()` does

`process($text, $langcode): FilterProcessResult` chains three private helpers, then returns
`new FilterProcessResult($text)` — **no** `setAttachments()`, **no** cache tags/contexts/max-age are
added (it relies on the surrounding filter pipeline's caching).

### 1. `processBlockquote($text)` — DSFR *citation* wrapper

`str_replace` (order of the two arrays is positional):

| Search | Replace |
| --- | --- |
| `<blockquote` | `<figure class="fr-quote"><blockquote` |
| `</blockquote>` | `</blockquote></figure>` |

Wraps every blockquote in `<figure class="fr-quote">…</figure>` (DSFR *Citation* component).

### 2. `processMediaAlign($text)` — media alignment class rewrite

One regex, `preg_replace` with the `s` modifier:

```
/<drupal-media([^>]*)class="([^"]*)align-(left|center|right)([^"]*)"([^>]*)>/s
  →  <drupal-media$1class="$2text-align-$3$4"$5>
```

- Matches a `<drupal-media>` embed tag whose `class` attribute contains `align-left|center|right`
  (the class core's *Align* filter/CKEditor writes) and rewrites just that token to
  `text-align-left|center|right` (the class DSFR expects).
- `$1`, `$2`, `$4`, `$5` re-emit the surrounding attribute content **verbatim** via backreferences —
  the filter introduces no new attribute value, it only renames one class token that was already
  present in the editor output.

### 3. `processTable($text)` — DSFR *table* wrapper

`str_replace`:

| Search | Replace |
| --- | --- |
| `<table` | `<div class="fr-table"><div class="fr-table__wrapper"><div class="fr-table__container"><div class="fr-table__content"><table` |
| `</table>` | `</table></div></div></div></div>` |

Wraps every table in the four nested DSFR responsive-table containers.

## Behaviour caveats (functional, not security)

- The `str_replace` matches are **substring** matches on `<blockquote`/`<table`, so a literal
  `<table` / `<blockquote` appearing as escaped text (e.g. inside a `<code>`/`<pre>` sample) would
  not match because it would be HTML-entity-encoded (`&lt;table`) by the editor, not a raw `<table`.
  Nested tables each get their own wrapper set. This is a layout concern, not a correctness/security
  one.
- Because it is `TYPE_TRANSFORM_IRREVERSIBLE`, enable it only on formats where the DSFR wrappers are
  wanted; the transform is applied at render time and is not stored.
- The `fr-quote` / `fr-table*` classes only produce visible styling if the DSFR CSS is loaded —
  install/enable this alongside the base **DSFR for Drupal** theme.

## Security notes

- **No server-side surface.** The module defines no route, controller, AJAX/REST endpoint, form,
  service, hook, or permission. There is nothing to access-gate.
- **No reflected input / no XSS introduced.** All three transforms insert **fixed literal** DSFR
  markup (`<figure class="fr-quote">`, the `fr-table*` divs) or rename one existing class token
  (`align-*` → `text-align-*`) that the editor had already emitted. No editor-, request-, or
  visitor-supplied value is placed into new markup by this filter, and it removes none of the text
  format's other sanitisation (HTML restriction / `filter_html` / `Xss` filters still run in their
  configured order). It only adds wrapper elements around already-produced HTML.
- **No config to leak.** No settings form, no config object, no secrets.
