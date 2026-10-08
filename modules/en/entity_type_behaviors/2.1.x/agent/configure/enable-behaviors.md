# Enabling behaviors + storage internals

No admin settings page. Behaviors are enabled on the **entity-type / bundle edit form**; the module then
adds a `behaviors` base field whose widget you place on the entity's form display.

## Enabling (from the UI)

On a bundle edit form (e.g. a content type), if any behavior plugin targets that entity type, an
"additional settings" **Behaviors** element appears (injected by
`entity_type_behaviors.helper.entity_type_form` in `hook_form_alter`). Toggle "Enable behaviors on this
entity type", pick behaviors, fill each behavior's **config** form, and save. Then export config (the
config file is the source of truth).

## The config object

```
entity_type_behaviors.entity_type_bundle.<entity_type>.<bundle>:
  behaviors:
    <behavior_id>:
      enable: true
      config: <PHP-serialized string>   # schema type: text
```

- Schema: `entity_type_behaviors.entity_type_bundle.*.*` (config_object) → `behaviors` sequence →
  `entity_type_behaviors.settings.[%key]` (base `entity_type_behaviors.settings_base`: `enable` bool,
  `config` text).
- `src/Config/BehaviorConfigFactory.php` reads/writes it; each `config` blob is `serialize()`d and read
  back with `unserialize($blob, ['allowed_classes' => FALSE])` (line 274) — scalars/arrays only, no object
  instantiation. (Config is admin-authored.)
- `getConfiguredEntityTypesAndBundles()` drives which entity types get the base field.

## The dynamic `behaviors` base field

- `hook_entity_type_alter` marks `behaviors` as a serialized field property on configured entity types.
- `hook_entity_base_field_info` adds a base field `behaviors` (field type `entity_type_behavior`,
  **revisionable, translatable**, form-configurable) to each configured entity type.
- `hook_entity_bundle_field_info` creates a `BaseFieldOverride` carrying that bundle's behavior config as
  field settings.
- Field type `entity_type_behavior` (`src/Plugin/Field/FieldType/EntityTypeBehaviorItem.php`): `no_ui`,
  one `value` column, `type: blob`, `size: big`, `serialize: TRUE`, `MapDataDefinition` value.

## The widget `entity_type_behavior_default`

`src/Plugin/Field/FieldWidget/EntityTypeBehaviorWidget.php`: for each enabled behavior (from the field
setting `behaviors`), instantiates the plugin with `entity_type`, `bundle`, that behavior's `config`, and
the item's current `values`, then renders the plugin's `getForm()` inside a `#type => details` (titled by
the plugin label, ordered by weight). A plugin that throws renders an inline "@id behavior caused an error"
message. `massageFormValues()` runs each behavior's `massageValues()` before save. Add this widget to the
entity's **Manage form display** so editors can enter values.

## Install / config-import behavior

- `hook_install` sets the module weight to 1 (its hooks run after others).
- `hook_config_import_steps_alter` adds `entity_type_behaviors_update_behavior_entity_types`, which
  installs/removes behavior base-field schema during config import (via
  `entity_type_behaviors.batch.storage_handler` / `entity_type_behaviors.storage.handler`).
- `hook_uninstall` removes all behavior config.
- Event subscriber `BehaviorStorageConfigEventSubscriber` reacts to behavior config changes to keep field
  storage in sync.
