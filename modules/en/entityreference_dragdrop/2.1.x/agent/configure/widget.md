# Configure the Drag & Drop widget

No global settings page (`configure` null). On an entity's **Manage form display**
(`admin/structure/…/form-display`), set an **Entity reference** field's widget to **Drag&Drop** and open
the cog. Settings persist in the `entity_form_display` config entity.

Source: `src/Plugin/Field/FieldWidget/EntityReferenceDragDropWidget.php` (extends core
`OptionsWidgetBase`, `multiple_values = TRUE`).

## Settings (`defaultSettings()`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `view_mode` | select | `title` | How each option renders in both lists: `title` (label markup only) or any view mode of the target entity type. Non-title modes load the entities and render them via their view builder. |
| `available_entities_label` | textfield | `Available entities` | Heading over the left (available) list. |
| `selected_entities_label` | textfield | `Selected entities` | Heading over the right (selected) list. |
| `display_filter` | checkbox | `0` | Show a client-side text filter input above the list. |

`viewModeOptions()` builds the view-mode select from the target entity type's view modes (plus the
built-in `Title`). `settingsSummary()` echoes the four values.

## How values and order are stored

- The widget builds two render arrays — available and selected — from the field's flattened option list
  (`OptGroup::flattenOptions($this->getOptions(...))`). Available = options not currently selected.
- A hidden input `target_id` (class `entityreference-dragdrop-values`) holds the selected entity IDs as a
  comma-separated string; its default is `implode(',', array_keys($selected))`.
- `massageFormValues()` returns `explode(',', $values['target_id'])` (or `[]` when empty), so the order of
  IDs in the hidden field becomes the field's **delta order** — dragging to reorder the selected list
  reorders the stored values.
- A per-instance `key` (`<entity_type>_<bundle>_<field>_<entity_id>`) namespaces the DOM and settings so
  multiple widgets coexist on one form.

## Cardinality handling

- The field's cardinality is passed to JS via
  `drupalSettings.entityreference_dragdrop[<key>] = <cardinality>` (attached on the `target_id` element).
- For a limited (non `-1`) cardinality the widget renders a hidden message
  (`.entityreference-dragdrop-message`) — "This field cannot hold more than N values." — shown by the JS
  when the limit is hit.

## JS / theming

- Library `entityreference_dragdrop/init` (`entityreference_dragdrop.libraries.yml`): `js/…dragdrop.js` +
  `css/…dragdrop.css`, depends on `core/sortable`, `core/drupal`, `core/drupalSettings`, `core/jquery`,
  `core/once`.
- Each list is rendered through the `entityreference_dragdrop_options_list` theme hook
  (`hook_theme()` in `.module`; preprocess `template_preprocess_entityreference_dragdrop_options_list`),
  template `templates/entityreference-dragdrop-options-list.html.twig`. Items carry
  `data-key`/`data-id`/`data-label` attributes the JS uses to move and serialize them; when
  `display_filter` is on, a filter textfield is rendered above the list.

## Set the widget with Drush (example)

```php
// drush php:eval — use the drag&drop widget on node.article field_related, rendered as teasers
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$fd->setComponent('field_related', [
  'type' => 'entityreference_dragdrop',
  'region' => 'content',
  'settings' => [
    'view_mode' => 'teaser',
    'available_entities_label' => 'Available',
    'selected_entities_label' => 'Selected',
    'display_filter' => 1,
  ],
])->save();
```
