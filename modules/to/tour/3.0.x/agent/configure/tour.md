# Configure tours

## The `tour` config entity

A tour is a config entity (`tour.tour.<id>`). `config_export` keys: `id`, `label`,
`routes`, `tips`. Define one in a module's `config/optional/tour.tour.<id>.yml` or author it
in the UI. Example:

```yaml
langcode: en
status: true
dependencies:
  enforced:
    module:
      - my_module
id: my_tour            # [a-z0-9_-]+ (dashes allowed)
label: 'My tour'
routes:
  - route_name: entity.node.add_form
    route_params:      # optional; omit to match the route regardless of params
      node_type: article
tips:
  intro:
    id: intro
    plugin: text       # a tour_tip plugin id
    label: 'Welcome'
    weight: -100       # tips render sorted by weight
    position: bottom   # Popper position (see list below); ignored if no selector
    selector: null     # CSS/DOM selector to anchor to; null = centered modal
    body: 'This is the node add form.'
```

- **routes**: sequence of `{route_name, route_params}`. Route params supported for matching
  include entity `id` (node/taxonomy_term/dashboard), `bundle`, and `taxonomy_vocabulary`
  (see `TourHelper::loadTourEntities()`). Use `<front>` for the front page. Multiple entries
  with the same `route_name` are allowed (e.g. per-node tours).
- **tips**: keyed sequence; each has `id`, `plugin`, `label`, `weight`, `position`,
  `selector`, plus plugin-specific keys (the `text` plugin adds `body`).
- **position** (Popper): `auto`, `auto-start`, `auto-end`, `top`, `top-start`, `top-end`,
  `bottom`, `bottom-start`, `bottom-end`, `right(-start/-end)`, `left(-start/-end)`.
- A tip with `selector: null` renders as a centered modal step.

Schema: `config/schema/tour.schema.yml`. Config translation supported
(`tour.config_translation.yml`).

## Admin UI & routes

Config UI base `/admin/config/user-interface/tour` (all require `administer tour`):

| Route | Path | Purpose |
|---|---|---|
| `entity.tour.collection` | `/` | List tours (the `configure` route) |
| `tour.tour.add` | `/add` | Add a tour |
| `entity.tour.edit_form` | `/manage/{tour}` | Edit tour (routes/modules) |
| `entity.tour.edit_form_tips` | `/manage/{tour}/tips` | Reorder/manage tips |
| `entity.tour.enable` / `.disable` | `/manage/{tour}/enable|disable` | AJAX toggle status |
| `entity.tour.clone_form` | `/manage/{tour}/clone` | Clone a tour |
| `entity.tour.delete_form` | `/manage/{tour}/delete` | Delete |
| `tour.tip.add` | `/manage/{tour}/tip/add/{type}` | Add a tip of a plugin type |
| `tour.tip.edit` / `tour.tip.delete` | `/manage/{tour}/tip/edit|delete/{tip}` | Edit/delete tip |
| `tour.tour_settings` | `/settings` | Global settings form |
| `tour.recap` | `/tour/{tour}/recap` | Recap page (requires `access tour`) |

## Global settings — `tour.settings`

Config object, editable at `/admin/config/user-interface/tour/settings` or via
`drush cset tour.settings <key>`. Defaults from `config/install/tour.settings.yml`:

| Key | Default | Meaning |
|---|---|---|
| `hide_tour_when_empty` | `false` | Hide the Tour button on pages with no tour |
| `display_custom_labels` | `false` | Use custom button text instead of "Tour"/"No tour" |
| `tour_avail_text` | `""` | Button label when a tour is available (if custom labels on) |
| `tour_no_avail_text` | `""` | Button label when none is available |
| `enable_recap` | `false` | Expose a static "recap" page listing a tour's steps |

## Launching a tour

A user with `access tour` on a matching route gets a Tour button in the toolbar
(`hook_toolbar`), or via the `tour_button_block` block, or the Navigation top-bar item
(`tour_topbar`). It can also be triggered with the `?tour` URL parameter or the `alt+t`
hotkey. Rendering is done by `TourViewBuilder` (attaches Shepherd config in
`drupalSettings` and the `tour/tour` library).
