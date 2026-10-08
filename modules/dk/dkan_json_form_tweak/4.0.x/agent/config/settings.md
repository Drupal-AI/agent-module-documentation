<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enabling the tweaks (form-display third-party settings)

There is no dedicated settings route. All three tweaks are toggled as third-party settings on an
**entity form display** and are only offered for form displays whose target bundle is `data`
(DKAN's dataset/data-entity bundle).

## Install / enable
```
composer require drupal/dkan_json_form_tweak
drush en dkan_json_form_tweak -y
```
Requires `dkan` and `json_form_widget` already enabled (hard dependencies).

## Where the checkboxes appear
`dkan_json_form_tweak_form_entity_form_display_edit_form_alter()` (`dkan_json_form_tweak.module`) adds a
`DKAN JSON Form settings` fieldset to the Field UI **Manage form display** edit form
(`/admin/structure/…/form-display…`). It only fires when the form object is an
`EntityDisplayFormBase`, the entity is an `EntityFormDisplay`, and `getTargetBundle() === 'data'`.
Access is therefore whatever Field UI already grants for editing that bundle's form display.

Three checkboxes, each bound to a third-party setting under namespace `dkan_json_form_tweak`:

| Checkbox | Setting key | Effect |
|----------|-------------|--------|
| Enable JSON Form navigation | `navigation` | Adds a "Go to property" Bootstrap dropdown (`dkan_json_form_navigation` theme + library). |
| Enable Close button on properties with multiple values | `close_details` | Adds a Close/Open toggle that collapses all `details` under a multi-value property. |
| Show remove checkbox on properties with multiple values | `remove_multivalue` | Adds a per-item "Remove" checkbox that deletes that value on save. |

## Persistence
The entity builder `dkan_json_form_tweak_third_party_settings_node_form_builder()` reads
`dkan_json_form_navigation_settings.{navigation,close_details,remove_multivalue}` from form state.
A truthy value calls `EntityFormDisplay::setThirdPartySetting('dkan_json_form_tweak', <key>, <value>)`;
a falsy value calls `unsetThirdPartySetting(...)` so unchecked options leave no config residue.

## Config schema
`config/schema/dkan_json_form_tweak.schema.yml` types the settings for
`core.entity_form_display.*.*.*.third_party.dkan_json_form_tweak`:
`navigation` (boolean), `close_details` (boolean), `remove_multivalue` (boolean). This makes the
toggles exportable/importable as configuration.

## Runtime gate
`FormBuilder::settingEnabled(FormStateInterface, $setting)` reads the active
`form_display` (an `EntityFormDisplay`) from form-state storage and returns its third-party setting;
if there is no form display it returns `FALSE`, so the tweaks never apply outside a configured
`data` form display.
