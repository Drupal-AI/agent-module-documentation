# eca_content plugins

Registers into ECA Core managers.

**Events** (`ContentEntityEvent`, derived per operation): create, presave, insert, update,
delete, and access/view of content entities (all entity types/bundles).

**Conditions** (`src/Plugin/ECA/Condition`): `EntityTypeAndBundle`, `EntityIsNew`,
`EntityExists`, `EntityFieldValue`, `EntityFieldValueEmpty`, `EntityFieldValueChanged`,
`EntityOriginalFieldValue`, `EntityFieldIsAccessible`, `EntityIsAccessible`,
`EntityFormDisplayMode`, `EntityDiff`.

**Actions** (`src/Plugin/Action`): `LoadEntity`, `LoadEntityRef`, `NewEntity`, `SaveEntity`,
`CloneEntity`, `DeleteEntity`, `GetFieldValue`, `SetFieldValue`, `GetDefaultFieldValue`,
`SetNewRevision`, `SetViewMode`, `SetFormDisplay`, `SetValidationError`, `GetEntityTypeList`,
`GetBundleList`, `ListAddEntity`, `ListRemoveEntity`, `EntityDiff`,
`TriggerContentEntityCustomEvent`. Field-update actions share `FieldUpdateActionBase` /
`EcaFieldUpdateActionInterface`.

Config schema: `config/schema/eca_content.schema.yml`,
`eca_content.entity_reference.schema.yml`.
