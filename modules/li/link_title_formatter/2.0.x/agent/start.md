<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Link title formatter (link_title_formatter) — agent index

One field formatter: renders a **core link field's title as plain text**, dropping the anchor.
Package *Field Formatters*. Version **2.0.2**. Core `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later.
Depends only on core **`link`**. No routes, permissions, services, hooks, config schema, or submodules.

- **The formatter — id/label, what it renders, its (inert) inherited settings, how to enable it** →
  [fields/formatter.md](fields/formatter.md)

## What it actually is

- One plugin: `LinkTitle` (id **`link_title`**, label *"Link Title"*), in
  `src/Plugin/Field/FieldFormatter/LinkTitle.php`, **extending core's `LinkFormatter`**.
  `field_types = { "link" }` — targets core **link fields** only.
- `viewElements()` outputs `Html::escape($item->title)` as `#markup` for each item whose title is
  non-empty. The URI is never rendered; no `<a>` is produced.
- Selected per view-display on **Manage display**. Nothing else to configure — it has no settings
  route, no config object of its own.

## Caveat worth knowing

- It only overrides `viewElements()`, so the settings **form** it inherits from `LinkFormatter`
  (trim length, URL-only, `rel=nofollow`, `target=_blank`) still appears but has **no effect** on
  output. `defaultSettings()` sets `trim_length => ''` yet the trim is not applied.
- If a link item's **title is empty**, that item renders nothing. On fields where the title is
  optional, decide what the empty case should show.
