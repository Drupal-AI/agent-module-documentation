# Configure an entity browser

A browser is the config entity `entity_browser.browser.{name}`. Manage at
`/admin/config/content/entity_browser` (route `entity.entity_browser.collection`,
permission `administer entity browsers`). The edit form is a two-step wizard:
general settings (`.../edit`) → widget settings (`.../widgets`). Config schema:
`entity_browser.browser.*` in `config/schema/entity_browser.schema.yml`.

A browser is assembled from four pluggable parts (see [../plugins/plugin-types.md](../plugins/plugin-types.md)):

- **display** — how it opens: `iframe`, `modal`, or `standalone` (its own page/route).
- **widget_selector** — how you switch widgets: `tabs`, `drop_down`, or `single`.
- **widgets** — the selection sources, ordered by weight: `view` (a Views listing),
  `upload` (file upload), `media_image_upload`, plus `entity_form` (Entity Browser IEF
  submodule `entity_browser_entity_form`).
- **selection_display** — how picked items show before submit: `multi_step_display`,
  `view`, or `no_display`.

Example exported config (`entity_browser.browser.sample.yml`):
```yaml
name: sample
label: 'Sample browser'
display: modal
display_configuration:
  width: 650
  height: 500
  link_text: 'Select entities'
  auto_open: false
widget_selector: tabs
widget_selector_configuration: {  }
selection_display: multi_step_display
selection_display_configuration:
  entity_type: node
  display: label
widgets:
  <uuid>:
    id: view
    uuid: <uuid>
    label: 'Browse content'
    weight: 0
    settings:
      view: content_entity_browser   # a View with an "Entity Browser" display
      view_display: entity_browser_1
```

- The `view` widget requires a View that has an **Entity Browser** display (module
  provides the display, argument-default, field, and filter Views plugins).
- **New in 2.16/2.17:** displays carry a `use_admin_theme` boolean in
  `display_configuration`. For a `standalone` display it makes the browser's page an admin
  route (`_admin_route`). Update hook `entity_browser_update_8202` seeds it from
  `node.settings:use_admin_theme` on existing browsers so behavior is preserved.
- Import with `drush config:import`; browsers are fully exportable/deployable.
- Standalone displays register a route and an auto-generated access permission
  (see [../permissions/permissions.md](../permissions/permissions.md)).
