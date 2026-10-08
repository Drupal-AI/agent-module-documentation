# Settings

Config `autosave_form.settings` (schema `config/schema/autosave_form.schema.yml`), form at
`/admin/config/content/autosave_form` (route `autosave_form.admin_settings`). A second
config object `autosave_form.messages` holds conflict alert text.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `interval` | int (ms) | 60000 | How often autosave fires. |
| `only_on_form_change` | bool | FALSE | Only autosave if the form changed (experimental). |
| `active_on.content_entity_forms` | bool | TRUE | Autosave content entity forms. |
| `active_on.config_entity_forms` | bool | FALSE | Autosave config entity forms. |
| `notification.active` | bool | TRUE | Show a toast on each autosave. |
| `notification.message` | text | "Saving draft..." | Toast text. |
| `notification.delay` | int (ms) | 1000 | Toast duration. |
| `allowed_content_entity_types` | sequence | `{}` | Per-entity-type map of allowed `bundles` (empty = all covered types). |
| `allowed_new` | bool | TRUE | Also autosave create (new-entity) forms. |

`autosave_form.messages.entity_saved_in_background_alert_message` — alert shown when the
entity was saved elsewhere while the user was editing.

```
drush config:set autosave_form.settings interval 30000 -y
```
A `ConfigSubscriber` purges stored autosave states when these settings change.
