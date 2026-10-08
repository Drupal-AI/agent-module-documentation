<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Disable button on Field UI display forms

Everything the module does lives in `disable_field_button.module` (procedural hooks) plus
`src/Hook/DisableFieldButtonHooks.php` (the help hook). There is no config, no routing, no
service, no permission, and no plugin.

## Install / enable

```
drush en disable_field_button -y
```

Only dependency: core **`field_ui`** (declared in `disable_field_button.info.yml`). No settings
form, no config objects, nothing to set up. Uninstall is clean — the module stores no state.

## Where the button appears

`disable_field_button_form_alter($form, $form_state, $form_id)` bails immediately unless:

1. `$form_state->getFormObject()` is an instance of
   `\Drupal\field_ui\Form\EntityDisplayFormBase` (the shared base of the Manage display and
   Manage form display forms — i.e. `EntityViewDisplayEditForm` and `EntityFormDisplayEditForm`),
   and
2. `$form['fields']` is set.

So the button is only ever added on the core Field UI display-editing pages, for example:

- `/admin/structure/types/manage/{bundle}/display` and `…/display/{view_mode}`
- `/admin/structure/types/manage/{bundle}/form-display` and `…/form-display/{form_mode}`
- the equivalent pages for taxonomy terms, users, media, and any other entity type using Field UI.

## How the button is injected

For each field row returned by `Element::children($form['fields'])`, the module calls
`_disable_field_button_find_actions(&$field_row)` to get a **reference** to that row's settings-form
action container. That container (holding core's *Update* / *Cancel* buttons) only exists while the
field's settings edit form is expanded, so the Disable button appears only on the row the editor
has opened. The finder checks, in order:

- `fields/{name}/settings_edit_form/actions`
- `fields/{name}/format/settings_edit_form/actions` (view displays)
- `fields/{name}/plugin/settings_edit_form/actions` (form displays)
- otherwise it walks every child of the row looking for `…/settings_edit_form/actions`.

When found, it appends:

```php
$actions['disable'] = [
  '#type' => 'submit',
  '#value' => t('Disable'),
  '#name' => $field_name . '_plugin_settings_disable',
  '#submit' => ['_disable_field_button_submit'],
  '#limit_validation_errors' => [],
  '#attributes' => ['class' => ['button--danger']],
  '#field_name' => $field_name,
];
```

`#limit_validation_errors => []` skips form validation so the field can be disabled even if other
rows have unsaved/invalid settings. The field machine name is stored in `#field_name` (taken from
the form's own children, never from request input) and the button gets its own `#submit` handler
so it does not run the display form's normal submit.

## What Disable does

`_disable_field_button_submit(&$form, $form_state)`:

1. `$triggering_element = $form_state->getTriggeringElement();` then `$field_name = $triggering_element['#field_name'];`
2. `$form_object = $form_state->getFormObject();` and `$display = $form_object->getEntity();` — the
   `EntityViewDisplay` or `EntityFormDisplay` config entity the form is editing.
3. `$display->removeComponent($field_name);` — removes the component (this is what "disables" it;
   a component absent from the display is treated as disabled).
4. `$display->save();` — persists immediately (no separate Save step).
5. `\Drupal::messenger()->addStatus(t('The %field_name field has been disabled.', …));`

The change is scoped to exactly the display entity (bundle + view/form mode) whose form is open.

## Access

No `hook` here performs an access check, and none is needed: the button and its submit handler
only run inside the core Field UI display forms, which already require the entity type's display
administration permission (e.g. `administer node display`, `administer node form display`,
`administer taxonomy_term display`). A user who can reach the form can already add, remove, and
reorder these same components. The disabled field name is always one of the form's own rendered
rows.

## Help hook

`DisableFieldButtonHooks::help()` (`src/Hook/DisableFieldButtonHooks.php`) uses the
`#[Hook('help')]` attribute and `StringTranslationTrait`. It returns the About/Uses help markup
only for route `help.page.disable_field_button`; empty string otherwise.

## Tests

`tests/src/Functional/DisableFieldButtonTest.php` (BrowserTestBase, group `disable_field_button`)
covers: the button appears on both view and form display pages after pressing a field's
`{field}_settings_edit` button, and that pressing `{field}_plugin_settings_disable` shows the
status message and removes the component from the reloaded display entity.
