<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Entity Connect

Two layers: a **global default** (config object) and a **per-field override** (third-party settings on
the field config). A field's own setting wins over the global default.

## Global defaults — `entityconnect.administration_config`

Form: `admin/config/content/entityconnect` (`\Drupal\entityconnect\Form\AdministrationForm`, permission
`administer entityconnect`). Shipped defaults (`config/install/entityconnect.administration_config.yml`):

```yaml
buttons:
  button_add: 1     # show the add (+) button by default
  button_edit: 1    # show the edit (pencil) button by default
icons:
  icon_add: 0       # 0 = text button, 1 = icon
  icon_edit: 0
```

Schema: `config/schema/entityconnect.schema.yml` (`buttons.button_add`, `buttons.button_edit`,
`icons.icon_add`, `icons.icon_edit`, all integers).

## Per-field override — `third_party_settings.entityconnect`

Each `entity_reference` field can override the global visibility on its field-edit form
(*Manage fields* → the reference field), stored under the same shape on the `field.field.*.*.*` config:

```yaml
# field.field.node.article.field_author (excerpt)
third_party_settings:
  entityconnect:
    buttons:
      button_add: 1
      button_edit: 0
    icons:
      icon_add: 1
      icon_edit: 0
```

Schema key: `field.field.*.*.*.third_party.entityconnect` (same mapping as the global config).

Set it in code:

```php
$field = \Drupal\field\Entity\FieldConfig::loadByName('node', 'article', 'field_author');
$field->setThirdPartySetting('entityconnect', 'buttons', ['button_add' => 1, 'button_edit' => 0]);
$field->setThirdPartySetting('entityconnect', 'icons', ['icon_add' => 0, 'icon_edit' => 0]);
$field->save();
```

## Notes

- Only Entity Reference **field storage** fields are targeted — base fields are not supported.
- Buttons appear on the default Entity Reference widgets (autocomplete, select, checkbox/radio).
- Showing a button is not the same as granting create/edit rights — see
  [../permissions/permissions.md](../permissions/permissions.md).
- `entityconnect_install()` grants `administer entityconnect` to every role that already has
  `access administration pages` at install time.
