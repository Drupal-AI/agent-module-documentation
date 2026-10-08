<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DSFR for Drupal Editor (dsfr4drupal_editor) — agent index

A single **text-format output filter** that post-processes editor-generated HTML so it matches the
French State Design System (**DSFR** — *Système de Design de l'État*). It wraps `<table>` and
`<blockquote>` in the DSFR component markup and rewrites core Media's `align-*` class to DSFR's
`text-align-*` on `<drupal-media>` embeds. Package `DSFR for Drupal`. Sole dependency: core
**Editor** (`drupal:editor`). Core requirement `^10.3 || ^11 || ^12`. License GPL-2.0-or-later.
Installed version 1.2.0.

- **The filter plugin, exactly what each transform emits, how to enable/order it** →
  [plugins/filter.md](plugins/filter.md)

## What it actually is

- **One plugin:** `FilterDsfr` (`#[Filter]` id **`filter_dsfr4drupal`**, title *"Apply the DSFR
  recommendations"*), in `src/Plugin/Filter/FilterDsfr.php`, extending core's `FilterBase`.
  Type `TYPE_TRANSFORM_IRREVERSIBLE`.
- **No** JavaScript, **no** CKEditor 5 plugin (no `*.ckeditor5.yml`), **no** asset library, **no**
  routes, **no** controllers, **no** AJAX callbacks, **no** permissions, **no** services, **no**
  hooks, **no** config schema, **no** admin settings form, **no** Drush, **no** submodules.
  Everything is configured on core's standard *Text formats and editors* screens.
- Despite the project name/description saying "CKEditor", this ships **no editor-plugin code** — it
  is purely a server-side render-time filter applied to the stored HTML.

## Mechanism (from source)

`process($text, $langcode)` runs three private string transforms in order and returns a plain
`FilterProcessResult($text)` (no cache metadata, no attachments):

- **`processBlockquote()`** — `str_replace`: `<blockquote` → `<figure class="fr-quote"><blockquote`
  and `</blockquote>` → `</blockquote></figure>` (DSFR *citation* wrapper).
- **`processMediaAlign()`** — `preg_replace` over `<drupal-media … class="…align-(left|center|right)…" …>`
  rewriting the captured `align-X` substring to `text-align-X`; all other attributes/classes are
  re-emitted verbatim via backreferences. No new value is introduced.
- **`processTable()`** — `str_replace`: `<table` → the four nested DSFR wrapper divs
  (`fr-table` › `fr-table__wrapper` › `fr-table__container` › `fr-table__content`) + `<table`, and
  `</table>` → `</table>` + the four closing `</div>`s.

The three replacement strings are **fixed literals** (DSFR class names); no editor-, request-, or
visitor-supplied data is inserted by this filter. See [plugins/filter.md](plugins/filter.md) for the
exact strings and ordering caveats.

## Operate it

- `drush en dsfr4drupal_editor -y`, then at `/admin/config/content/formats` edit a format, tick
  **Apply the DSFR recommendations**, and place it **after** the *Align/Caption* (media) filter so the
  `align-*` class is present when this filter rewrites it (per the plugin description).
- Pair with the base **DSFR for Drupal** theme (which ships the `fr-*` CSS) for the wrappers to render.

## Security

No server-side route/controller/AJAX/form surface, no permissions, and the filter reflects no
user/request input — it only injects static DSFR class wrappers around existing tags. See
[plugins/filter.md](plugins/filter.md#security-notes).
