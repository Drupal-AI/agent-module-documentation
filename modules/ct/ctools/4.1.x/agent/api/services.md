# Context, tempstore & access services

Defined in `ctools.services.yml`.

| Service | Class | Use |
|---|---|---|
| `ctools.wizard.factory` | `Wizard\WizardFactory` | Build a multi-step wizard form (see wizard.md). |
| `ctools.context_mapper` | `ContextMapper` | Turn stored context config into `Context` objects; restore entity contexts. |
| `ctools.typed_data.resolver` | `TypedDataResolver` | Resolve a typed-data property path to a context / data definition. |
| `ctools.serializable.tempstore.factory` | `SerializableTempstoreFactory` | Per-user expiring store for serializable objects. **Deprecated** — use core's shared tempstore factory. |
| `ctools.access` | `Access\TempstoreAccess` | Backs the `_ctools_access` route requirement (checks a tempstore lock). |
| `ctools.paramconverter.tempstore` | `ParamConverter\TempstoreConverter` | Load an object out of the shared tempstore for a route parameter. |
| `plugin.manager.ctools.relationship` | `Plugin\RelationshipManager` | Manager for Relationship plugins (see plugins/relationship.md). |

Context helpers (`Drupal\ctools\Context\`):
- `AutomaticContext` — a context that is always available.
- `EntityLazyLoadContext` — a context that loads its entity only when accessed.

```php
$mapper   = \Drupal::service('ctools.context_mapper');   // getContextValues($contexts)
$resolver = \Drupal::service('ctools.typed_data.resolver'); // ->getContextFromProperty('node:uid:entity', $context)
```

Route access example: add `requirements: { _ctools_access: 'TRUE' }` to guard a wizard route with the tempstore lock check.
