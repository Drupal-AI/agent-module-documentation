# Configure exposed-form grouping

There is no settings form. You configure it **per view, per display**, on the view's *Exposed form*
settings (Views UI: edit the view → Exposed form → "Enable fieldset around exposed forms?" → build
the drag table). The result is stored in the view config entity.

## Where it is stored

`views.view.<id>` →
`display.<display_id>.display_options.display_extenders.views_ef_fieldset.views_ef_fieldset`:

```yaml
enabled: true
options:
  sort:
    root:                       # the top-level container (always present)
      container_type: details   # container | details (Fieldset) | vertical_tabs
      title: 'Filters'
      description: ''
      open: true
      weight: '0'
      id: root
      pid: ''                   # root has empty parent
      depth: '0'
      type: container
    container-0:                # a container you added
      container_type: vertical_tabs
      title: 'Advanced'
      description: ''
      open: false
      weight: '-6'
      id: container-0
      pid: root                 # nested under root
      depth: '1'
      type: container
    type:                       # an exposed filter placed into root
      weight: '-5'
      id: type
      pid: root
      depth: '1'
      type: filter
    submit:                     # the Submit button
      weight: '-7'
      id: submit
      pid: root
      depth: '1'
      type: buttons
```

`options.sort` is a **flat** map keyed by item id; the tree is reconstructed from each item's `pid`
(parent id) and `weight`. Note numeric-looking values (`weight`, `depth`) are stored as **strings**.

## Item types and ids

| `type` | id source |
|---|---|
| `container` | `root`, or `container-N` for ones you add |
| `filter` | the exposed filter's id (e.g. `type`, `status`); operator elements use `<id>_op` |
| `sort` | `sort_by` and `sort_order` (present when sorts are exposed) |
| `buttons` | `submit`, and `reset` (present when the reset button is enabled) |

`container_type` values map to: `container` (plain `<div>`), `details` (collapsible **Fieldset**),
`vertical_tabs`. `open` sets `#open` on `details`.

## Enabling / editing with drush

Because everything is view config, you can script it:

```bash
# See current grouping for a view's default display:
drush cget views.view.myview display.default.display_options.display_extenders.views_ef_fieldset

# Turn the fieldset grouping on for the default display:
drush php:eval '
  $v = \Drupal\views\Entity\View::load("myview");
  $d = $v->get("display");
  $d["default"]["display_options"]["display_extenders"]["views_ef_fieldset"]["views_ef_fieldset"]["enabled"] = TRUE;
  $v->set("display", $d)->save();
'
```

`enabled` alone wraps nothing useful until `options.sort` describes containers and the placement of
each exposed element; the Views UI table is the practical way to build that tree. After editing
config directly, run `drush cr` so the view is rebuilt.

## Prerequisite

The plugin must be listed in `views.settings` `display_extenders` (the module's install hook adds
`views_ef_fieldset` there). If it was removed, re-add it or the per-view options are ignored.
