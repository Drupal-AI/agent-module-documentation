<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DSFR for Drupal - Picker provides DSFR icons and pictograms picker fields.

---

DSFR for Drupal - Picker provides picker fields and CKEditor buttons for DSFR icons and pictograms — the
official iconography of the French State Design System (Système de Design de l'État) — so editors on
DSFR-compliant (French government) sites can select DSFR icons/pictograms via a field widget or insert them
inline in rich text. It adds two field types (`dsfr4drupal_picker_icon`, `dsfr4drupal_picker_pictogram`) with
matching widgets, formatters and text-format filters (`<dsfr-icon>`, `<dsfr-pictogram>`), plus two CKEditor 5
toolbar buttons. Icon and pictogram sets are detected automatically from the installed DSFR library, so nothing
extra is needed when you update it. It ships example/link/media submodules and is configured at
`dsfr4drupal_picker.settings`, in the DSFR for Drupal package. Version 1.2.1 (branch 1.2.x), core
`^10.3 || ^11 || ^12`, depends on core `field`.

Use it on DSFR-based French government sites. It needs two webroot libraries — the DSFR library at
`libraries/dsfr/dist/` (`gouv/dsfr`) and the jQuery FontIconPicker library at `libraries/fonticonpicker/` — and
PHP ext-iconv; the status report errors until both libraries are present. Add the icon/pictogram field on
Manage fields, optionally limit it to specific icon/pictogram categories per instance, and the picker (backed
by FontIconPicker) shows only that subset. The Media submodule adds a Pictogram media type for contributing
custom pictograms. It is a content-editing/fields feature; the selected icon/pictogram is authored data and the
module defines no permissions of its own (it uses core `administer site configuration` and `filter_format.use`).

---

- Provide DSFR icon and pictogram picker field types.
- Select DSFR icons/pictograms via a field widget.
- Insert DSFR icons and pictograms inline from CKEditor 5.
- Add the two CKEditor toolbar buttons (icon, pictogram).
- Embed icons in body text with the `<dsfr-icon>` filter tag.
- Embed pictograms in body text with the `<dsfr-pictogram>` filter tag.
- Limit a field instance to one or more icon/pictogram categories.
- Auto-detect the icon/pictogram set from the installed DSFR library.
- Set an icon display size (xs/sm/md/lg) on the formatter.
- Serve DSFR-compliant French government sites.
- Ship example, link and media submodules.
- Add a Pictogram media type for custom pictograms (Media submodule).
- Categorise custom pictograms via a taxonomy vocabulary (Media submodule).
- Add a link-icon widget for link fields (Link submodule).
- Configure the widget theme at `dsfr4drupal_picker.settings`.
- Enable a search bar in the picker for large icon sets.
- Extend the icon/pictogram sets via alter hooks.
- Render icons/pictograms through SDC components.
- Use the French State design system iconography.
- Pair with the base DSFR for Drupal theme.
- Pick DSFR pictograms.
- Add DSFR icon fields to content types.
- Rely on core Select validation for chosen values.
- Use it without any module-specific permission.
