# USWDS Ckeditor Integration — agent index

Brings USWDS components into CKEditor 5: a responsive **grid** builder, an **accordion** widget,
USWDS **table** toolbar items + two responsive-table filters, editor default-overrides, and four
**EmbeddedContent** components (Accordion, Alerts, Process List, Summary Box). Requires
`ckeditor5`, `media_library`, `embedded_content`. One permission, config schema, no Drush.

- **Enable plugins/filters on a text format, the grid settings form, the grid dialog flow,
  per-format plugin config, the two table filters** → [configure/setup.md](configure/setup.md)
- **The CKEditor5 plugin classes, the four EmbeddedContent components, theme hooks/templates,
  and the security trace** → [plugins/components.md](plugins/components.md)

Submodule (own docs):
- `uswds_ckeditor_integration_embed` (config-only glue: a `uswds_paragraphs` text format + paragraph
  embeds) → [../../modules/uswds_ckeditor_integration_embed/4.0.x/agent/start.md](../../modules/uswds_ckeditor_integration_embed/4.0.x/agent/start.md)

Key facts:
- CKEditor 5 plugins in `uswds_ckeditor_integration.ckeditor5.yml` →
  `src/Plugin/CKEditor5Plugin/`: `UswdsGrid`, `UswdsAccordion`, `UswdsTableContentItems`,
  `UswdsOverrideDefaults`.
- EmbeddedContent plugins in `src/Plugin/EmbeddedContent/`: `Accordion`, `Alerts`, `ProcessList`,
  `SummaryBox` (each renders a Twig template in `templates/embedded-content/`).
- Filters: `filter_uswds_table_sortable`, `filter_table_attributes` (`src/Plugin/Filter/`).
- Grid settings: form `Settings` at `admin/config/content/ckeditor_uswds_ck_grid`, config
  `uswds_ckeditor_integration.settings`, permission `administer uswds_ckeditor_integration_grid`.
- Grid modal: route `uswds_ckeditor_integration.dialog` (`_permission: access content`) →
  `src/Form/GridDialog.php`.
