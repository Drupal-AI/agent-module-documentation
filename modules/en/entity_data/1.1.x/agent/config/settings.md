<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings (entity_data.settings)

Config object **`entity_data.settings`**. Schema in `config/schema/entity_data.schema.yml`
(type `config_object`); install defaults in `config/install/entity_data.settings.yml`.

| Key | Type | Default | Meaning |
| --- | --- | --- | --- |
| `are_classes_allowed` | boolean | `FALSE` | Whether object values may be unserialized into real class instances. |
| `allowed_classes` | sequence of string | `[]` | Fully-qualified class names permitted when unserializing. |

The update hook `entity_data_update_9301` (`entity_data.install`) seeds both keys for sites upgraded before the
defaults existed.

## How the settings are used

The service `Drupal\entity_data\EntityData::getValue()` reads these values when decoding a serialized row:
if `are_classes_allowed` is `FALSE`, it calls `unserialize($value, ['allowed_classes' => FALSE])`; if `TRUE`,
it passes the `allowed_classes` list instead. Only classes on that list are reconstructed as objects; other
serialized objects decode to PHP's incomplete-class placeholder. This mirrors PHP's documented guidance for
`unserialize()`.

## Form and route

- Form: `Drupal\entity_data\Form\SettingsForm` (`getFormId()` = `entity_data_settings`), a `ConfigFormBase`
  editing only `entity_data.settings`.
- Route: `entity_data.settings` at **`/admin/config/development/entity-data`**
  (`entity_data.routing.yml`), permission `administer site configuration`.
- Menu link: `entity_data.settings` under `system.admin_config_development`
  (*Configuration → Development*), weight 3 (`entity_data.links.menu.yml`).

The form has a checkbox *Is classes allowed?* (`are_classes_allowed`) and a textarea *Allowed classes*
(`allowed_classes`, one class per line, disabled until the checkbox is on). `submitForm()` splits the textarea
on newlines, filters empty lines, and saves the resulting list. Examples shown in the form description:
`Drupal\node\Entity\Node`, `Drupal\taxonomy\Entity\Term`, `Drupal\group\Entity\Group`.

## Operating notes

- No config is needed to store/read scalars or arrays. These settings matter only when you store **objects**
  and need them reconstructed on read.
- Leave `are_classes_allowed` off unless a specific class must be rehydrated; list exactly the classes you
  store.
