<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure: Entity Export settings

Settings form `Drupal\eme\Form\EmeSettingsForm` at route `eme.settings`
(`/admin/config/development/entity-export/settings`, permission
`manage content export settings`). It edits config object **`eme.settings`**.
These are only *defaults* used when an export does not override them on the
export form / Drush call; changing them does not touch already generated modules.

## Config object `eme.settings`

| Key | Type (schema) | Meaning | Default |
|---|---|---|---|
| `eme_id` | string, nullable | Base ID. Drives the generated module machine name (`<eme_id>_content`), the migration group and the migration ID prefix. | unset → `eme` (`Eme::ID`) |
| `ignored_entity_types` | sequence of string | Entity-type IDs hidden from the export form and skipped during export. May include type IDs that do not currently exist (the form lets you type an arbitrary machine name to future-proof an export). | `config/optional` ships `['entity_embed_fake_entity']` |

`Eme::getDefaultId()` reads `eme_id` (falls back to `eme`);
`Eme::getModuleName($id)` → `"{$id}_content"`;
`Eme::getModuleHumanName($id)` → `"<Ucfirst id> Content Entity Migration"`;
`Eme::getExcludedTypes()` reads `ignored_entity_types`.

## Set via Drush

```bash
# Base id used for module name / group / id-prefix.
drush config:set eme.settings eme_id my_project -y

# Ignore entity types (0-indexed sequence).
drush config:set eme.settings ignored_entity_types.0 entity_embed_fake_entity -y
drush config:set eme.settings ignored_entity_types.1 path_alias -y
```

## Set via PHP

```php
\Drupal::configFactory()->getEditable('eme.settings')
  ->set('eme_id', 'my_project')
  ->set('ignored_entity_types', ['entity_embed_fake_entity', 'path_alias'])
  ->save();
```

## Notes

- The settings form has an AJAX "Ignore this type" control (`addTypeSubmit` /
  `addTypeCallback`) that appends a typed machine name into the ignored list,
  including non-discoverable types.
- Empty `eme_id` is stored as *cleared* (the key is removed, not saved as `''`).
- `config/optional/eme.settings.yml` is installed only if its dependencies are
  met; the `entity_embed_fake_entity` default guards against exporting Entity
  Embed's placeholder entity.
