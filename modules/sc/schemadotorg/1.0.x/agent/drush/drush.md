# Schema.org Blueprints — Drush

Commands from `src/Drush/Commands/SchemaDotOrgCommands.php` (annotation-style `@command`).

| Command | Purpose |
|---|---|
| `schemadotorg:create-type <types...>` | Create one or more mappings/types. Each arg is `entity_type:SchemaType`, e.g. `drush schemadotorg:create-type node:Person node:Organization node:Event`, `drush schemadotorg:create-type media:ImageObject media:VideoObject`, `drush schemadotorg:create-type user:Person`. Validated by `createTypeValidate`. |
| `schemadotorg:delete-type <types...>` | Delete mappings/types. Options: `--delete-fields` (also remove the created fields), `--delete-entity` (also remove the bundle/entity). e.g. `drush schemadotorg:delete-type --delete-entity node:Event`. |
| `schemadotorg:download-schema` | Download the current Schema.org CSV data files. |
| `schemadotorg:translate-schema` | Generate translated schema data. |
| `schemadotorg:update-schema` | Update the installed Schema.org data (schema types/properties). |

`create-type`/`delete-type` delegate to `SchemaDotOrgMappingManager` (`createType`/`deleteType`).
