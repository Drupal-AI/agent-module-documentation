<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Frontend Editing

All configuration lives in one config object: **`frontend_editing.settings`**. Three admin
forms write to it.

## Admin routes

| Route | Path | Form |
|---|---|---|
| `frontend_editing.settings_form` (the `configure` link) | `/admin/config/frontend-editing` | `SettingsForm` — widths + preview |
| `frontend_editing.entity_bundle_restrictions` | `/admin/config/frontend-editing/entity-bundle-restrictions` | `EntityTypesBundlesForm` — which bundles are editable |
| `frontend_editing.ui_settings` | `/admin/config/frontend-editing/ui-settings` | `UiSettingsForm` — toggle button, colors, filters |

All three require the `administer frontend editing` permission.

## Enabling frontend editing for a bundle (the important one)

Editability is opt-in per entity-type/bundle, stored under the **`entity_types`** key as a
map of `entity_type_id => [bundle, …]`:

```yaml
# frontend_editing.settings
entity_types:
  node:
    - article
    - landing_page
  paragraph:
    - bp_card
    - bp_image
```

Set it via the *Entity types and bundles* form (checkbox grid), or with drush:

```bash
# read current
drush cget frontend_editing.settings entity_types
# enable frontend editing for node article + page
drush php:eval '$c=\Drupal::configFactory()->getEditable("frontend_editing.settings");
$e=$c->get("entity_types")?:[]; $e["node"]=["article","page"]; $c->set("entity_types",$e)->save();'
```

A bundle absent from this map gets no frontend-editing wrapper or controls.

## Full key reference (`frontend_editing.settings`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `entity_types` | map | `{}` | `entity_type_id: [bundles]` that are editable |
| `sidebar_width` | int | `30` | side panel width (%) in split view |
| `full_width` | int | `70` | width (%) used for the full/preview pane |
| `ajax_content_update` | bool | `true` | refresh edited content in place after save |
| `hover_highlight` | bool | `false` | outline the editable region on hover |
| `automatic_preview` | bool | `false` | re-render the entity in the sidebar as fields change |
| `primary_color` | string | `'#a9a9a9'` | accent color of the editing UI |
| `exclude_fields` | sequence | `{}` | full field names (`node.article.field_x`) to omit from the wrapper |
| `ui_toggle` | bool | `true` | show a floating on/off toggle button |
| `ui_toggle_settings` | map | offsets | `offset_top/bottom/left/right` (strings, px) for the toggle button |
| `action_links_in_viewport` | string | `_none` | how paragraph action links stay in view (`_none` = off) |
| `duplicate_action_links` | map | `{height: 300}` | container height threshold for duplicating action links |
| `filter_add_items` | bool | `true` | show a search filter on the "add paragraph" list |
| `filter_add_items_threshold` | int | `10` | only show that filter when the type count exceeds this |

## Read it back

```bash
drush cget frontend_editing.settings                     # whole object
drush cget frontend_editing.settings sidebar_width
```

## Optional integration

`drupal/all_entity_preview` (a `suggest`, not required) enables previewing unsaved entities
in the sidebar. Excluding fields can also be done in code — see
[../hooks/hooks-and-events.md](../hooks/hooks-and-events.md).
