<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Varbase Bootstrap Paragraphs (varbase_bootstrap_paragraphs) — agent index

A suite of **Bootstrap-grid Paragraph bundles** for building page layouts (rows/columns,
accordion, tabs, carousel, modal, image, view, webform, block, rich text), from the **Varbase**
distribution — a fork of Bootstrap Paragraphs. Ships almost entirely as **installed config**
(paragraph types + fields + view/form displays); the only PHP is one settings form, a set of
theme templates, and a `hook_preprocess_paragraph` that turns per-paragraph styling fields into
Bootstrap classes and a background image.

Core `~11.4.0`. Hard dependency `varbase_media`; auto-installs a long list of contrib
(paragraphs, paragraphs_library/previewer/edit, entity_reference_revisions, field_group, webform,
viewsreference, ckeditor5, advanced_text_formatter, maxlength, link, options, text, block).
Submodule: `vbp_text_and_image`. Configure route: `varbase_bootstrap_paragraphs.settings`
(`/admin/config/varbase/varbase-bootstrap-paragraphs`). One permission. No drush, no plugin types,
no config schema file.

- **Settings form: the "background color" style list + how it drives the `bp_background` field** → [configure/settings.md](configure/settings.md)
- **The paragraph bundles it installs and the shared styling fields on each** → [fields/paragraph-types.md](fields/paragraph-types.md)
- **How per-paragraph styling (width / background / gutter / classes / title) renders** → [theme/styling.md](theme/styling.md)
- **The one permission** → [permissions/permissions.md](permissions/permissions.md)
- **Hooks integrators/themers care about (widget & form alters, preprocess)** → [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Config object: `varbase_bootstrap_paragraphs.settings`, single key `background_colors`
  (a `key|label` textarea; default keys `vbp_color_01`..`vbp_color_05`).
- Settings form: `Drupal\varbase_bootstrap_paragraphs\Form\VarbaseBootstrapParagraphsSettingsForm`
  (form id `varbase_bootstrap_paragraphs_settings`) — on submit it also rewrites the
  `allowed_values` of field storage `paragraph.bp_background`.
- Permission: `administer varbase bootstrap paragraphs settings`.
- 15 paragraph types: `bp_columns`, `bp_columns_two_uneven`, `bp_columns_three_uneven`,
  `bp_column_wrapper`, `bp_accordion`, `bp_accordion_section`, `bp_tabs`, `bp_tab_section`,
  `bp_carousel`, `bp_modal`, `bp_image`, `bp_simple` (Rich Text), `bp_view`, `bp_webform`,
  `bp_block`. Submodule adds `text_and_image`.
- Shared styling fields (bundle-attached): `bp_width`, `bp_background`, `bp_gutter`, `bp_classes`,
  `bp_title`, `bp_title_status`, `bp_image_field`, `bp_link`.
- Theme hooks (`hook_theme`): `paragraph__default`, `paragraph__bp_accordion`, `..._bp_carousel`,
  `..._bp_tabs`, `..._bp_columns_two_uneven`, `..._bp_columns_three_uneven`, `..._bp_image`,
  `..._bp_modal`, plus field templates. Libraries: `vbp-default`, `vbp-default-admin`, `vbp-colors`,
  `vbp-accordion`, `vbp-carousel`, `vbp-image`, `vbp-modal`, `vbp-tabs`.
- Install runs Vardot `ModuleInstallerFactory` (imports optional field/storage config, applies
  entity definition updates, adds role permissions from `config/permissions/`).
