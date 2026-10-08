<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Font Awesome Iconpicker adds a searchable icon-picker field widget (and matching display formatter) so content editors can choose a Font Awesome icon for a plain-text or formatted-text field instead of typing a CSS class by hand.

---

The module provides two core field plugins that attach to ordinary `text` and `string` fields: a field **widget** (`fontawesome_iconpicker`) and a field **formatter** (`fontawesome_iconpicker_formatter_type`). You add a Text (plain) or Text (formatted) field to any entity bundle, then on *Manage form display* switch that field's widget to "Font Awesome Icon Picker"; the widget renders a text input enhanced by the bundled `vanilla-icon-picker` JavaScript library, which pops up a searchable grid of Font Awesome 5/6 (Solid, Regular, Brands) icons and stores the chosen icon's class in the field. Widget settings are a required picker `type` (Default, or "As a bootstrap component" which loads the Bootstrap 5 theme), a numeric field `size`, and a `placeholder`. On *Manage display* you set the field's formatter to "Font Awesome Icon Picker" and pick an icon `size` (`fa-1x` … `fa-5x`); the formatter renders through the `fontawesome_iconpicker_formatter` theme hook to `<i class="fa <icon> <size>" aria-hidden="true"></i>`. The module depends on the contrib **Font Awesome** module (which supplies the icon CSS/webfont) and on the external `d34dman/vanilla-icon-picker` library installed under `/libraries`. It has no admin settings page, routes, permissions, services, or Drush commands — everything is configured per field on the display forms.

---

- Let editors pick a Font Awesome icon for a "menu icon" field from a searchable popup.
- Store an icon class on a card/tile content type and render it visually.
- Add an icon chooser to a call-to-action button field instead of a free-text class input.
- Give a "social link" field an icon picker so editors select the right brand icon.
- Render a chosen icon at a larger size (`fa-3x`) in a feature block.
- Provide a Bootstrap-themed icon picker on a site already using Bootstrap.
- Attach an icon selector to a taxonomy term field (e.g. category icons).
- Let authors set a decorative icon on a paragraph component.
- Replace a plain text field where editors used to hand-type `fa-house` with a visual picker.
- Show the selected icon inline next to a title using the formatter.
- Configure a helpful placeholder ("Search icon…") on the icon field.
- Constrain the visible input width via the widget's field size setting.
- Pick icons from Font Awesome Solid, Regular, and Brands sets in one picker.
- Add an icon field to a custom block type for editors to personalise blocks.
- Use the picker on a menu-item-like content entity to attach icons to links.
- Display icons at consistent sizes across a listing via the formatter size setting.
- Give a "features list" field an icon per item (on a string field).
- Let editors change an icon without touching CSS or code.
- Provide an accessible icon output (`aria-hidden="true"`) in rendered markup.
- Standardise icon selection UX across multiple content types by reusing the widget.
- Offer a searchable icon grid rather than scrolling a long dropdown of class names.
- Pair a plain-text storage field with a rich visual picker for non-technical editors.
