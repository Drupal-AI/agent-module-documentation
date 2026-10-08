<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setup & configuration

## Admin routes (all require `add stacks entity entities` unless noted)

| route | path | purpose |
|-------|------|---------|
| `stacks.admin` | `/admin/structure/stacks` | Stacks hub (links to management pages) |
| `entity.widget_entity_type.collection` | `/admin/structure/stacks/widget_entity_type` | manage widget bundles (add/edit/delete) |
| `entity.widget_entity.collection` | `/admin/structure/stacks/widget_entity` | saved widgets |
| `entity.widget_extend_type.collection` | `/admin/structure/stacks/widget_extend_type` | manage extend bundles |
| `entity.widget_extend.collection` | `/admin/structure/stacks/widget_extend` | saved extend items |
| `widget_instance_entity.settings` | `/admin/structure/widget_instance_entity/settings` | instance entity settings |
| `stacks.admin.ajax*` | `/admin/structure/stacks/ajax/...` | inline editor AJAX endpoints |

Widget-bundle add/edit form (`WidgetEntityTypeForm`) sets the bundle label and, under
"Advanced Configuration", its **behavior** = a `stacks_widget_type` plugin (`plugin` field;
default `default_widget`). Bundle config is exported as `stacks.widget_entity_type.<id>`.

## Steps to add a page-building field

1. **Add the field**: on a content type, add a field of type **Stacks** (`stacks_type`),
   cardinality **unlimited**.
2. **Choose offered widgets**: Manage form display → the Stacks field's gear
   (`form_widget_type` settings):
   - `bundles` — Enabled widget types (must check ≥1).
   - `bundles_required_pos_locked` — auto-added to every node, fixed position.
   - `bundles_required_pos_optional` — auto-added, editor may move.
3. **Create widget bundles**: Structure → Stacks → manage widget bundles → Add Widget
   Entity Type. Add whatever fields the component needs (image/title/text/etc). Note the
   machine name.
4. **Author templates in your THEME** (never edit the module's copies — Drupal prefers the
   theme's): `stacks/<machine-name-with-dashes>/templates/<machine-name>--<variation>.html.twig`.
   A `default` variation is required. Field values are available as `{{ fields.field_x }}`
   (use Devel `{{ kint(fields) }}` to inspect). Preview images go in a sibling `images/`
   dir: `<variation>.jpg`, `<variation>--<theme-option>.jpg`.
5. **Clear cache** so Drupal discovers new templates/options.

Two example bundles ship and install by default: `text_widget` (Text Widget) and
`custom_html_widget` (Custom HTML Widget), both using `default_widget`.

## `stacks.settings` config object

Installed keys (`config/install/stacks.settings.yml`):
- `content_feed_search_api_index: widgets`
- `content_feed_search_api_fulltext_field: rendered_item`

Two more keys are edited via config export/import (`drush cex`/`cim`), not a UI:

- **`widget_type_groups`** — group bundles under one picker entry. Any bundle whose machine
  name starts with the group key is grouped. Example:
  ```yaml
  widget_type_groups:
    contentfeed: 'Content Feed'
  ```
- **`template_themes_config`** — per-template "theme" style options (extra variable sent to
  the template):
  ```yaml
  template_themes_config:
    <widget_machine_name>:
      <template_machine_name>:
        <theme_value>: <theme_label>
  ```

## Widget Extend bundles

`widget_extend_type` bundles define repeatable sub-item options (fields via Field UI at the
extend-type edit form). Used mainly by the Content List submodule (bundles `link`,
`media_or_file`). Manage at `/admin/structure/stacks/widget_extend_type`.
