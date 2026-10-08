# Subentity framework API

A subentity is an ordinary content entity type whose class extends
`Drupal\subentity\Entity\SubEntityBase` (an abstract subclass of `ContentEntityBase` — it adds no
methods; it is only a marker so the module can find "subentity" types). What makes it a subentity is
the set of handlers you wire in its `@ContentEntityType` annotation. You define the type in your own
module — the module ships no concrete types.

## Handlers to wire in the entity annotation

| Handler key | Class | Purpose |
|---|---|---|
| `access` | `Drupal\subentity\ReferencedEntityAccessControlHandler` | Derives access from the parent that references the subentity (see below). |
| `parent` | `Drupal\subentity\Entity\EntityParentHandler` | Custom handler; finds reference-field storages that target this type. |
| `route_provider.html` | `Drupal\subentity\EntityHtmlRouteProvider` | Adds `entity.<id>.add_form` and `<id>.settings` routes on top of core admin routes. |
| `list_builder` | `Drupal\subentity\Entity\Controller\ReferencedEntityListBuilder` | Admin listing with an extra **Parent** column (id, uuid, label, parent link). |
| `form.default` / `.add` / `.edit` | `Drupal\subentity\Form\ReferencedEntityForm` | Content entity form; success messages only. |
| `form.settings` | `Drupal\subentity\Form\EntitySettingsForm` | Placeholder settings page (used as `field_ui_base_route` target for bundle-less types). |

Set `admin_permission = "administer subentities"`. Add-form / edit / delete routes are gated by
`_entity_access` (→ the access handler); the collection route the generator writes requires the
`administer subentities` permission.

For a **bundleable** subentity, define a companion `@ConfigEntityType` (`..._type`) with
`list_builder = Drupal\subentity\BundleListBuilder`, `form.add`/`.edit = Drupal\subentity\Form\BundleForm`,
and `route_provider.html = Drupal\subentity\BundleHtmlRouteProvider` (adds collection + add-form routes).

## Access model (the important part)

A subentity has **no permission of its own**; access is inherited from any parent entity that
references it. `ReferencedEntityAccessControlHandler`:

- `checkAccess($entity, $op, $account)`: asks the `parent` handler for all reference-field storages
  targeting this type, runs an access-checked (`->accessCheck()`, i.e. TRUE) entity query per parent
  type to find parents whose reference field's `target_id` equals this subentity's id, loads them,
  and for each parent calls `$parent->access($op)`. Returns `AccessResult::allowed()` (with cache
  dependencies on both parent and subentity) as soon as **one** parent grants `$op`; otherwise
  `AccessResult::neutral()` (i.e. no grant — an orphan subentity with no referencing parent is not
  accessible).
- `checkCreateAccess($account, ...)`: returns `allowed()` if the account can create **any** bundle of
  **any** entity type that has a reference field targeting this subentity type, else `neutral()`.

`EntityParentHandler::getStorageByEntityType()` builds that parent map: it queries
`field_storage_config` for enabled fields of type `entity_reference` or
`entity_reference_revisions` whose `settings.target_type` equals this entity type id, then groups the
returned `FieldStorageConfig` objects by their host entity type. So attaching a subentity to a parent
is done simply by adding an entity-reference field on the parent that targets the subentity type.

## Installing a generated type's schema

Defining the class is not enough — the base table must be created. Use the helper service:

```php
// Service id is the fully-qualified class name (autowired).
\Drupal::service(\Drupal\subentity\Services\SubentityHelper::class)
  ->installSubentity('my_subentity');   // machine name of the entity type
```

`installSubentity()` clears cached entity definitions, loads the definition, and calls
`EntityDefinitionUpdateManagerInterface::installEntityType()`. The Drush generator emits a
`hook_update_N` that calls exactly this, so `drush updb` after generating installs the schema.
