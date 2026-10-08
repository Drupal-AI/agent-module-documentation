<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Spacing (ckeditor_spacing) — agent index

A CKEditor 5 plugin that lets editors set **margin and padding on individual block elements**
(paragraphs, headings, lists, blockquotes, images, tables — anything CKEditor treats as a block)
from a **balloon**, **without ever enabling the `style` attribute** on the text format. The value is
stored as a `data-spacing-*` attribute on the block itself (never a wrapper, never inline `style`);
a companion text-format **filter** turns those attributes into inline logical-property styles at
render time. Same technique as `ckeditor_media_resizer`. Package `CKEditor 5`. Core
`^10.3 || ^11`. License GPL-2.0-or-later. Installed **1.0.1** (version dir `1.0.x`).

## Dependencies

- Drupal module: **`ckeditor5`** (core) — the only dependency (`.info.yml`).
- No Composer packages, no external JS libraries, no build step. Plain ES6, shipped as written.
  There is no `composer.json` (drupal.org generates one at release time).

## What it provides (from source)

- **CKEditor 5 plugin** `ckeditor_spacing_spacing` (`src/Plugin/CKEditor5Plugin/Spacing.php`,
  extends `CKEditor5PluginDefault`, implements `CKEditor5PluginConfigurableInterface`). Adds a single
  toolbar button `spacing`; JS plugin id `spacing.Spacing`. Declares allowed elements
  `<* data-spacing-mt data-spacing-mb>`, `<* data-spacing-pt data-spacing-pb>`,
  `<* data-spacing-ps data-spacing-pe>` — i.e. the six data-* attributes on **any** element; it does
  **not** enable the `style` attribute or `attributes:true`.
  - **Per-text-format settings** (config schema `ckeditor5.plugin.ckeditor_spacing_spacing`):
    `default_unit` (default `px`), `enabled_units` (default `['px','rem','em','%']`, canonical order
    from `['px','rem','em','%','vw','vh']`), `enable_horizontal` (default `FALSE` — opt-in Horizontal
    padding field). `validateConfigurationForm` requires ≥1 unit and that the default is among the
    enabled units. `getDynamicPluginConfig()` passes these to JS as `spacing.{defaultUnit,units,horizontal}`.
- **Filter** `ckeditor_spacing` "Apply spacing to block elements"
  (`src/Plugin/Filter/SpacingFilter.php`, `TYPE_TRANSFORM_REVERSIBLE`, weight 100). Must run **after**
  "Limit allowed HTML tags". Reads the six `data-spacing-*` attributes and writes the equivalent
  inline logical-property styles, consuming (removing) the data-* attribute. Filter config schema
  `filter_settings.ckeditor_spacing` (no settings of its own).
- **Libraries** (`.libraries.yml`): `ckeditor5.spacing` (the JS `js/spacing.js` + balloon CSS
  `css/spacing.admin.css`, loaded on content forms where the editor runs) and `admin` (just the
  toolbar-button icon CSS `css/spacing.toolbar.css`, for the text-format settings page).
- **`.module`**: `hook_help()` only. **No** routes, services, permissions, install/update hooks,
  blocks, entities, or Drush commands.
- **Tests**: `tests/src/Unit/SpacingFilterTest.php` — the filter is the security boundary; covers the
  attribute→property map, the value grammar with canonical forms, and injection attempts
  (`10px; color: red`, `10px}body{display:none`, `url(javascript:…)`, `expression(…)`), all of which
  must produce no `style`.

## Attribute → CSS map (SpacingFilter::MAP)

| data attribute | CSS logical property | Balloon field |
|---|---|---|
| `data-spacing-mt` | `margin-block-start` | Margin › Top |
| `data-spacing-mb` | `margin-block-end` | Margin › Bottom |
| `data-spacing-pt` | `padding-block-start` | Padding › Top |
| `data-spacing-pb` | `padding-block-end` | Padding › Bottom |
| `data-spacing-ps` | `padding-inline-start` | Padding › Horizontal (symmetric) |
| `data-spacing-pe` | `padding-inline-end` | Padding › Horizontal (symmetric) |

Logical properties (`block-start`/`inline-start`) so RTL flips automatically. Accepted value grammar,
identical in JS and PHP: `/^\s*(\d*\.?\d+)\s*(px|rem|em|%|vw|vh)\s*$/i` — a **non-negative** number
plus one unit from `px rem em % vw vh`. Negatives, unitless, `calc()`, `var()`, unknown units, and
injection attempts are rejected on both sides; PHP never concatenates a raw value into CSS.

## Setup (two required steps, both matter)

Per text format at **Administration → Configuration → Content authoring → Text formats and editors**:
1. Drag the **Spacing** button into the active toolbar.
2. Enable the **"Apply spacing to block elements"** filter and order it **after** "Limit allowed HTML
   tags and correct faulty HTML". Skip this and the editor works but published pages show no spacing
   (the data attributes save, nothing converts them).

## How it works (JS, `js/spacing.js`)

One `Spacing` plugin requiring `SpacingEditing` + `SpacingUI`. Editing side: allows the six model
attributes on any block via a `checkAttribute` schema hook (inline elements excluded); registers one
command per edge; three conversions — **upcast** (data-* → validated/normalised model attr, junk → null),
**dataDowncast** (model → saved `data-spacing-*`), **editingDowncast** (model → inline `style` in the
editing view for WYSIWYG, plus an editor-only `ck-spacing-marked` marker class that never reaches saved
data). `enter`'s `afterExecute` strips spacing from a newly split block (one-off adjustment, not a
continuing style). UI side: a toolbar button opens a balloon form (unit pills + labelled number fields
grouped Margin/Padding, live preview, Esc cancels/reverts, Ctrl+Enter accepts); an actions balloon
(summary + edit/remove) shows when the caret sits on an already-spaced block, mirroring the link
feature. Dual DLL/UMD shim (`window.CKEditor5` on D10/11, `window.CKEDITOR` on D12).

## Security / hardening

The `style` attribute is **never** enabled on the format; spacing lives as controlled `data-spacing-*`
attributes and only the server-side `SpacingFilter` emits inline styles, re-validating each value
against a fixed unit allowlist and mapping only to a fixed set of CSS properties — so a restricted
text format stays restricted and XSS-safe. No routes, permissions, services, DB access, HTTP calls,
uploads, or external integrations. Config forms are admin-gated by the standard text-format permission.
See the README's "Known limitations" for the inert-GHS-junk round-trip (harmless, dropped by the filter).
