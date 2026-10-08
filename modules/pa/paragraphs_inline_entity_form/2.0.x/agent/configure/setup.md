# Setting up Paragraphs Inline Entity Form

No settings form. Configuration is spread across two shipped config entities, a text-format edit,
and a permission grant. On enable, these install automatically:

- **Embed button** `embed.button.paragraphs_inline_entity_form` (id `paragraphs_inline_entity_form`,
  label "Paragraphs"): `type_id: entity`, `type_settings.entity_type: paragraph`,
  `type_settings.entity_browser: paragraph_items`, display plugin `view_mode:paragraph.preview`,
  `entity_browser_settings.display_review: false`. Its `type_settings.bundles` is empty (`{ }`) by
  default → **edit it to select which paragraph types are embeddable**. Per the README, ticking
  *none* leaves all paragraph types allowed.
- **Entity Browser** `entity_browser.browser.paragraph_items`: `display: iframe`
  (`width: 100%`, `height: 500`, `link_text: 'Select Paragraph'`, `auto_open: true`),
  `selection_display: no_display`, `widget_selector: single`, single widget `paragraph_entity_form`
  (settings: `entity_type: paragraph`, `bundle: '0'`, `form_mode: default`,
  `submit_text: 'Save paragraph'`).

## Manual steps (from README)

1. **Choose embeddable bundles.** `/admin/config/content/embed` → edit the **Paragraphs** embed
   button → under *Paragraph type* tick the allowed bundles (populates `type_settings.bundles`).
2. **Add to a text format.** `/admin/config/content/formats` → edit the target CKEditor 5 format:
   - Drag the **Paragraphs** embed button onto the toolbar.
   - Enable the **"Display embedded entities"** filter.
   - If the format limits HTML, allow the `<drupal-entity>` tag and its attributes
     (`alt title data-align data-caption data-entity-embed-display
     data-entity-embed-display-settings data-view-mode data-entity-uuid data-langcode
     data-embed-button data-entity-type`). You may narrow it to this module's button/type with
     `data-embed-button="paragraphs_inline_entity_form" data-entity-type="paragraph"` — this is
     what the example module does.
3. **Grant the permissions.** Easy to miss — skipping it makes the dialog open on **Access denied**
   instead of the paragraph-type selector. At `/admin/people/permissions`, give every editing role:
   - Entity Browser: **Access Paragraph items pages**
     (`access paragraph_items entity browser pages`) — named after the browser, not this module.
   - Filter: **Use the … text format** for the format configured in step 2.

## Config schema

`config/schema/paragraphs_inline_entity_form.schema.yml` defines
`entity_browser.browser.widget.paragraph_entity_form` (keys `submit_text`, `entity_type`, `bundle`,
`form_mode`) — the widget's settings.

There is no `configure` route, no `.settings` config object, and no permissions provided by this
module. Reachability of the embed dialog is governed by the Entity Browser
`access paragraph_items entity browser pages` permission and the text format's *use* permission;
what fields an editor may set on the created paragraph is governed by the underlying paragraph
entity/field access enforced through Inline Entity Form.
