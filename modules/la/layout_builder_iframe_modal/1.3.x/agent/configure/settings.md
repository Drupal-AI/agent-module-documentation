# Configure — settings & routes

All behavior lives in a single simple-config object. There are **no entities or plugins**.

## Config object

`layout_builder_iframe_modal.settings` (schema type `config_object`, `FullyValidatable`):

| Key | Type | Meaning | Install default |
|---|---|---|---|
| `layout_builder_iframe_routes` | sequence of route-name strings | The built-in Layout Builder routes that open in the iframe modal | all 10 routes below |
| `custom_routes` | sequence of route-name strings | Extra dialog routes you opt in (must already open in a dialog) | `[]` (empty) |

Both are flat lists of route-name strings. A route opens in the iframe modal when it appears
in **either** list (`IframeModalHelper::isModalRoute()` merges them).

The 10 built-in routes (the full default of `layout_builder_iframe_routes`):

```
layout_builder.configure_section
layout_builder.remove_section
layout_builder.remove_block
layout_builder.add_section
layout_builder.add_block
layout_builder.update_block
layout_builder.move_sections_form
layout_builder.move_block_form
layout_builder.translate_block
layout_builder.translate_inline_block
```

`custom_routes` note: adding a route here only rewrites its dialog to an iframe — the route
must *already* be configured to open in a dialog (`data-dialog-type`), and may need extra
code to work fully. It is for advanced/custom Layout Builder-adjacent routes.

## Settings form

- Route: `layout_builder_iframe_modal.settings`
- Path: `/admin/config/content/layout_builder_iframe_modal`
- Menu: under *Configuration › Content authoring* (`system.admin_config_content`).
- Permission required: `configure layout builder iframe modal` (see permission below).
- Form: `layout_builder_iframe_routes` is a checkboxes element (one per built-in route);
  `custom_routes` is a textarea, **one route name per line**.

## Permission

`configure layout builder iframe modal` — "Configure layout builder iframe modal"
(`restrict access: true`). Gates the settings form only; it does not affect who can use
Layout Builder itself.

## Drush recipes

Read the current config:

```bash
drush config:get layout_builder_iframe_modal.settings
drush config:get layout_builder_iframe_modal.settings layout_builder_iframe_routes
drush config:get layout_builder_iframe_modal.settings custom_routes
```

Set a value (these are sequences, so set via PHP for lists):

```bash
# Enable the iframe modal for ONLY Add block + Update block:
drush php:eval '\Drupal::configFactory()->getEditable("layout_builder_iframe_modal.settings")
  ->set("layout_builder_iframe_routes", ["layout_builder.add_block","layout_builder.update_block"])
  ->save();'

# Add a custom route to the custom_routes list:
drush php:eval '$c=\Drupal::configFactory()->getEditable("layout_builder_iframe_modal.settings");
  $r=$c->get("custom_routes")?:[]; $r[]="entity.node.edit_form";
  $c->set("custom_routes", array_values(array_unique($r)))->save();'

# Restore install defaults (all 10 LB routes, no custom routes):
drush php:eval '\Drupal::configFactory()->getEditable("layout_builder_iframe_modal.settings")
  ->set("layout_builder_iframe_routes", [
    "layout_builder.configure_section","layout_builder.remove_section","layout_builder.remove_block",
    "layout_builder.add_section","layout_builder.add_block","layout_builder.update_block",
    "layout_builder.move_sections_form","layout_builder.move_block_form",
    "layout_builder.translate_block","layout_builder.translate_inline_block"])
  ->set("custom_routes", [])->save();'
```

A single scalar key like this has no `drush config:set` list syntax, so use `php:eval` for
the sequences (or edit the exported YAML and `drush config:import`). Run `drush cr` after
changing config so the altered contextual links / preprocess pick it up.
