# Fields on the `ept_views` paragraph type

Four fields are installed on bundle `ept_views` (entity type `paragraph`). Only the
`field_ept_views_view` storage is shipped by this module; the other three storages come from
`ept_core`. All are defined in `config/install/`.

| Field name | Type | Required | Widget (form display) | Formatter (view display) | Provided by |
|---|---|---|---|---|---|
| `field_ept_views_view` | `viewsreference` | **yes** | `viewsreference_autocomplete` | `viewsreference_formatter` | ept_views |
| `field_ept_settings` | `ept_settings` | no | `ept_settings_default` | `ept_settings_default` | ept_core |
| `field_ept_title` | `text_long` | no | `text_textarea` (rows 2) | `text_default` | ept_core storage |
| `field_ept_text` | `text_long` | no | `text_textarea` (rows 5) | `text_default` | ept_core storage |

## `field_ept_views_view` — the view picker (the core of this module)

- Storage `field.storage.paragraph.field_ept_views_view`: `type: viewsreference`,
  `settings.target_type: view`, `cardinality: 1`, `translatable: true`, module `viewsreference`
  (storage also depends on `views`, `paragraphs`).
- Instance `field.field.paragraph.ept_views.field_ept_views_view`: `required: true`,
  `translatable: false`, and the `settings` block that governs behavior — see
  [configure/paragraph-type.md](../configure/paragraph-type.md):
  - `handler: default:view`, `handler_settings.target_bundles: null`, `auto_create: false`
  - `plugin_types: {block: block}` — display types offered
  - `preselect_views: {}` — empty = any view selectable (set to restrict)
  - `enabled_settings: {}` — empty = no extra per-placement options exposed
- A field value stores at least `target_id` (view machine name) and `display_id`; viewsreference may
  also store serialized `data` (per-placement options) when `enabled_settings` exposes them.

## `field_ept_settings` — ept_core design settings

- Type `ept_settings` (a field type + `ept_settings_default` widget/formatter defined by `ept_core`).
- Holds the shared EPT "Design" options (margins, padding, border, background, container width, title
  wrapper tag, strip-tags toggle, etc.). The paragraph template reads
  `content.field_ept_settings['#object'].field_ept_settings.ept_settings.title_options.*` to decide
  the title wrapper element and whether to strip tags, and ept_core turns the numeric/color values
  into the inline `{{ styles }}` printed at the end of the template.

## `field_ept_title` / `field_ept_text` — optional label + intro

- Both `text_long` with `settings.allowed_formats: {}` (all text formats permitted), depend on the
  core `text` module.
- `field_ept_title` renders inside a heading whose tag/behavior is chosen by the ept_core title
  options; `field_ept_text` is a free intro paragraph rendered above/around the embedded view.

## Set the view display from code

```php
\Drupal::service('entity_display.repository')
  ->getViewDisplay('paragraph', 'ept_views', 'default')
  ->setComponent('field_ept_views_view', [
    'type' => 'viewsreference_formatter',
    'label' => 'hidden',
    'settings' => ['plugin_types' => ['block']],
  ])->save();
```
