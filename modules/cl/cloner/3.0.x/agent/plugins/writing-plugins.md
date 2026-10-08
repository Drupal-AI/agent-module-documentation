<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Writing Cloner plugins

Cloner defines three plugin types. All support dependency injection (managers use
`ContainerFactory`). Discovery is annotation-based (`@Annotation` classes in `src/Annotation/`); the
plugin manager for a type scans `Plugin/Cloner/{CamelType}/` under every module's namespace.

## Manager mechanics (`Plugin/ClonerPluginManager`)

One class, instantiated three times (`cloner.services.yml`) with a type string: `content_entity`,
`config_entity`, `form`. For a type it derives: plugin dir `Plugin/Cloner/{Camel}`, expected
interface `Cloner{Camel}PluginInterface`, annotation `Drupal\cloner\Annotation\Cloner{Camel}`, cache
bin `cloner:{type}`, alter hook `cloner_plugin_{Camel}`. The `form` type adds defaults
`enabled: TRUE`, `weight: 0`, `cloner_plugin_id: NULL`, `cloner_plugin_type: NULL`.

`isApplicable(EntityTypeInterface, EntityInterface)` on the manager works **only for the `form`
type**: it loops all form-plugin definitions, calls each plugin class's static `isApplicable()` for
the given entity, keeps the enabled ones, and returns them sorted by `weight` (via
`SortArray::sortByWeightElement`). Callers (`ClonerCloneForm`, `EntityOperation`) `array_shift` the
first — so **higher weight wins**.

## `@ClonerContentEntity` — content entity cloner

Dir `Plugin/Cloner/ContentEntity/`; extend `ClonerContentEntityClonePluginBase` (which extends
`ClonerClonePluginBase`, a plain `PluginBase` with a default `create()`). Annotation props: `id`
(required), `label` (required). One required method:

```php
public function cloneEntity(EntityInterface $entity_source, EntityInterface $entity_destination, array $context = []): void
```

- `$entity_source` — the original.
- `$entity_destination` — the `createDuplicate()` of the source (the module makes it and saves it
  afterwards; you only mutate it).
- `$context` — extra data; when invoked from a clone form, `$context['form_state']` holds the
  submitted `FormStateInterface`.

The base does nothing by default — you decide what to change (title, references, owner, etc.). If you
change nothing, the clone is a verbatim field-for-field copy.

## `@ClonerConfigEntity` — config entity cloner

Dir `Plugin/Cloner/ConfigEntity/`; extend `ClonerConfigEntityClonePluginBase`. Same annotation
(`id`, `label`) and same `cloneEntity()` signature. **You MUST set a new unique id** on the
destination — config entities have string ids. The base adds `getDefinitionKey($entity, $key)` →
returns the entity type's key name (e.g. the `id`/`label` key) via `entity_type.manager`, so you can
`$entity_destination->set($id_key, $new_id)`. This base overrides `create()` to inject
`entity_type.manager`.

## `@ClonerForm` — the UI plugin

Dir `Plugin/Cloner/Form/`; extend `ClonerFormPluginBase`. Annotation props:

| prop | req | meaning |
|------|-----|---------|
| `id` | yes | plugin id |
| `label` | yes | label |
| `cloner_plugin_type` | yes | `content_entity` or `config_entity` — which cloner runs on submit |
| `cloner_plugin_id` | yes | the id of that content/config cloner plugin |
| `entity_operation_label` | no | if set, a "Clone" operation link is added to matching entities |
| `enabled` | no | default TRUE; set FALSE to keep in codebase but disable |
| `weight` | no | default 0; higher weight wins when several plugins are applicable |

Methods:
- `static isApplicable(EntityTypeInterface, EntityInterface): bool` — **default returns TRUE**
  (i.e. applies to every entity of every type). Override it to scope to a type/bundle, e.g.
  `$entity_type->id() === 'node' && $entity->bundle() === 'article'`. See the gotcha below.
- `buildForm(array $form, FormStateInterface): array` — required; return the form fields. The source
  entity is available via `$this->getEntity()`.
- `validateForm(&$form, FormStateInterface): void` — optional (base is a no-op).

The base constructor stores the source entity from `$configuration['entity']`; `getEntity()`,
`getClonerPluginType()`, `getClonerPluginId()` read it/the annotation.

### Gotcha: `isApplicable()` defaults to TRUE

Because the default is TRUE, a `@ClonerForm` plugin that does not override `isApplicable()` becomes
applicable to **every entity of every entity type on the site**, adding a clone operation everywhere
and making `/cloner/{any-type}/{any-id}` render. Always override `isApplicable()` to the exact
type(s)/bundle(s) you intend. See [architecture/clone-flow.md](../architecture/clone-flow.md) for
the access implications.
