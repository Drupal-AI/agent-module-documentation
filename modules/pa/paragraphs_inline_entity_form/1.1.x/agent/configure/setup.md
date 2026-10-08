# Setting up Paragraphs Inline Entity Form

No settings form. Configuration is spread across two shipped config entities plus a text-format
edit. On enable, these install automatically:

- **Embed button** `embed.button.paragraphs_inline_entity_form` (id `paragraphs_inline_entity_form`,
  label "Paragraphs"): `type_id: entity`, `entity_type: paragraph`, `entity_browser: paragraph_items`,
  display plugin `view_mode:paragraph.preview`, `entity_browser_settings.display_review: false`.
  Its `type_settings.bundles` is empty by default → **you must edit it to select which paragraph
  types are embeddable**.
- **Entity Browser** `entity_browser.browser.paragraph_items`: `display: iframe` (100% × 500,
  `auto_open: true`), `widget_selector: single`, single widget `paragraph_entity_form`
  (settings: `entity_type: paragraph`, `bundle: '0'`, `form_mode: default`, `submit_text: Save paragraph`).

## Manual steps (from README)

1. `/admin/config/content/embed` → edit the **Paragraphs** embed type → select the allowed paragraph
   bundles (populates `type_settings.bundles`).
2. `/admin/config/content/formats` → edit the target text format (CKEditor 5):
   - Add the **Paragraphs** embed button to the toolbar.
   - Enable the **"Display embedded entities"** filter.
   - Ensure the `<drupal-entity>` markup (and attributes such as `data-entity-type`,
     `data-entity-uuid`, `data-embed-button`, `data-entity-embed-display`, `data-langcode`,
     `alt`) is in **Allowed HTML tags** — copy from the example module's
     `filter.format.paragraphs_ief_example.yml` if unsure.

## Config schema

`config/schema/paragraphs_inline_entity_form.schema.yml` defines
`entity_browser.browser.widget.paragraph_entity_form` (keys `submit_text`, `entity_type`, `bundle`,
`form_mode`) — the widget's settings.

There is no `configure` route, no `.settings` config object, and no permissions; access is governed
by the underlying Entity Embed / Entity Browser / paragraph create permissions.
