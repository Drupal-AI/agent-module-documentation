<!-- SPDX-License-Identifier: GPL-2.0+ -->
# Disable a field's widget on add / edit forms

No configure route (`configure: null`) and no global settings page. You configure it
**per field**, and the settings are stored as **third-party settings** on that field's config
entity. The UI only appears for users with `administer disable field settings`.

## The four modes (independently for add and edit)

Stored keys: `add_disable` / `edit_disable` (string), `add_roles` / `edit_roles` (array of
role ids). The `*_disable` value is one of:

| Value | Effect on that form |
|---|---|
| `none` | Field enabled for all users (default). |
| `all` | Field disabled for all users. |
| `roles` | Field **disabled** for users who have any of the listed roles. |
| `roles_enable` | Field **enabled only** for users who have any of the listed roles (disabled for everyone else). |

"Add" = the entity has no id yet (`$entity->id()` empty); "edit" = it already exists.

## Where it is stored

For a configurable field: `field.field.<entity_type>.<bundle>.<field_name>`:

```yaml
third_party_settings:
  disable_field:
    add_disable: none
    edit_disable: all
    # edit_roles / add_roles only present for roles / roles_enable modes:
    # edit_roles: [editor, administrator]
```

For a **base field** (e.g. `title`) it is `core.base_field_override.<entity_type>.<bundle>.<field>`
with the same `third_party_settings.disable_field` shape (schema
`core.base_field_override.*.*.*.third_party.disable_field`).

## Via the UI

1. **Configurable field:** *Structure → Content types → (type) → Manage fields → (field) →
   Edit* (the `field_config_edit_form`). Note: it is on the **field edit** form, not Manage
   form display.
2. **Base field (e.g. title):** enable base-field-override UI, then
   `/admin/structure/types/manage/<type>/fields/base-field-override`.
3. Open **Disable Field Settings**. Under *"Disable this field on add content form?"* and
   *"...edit content form?"* pick a mode and, for the role modes, select roles.
4. **Save**. (README note: clear caches once after first enabling the module.)

## Scriptable (drush php:eval)

```php
use Drupal\field\Entity\FieldConfig;
$fc = FieldConfig::loadByName('node', 'article', 'field_x');
$fc->setThirdPartySetting('disable_field', 'add_disable', 'none');
$fc->setThirdPartySetting('disable_field', 'edit_disable', 'all');
// role modes only:
$fc->setThirdPartySetting('disable_field', 'edit_disable', 'roles');
$fc->setThirdPartySetting('disable_field', 'edit_roles', ['editor']);
$fc->save();
```

Read back:
```bash
drush cget field.field.node.article.field_x third_party_settings.disable_field
```
Or PHP: `$fc->getThirdPartySetting('disable_field', 'edit_disable')`. To clear, use
`unsetThirdPartySetting('disable_field', 'edit_roles')` and set `*_disable` back to `none`.

## How it is applied (runtime)

`disable_field_field_widget_complete_form_alter()` runs for every widget on an entity form. It
skips the field-config edit form itself, requires an `EntityFormInterface`, then reads the
field's `disable_field` third-party settings, picks `add`/`edit` by whether the entity has an
id, and for `roles` / `roles_enable` compares `\Drupal::currentUser()->getRoles()` against the
configured roles. When the field should be locked it sets
`$field_widget_complete_form['#disabled'] = TRUE`. This disables the widget in the browser
only; a disabled input is not submitted, so the stored value is preserved.

## Config schema

`config/schema/disable_field.schema.yml` defines
`field.field.*.*.*.third_party.disable_field` and
`core.base_field_override.*.*.*.third_party.disable_field`, each mapping `add_disable` (string),
`add_roles` (sequence), `edit_disable` (string), `edit_roles` (sequence).
