# Configure role descriptions

Descriptions are edited at **`/admin/people/role-description`** (route
`role_description.settings`, permission `administer permissions`), a menu tab under People.
The form (`Drupal\role_description\Form\SettingsForm`, id `role_description_settings`) lists
every user role **except** `anonymous` and `authenticated` (both unset in `buildForm()`),
rendering one 2-row textarea per role. Submit rebuilds the whole map and keeps only
non-empty values.

## Config object

Single config object `role_description.settings`, one key:

| Key | Type | Value |
| --- | --- | --- |
| `role_description` | map | `role_machine_name => description` (plain string) |

`config/install/role_description.settings.yml` ships `role_description: {}` (empty).
`SettingsForm::submitForm()` reads each `roles.<id>.description` value and writes it back
under `role_description`, skipping roles whose textarea is empty — so a role with no
description has no key at all.

Example stored value:

```yaml
role_description:
  administrator: 'The role given to admin users.'
  content_editor: 'The role given to content editors.'
```

## Set without the UI

Drush (one key):

```bash
drush config:set role_description.settings role_description.content_editor 'The role given to content editors.' -y
```

PHP (whole map):

```php
\Drupal::configFactory()
  ->getEditable('role_description.settings')
  ->set('role_description', [
    'administrator'  => 'The role given to admin users.',
    'content_editor' => 'The role given to content editors.',
  ])
  ->save();
```

Read it back with `\Drupal::config('role_description.settings')->get('role_description')` —
this returns the `role_id => description` map, which is exactly what the form_alter hooks
consume (see [../hooks/form-alter.md](../hooks/form-alter.md)).

## Config schema

- `config/schema/role_description.schema.yml` — `role_description.settings` is a
  `config_object` whose `role_description` key is a `sequence` of items typed
  `role_description`.
- `config/schema/role_description.data_types.schema.yml` — defines the `role_description`
  type as a `mapping` of `role` (`machine_name`) + `description` (`text`).

Note: the declared item type is a `role`/`description` mapping, but `SettingsForm` actually
stores each item as a bare description string keyed by role id (see the example above). The
runtime data shape is the flat `role_id => string` map — that is what the hooks read.

## Translation

`role_description.config_translation.yml` registers `role_description.settings` with the
Config Translation UI (base route `role_description.settings`). Because the value is a
`sequence`, core cannot translate it through the UI today; per the module README you
translate by placing per-language override files under a
`config/.../language/<langcode>/role_description.settings.yml` directory, overriding only the
role keys you want. `config_translation` is a hard module dependency.
