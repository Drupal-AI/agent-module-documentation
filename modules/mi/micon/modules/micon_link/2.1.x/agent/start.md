<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Micon Link — agent index

Adds an icon-capable **widget** and **formatter** for core `link` fields. Configured entirely
on *Manage form display* / *Manage display*; no settings form or `configure` route.

- **The `micon_link` widget & formatter — plugin ids, settings, where the icon is stored** →
  [configure/widget-formatter.md](configure/widget-formatter.md)

Key facts (grounded in `micon_link/src/Plugin/Field/FieldWidget` & `FieldFormatter`):
- Widget id **`micon_link`** (extends core `LinkWidget`); formatter id **`micon_link`**
  (extends core `LinkFormatter`). Both apply to field type `link`.
- The chosen icon is stored **on the link value**: `options.attributes.data-icon`
  (and `data-icon-position` = `before`|`after`|`icon_only`).
- Provides `MiconLinkWidgetTrait` (reused by `micon_linkit` / `micon_linkit_attributes`) and
  config schema `field.widget.settings.micon_link` + `field.formatter.settings.micon_link`.

See the parent `micon` docs for the icon selector / `micon()` API.
