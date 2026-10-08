<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DSFR Core is the base module of the DSFR (French State Design System) suite, providing shared services, admin pages, and field/text-format tooling for the sibling DSFR modules and theme.

---

DSFR Core does not render front-end components itself; it is the foundation the rest of the DSFR suite builds on. It ships four services (`dsfr_core.tools`, `dsfr_core.fieldStorage`, `dsfr_core.fieldManage`, `dsfr_core.filterEditor`) that sibling modules (dsfr_block, dsfr_paragraph, dsfr_menu) call to install their DSFR-specific fields, text formats and CKEditor 5 configurations. It also exposes an admin area under `/admin/dsfr` (route `dsfr_core.settings`, menu under Structure) that checks whether the DSFR theme is installed and active, links to each child module, redirects to the DSFR theme settings, and offers Preact-driven browsers for the DSFR icon and pictogram libraries. On install it relaxes the "ALT text required" constraint on every image field (accessibility parity with DSFR) and creates the `restricted_html_dsfr` text format plus a matching CKEditor 5. It depends on `dsfr_twig_components`, `form_options_attributes` and `style_selector`, and expects the separate DSFR theme (drupal.org/project/dsfr) to be present. This copy is a Git dev checkout of the 2.1.x branch (no packaged release version).

---

- Install the shared base for a DSFR-themed Drupal site (`drush en dsfr_core -y`) before enabling dsfr_block, dsfr_menu or dsfr_paragraph.
- Land on `/admin/dsfr` to see whether the DSFR theme is present and active and get quick links to each installed child module.
- Use `/admin/dsfr/theme` to jump straight to the DSFR parent theme's settings page (redirects only if the theme exists).
- Open `/dsfr/get-started` for the DSFR theme's welcome/get-started content.
- Browse the full DSFR icon set at `/admin/dsfr/icons` (or `/dsfr/icons/{slug}`) with a searchable Preact picker that shows copy-ready markup.
- Browse the DSFR pictogram set at `/admin/dsfr/pictograms` (or `/dsfr/pictograms/{slug}`) the same way.
- Pre-filter the icon or pictogram browser by passing a search term as the URL slug.
- Regenerate the icon list JSON consumed by the picker via `/dsfr/generate/icons`.
- Regenerate the pictogram list JSON via `/dsfr/generate/pictograms`.
- Report the install status of every DSFR field for an entity type via `/admin/dsfr/fields/{slug}` (defaults to `block_content`).
- Let sibling modules define DSFR fields once: `FieldStorage::fieldData()` centralises ~60 field definitions (alerts, buttons, cards, colors, margins, links, paragraphs, media, etc.).
- Have sibling modules install those field storages/instances programmatically through `FieldManage::installFieldsStorage()` / `createFields()` / `displayFields()` / `viewFields()`.
- Create a consistent DSFR-safe rich-text format (`restricted_html_dsfr`) with a curated allowed-HTML list and CKEditor 5 toolbar via `FilterEditor::createFilterEditor()`.
- Reuse `Tools::checkTheme()` / `checkThemeActivated()` to detect the DSFR theme from any DSFR module.
- Reuse `Tools::checkModules()` to detect which sibling DSFR modules are enabled and build links to their routes.
- Reuse `Tools::checkDrupalVersion()` to branch CKEditor 5 config between Drupal 9 and 10/11.
- Use `Tools::path()` and `Tools::msg()` as small helpers for route-URL generation and messenger output across DSFR modules.
- Provide the standard DSFR set of colour options and spacing/margin classes to field widgets via `FieldStorage::colors()` / `colorsSimple()` / `margin()`.
- Automatically drop the mandatory image ALT requirement on install to match DSFR accessibility handling.
- Attach the DSFR colour-selector library to all forms site-wide via `hook_form_alter()`.
- Serve French interface translations shipped in `translations/dsfr_core-fr.po`.
- Provide theme hooks (`dsfr_settings`, `dsfr_get_started`, `_icons`, `_pictograms`) that child modules and templates can render.
