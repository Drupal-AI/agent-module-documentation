<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Adding an editable form field to a view

## Via the Views UI

1. Edit the view (a **Table** format works best) → **Add** → *Fields*.
2. Search for **"Form field: "** — every editable field of the view's entity type is listed
   (help text says "Appears in: &lt;bundle list&gt;").
3. Pick one and configure:
   - **Widget type** — any widget plugin applicable to the field type (AJAX-reloads the settings).
   - **Hide widget title** (default on) / **Hide widget description** (default on).
   - **Fallback view mode** — `- Disabled -` (hide the field entirely when the user cannot edit it)
     or a view mode to render it read-only instead.
   - **Widget settings** — the widget's own `settingsForm()`, plus any
     `hook_field_widget_third_party_settings_form()` additions (invoked with form mode `views_view`).
4. Save. Rows now render widgets and the view grows a **Save** button.

If `views_ui` is not enabled the options form shows only a "Plugin warning" details element —
`buildOptionsForm()` guards on `function_exists('views_ui_build_form_url')`.

## Config shape

```yaml
# views.view.<id> -> display.<display_id>.display_options.fields
form_field_title:
  id: form_field_title
  table: node_field_data          # base table, or data table when translatable
  field: form_field_title         # 'form_field_' . <field_name>
  plugin_id: entity_form_field
  entity_type: node
  label: 'Title'
  plugin:
    type: string_textfield        # widget plugin id
    settings:
      size: 60
      placeholder: ''
    third_party_settings: {}
    hide_title: true
    hide_description: true
    fallback_view_mode: '0'       # '0'/FALSE = disabled
```

Only the `plugin` sub-keys are this module's; everything else is standard Views field config.
Schema: `views.field.entity_form_field`.

Set it programmatically:

```php
$view = \Drupal\views\Entity\View::load('my_view');
$display = &$view->getDisplay('default');
$display['display_options']['fields']['form_field_title'] = [
  'id' => 'form_field_title',
  'table' => 'node_field_data',
  'field' => 'form_field_title',
  'plugin_id' => 'entity_form_field',
  'entity_type' => 'node',
  'label' => 'Title',
  'plugin' => [
    'type' => 'string_textfield',
    'settings' => ['size' => 60, 'placeholder' => ''],
    'third_party_settings' => [],
    'hide_title' => TRUE,
    'hide_description' => TRUE,
    'fallback_view_mode' => '0',
  ],
];
$view->save();
```

Read it back: `drush config:get views.view.my_view display.default.display_options.fields.form_field_title`.

## Which table?

`hook_views_data_alter()` attaches the fields to `$entity_type->getBaseTable()`, unless the entity
type is translatable, in which case it uses `getDataTable()` (falling back to
`<entity_type_id>_field_data`). Getting this wrong is the classic mistake — for nodes it is
`node_field_data`, not `node`. (`views_entity_form_field_update_8001()` exists precisely to repair
views that stored the wrong table.)

Only fields where `$field_definition->isDisplayConfigurable('form')` is TRUE are offered, and the
same `form_field_<name>` entry is shared by all bundles that have that field.

## Runtime behaviour worth knowing

- `getValue()` returns the placeholder `<!--form-item-<field id>--<row index>-->`; the widget is
  injected by Views' form handling, so the **display must render a views form** — a Table style
  display is the safe choice.
- Widgets are instantiated per bundle via `plugin.manager.field.widget` with
  `form_mode => 'views_view'` and `configuration => $this->options['plugin']`. If `type` is empty
  the widget manager falls back to the field type's `default_widget` (`prepare => TRUE`).
- Form element parents are `[<views field id>, <entity id>, <field name>]`, so relationship rows
  each get their own namespace.
- `hide_title` / `hide_description` only add the CSS classes
  `views-entity-form-field-field-label-hidden` / `…-description-hidden` from the
  `views_entity_form_field/views_form` library — they are a styling, not a render, change.
- The whole form is uncacheable (`#cache['max-age'] = 0`, `UncacheableFieldHandlerTrait`).
- `saveEntities()` runs once per relationship and calls `$storage->save()` **only** for entities
  whose field values differ from `loadUnchanged()`; it then messages
  "N &lt;label&gt; saved." and warns with the labels of any that threw.
- Validation violations are flagged onto the individual row widget via `flagErrors()`.
- Known conflict (README): a Views bulk-operations form takes over the submit button and will throw
  validation errors when no checkboxes are ticked — don't combine them on one display.
- Access is enforced per row, but the README warns some entity types (e.g. Commerce product
  variations) do not implement proper access checks — protect the view's page with permissions too.
