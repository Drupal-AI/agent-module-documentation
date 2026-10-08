<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add access conditions to your own entity type

The set of supported entity types is a YAML plugin type (`entity_type_access_conditions`), discovered
by `YamlDiscovery` across all modules. To support a new type, ship a file named
`MYMODULE.entity_type_access_conditions.yml` in your module root:

```yaml
my_entity_type:
  label: 'My Entity Type'
  altered_forms:
    - my_entity_type_add_form
    - my_entity_type_edit_form
  restricted_operations:
    - create
    - update
    - delete
    - view
```

- Top-level key = the **entity type id** whose access/forms you are wiring.
- `label` — human label (translatable via `label`/`label_context`).
- `altered_forms` — form IDs that should get the conditions UI element injected. For a config/bundle
  entity these are usually its add/edit forms; the conditions are stored on the entity the form edits
  (must support `getThirdPartySettings()`).
- `restricted_operations` — operations to gate. For content entities, `create` is enforced via
  `hook_entity_create_access` (resolved through the bundle's plugin definition); `view`/`update`/`delete`
  via `hook_entity_access` on the entity itself.

Definition defaults (plugin manager): `restricted_operations => []`, `altered_forms => []`, default
class `EntityTypeAccessConditionsDefault`.

## Altering the form-id list dynamically
```php
/**
 * Implements hook_entity_type_access_conditions_form_ids_alter().
 */
function my_module_entity_type_access_conditions_form_ids_alter(array &$form_ids): void {
  $form_ids[] = 'some_other_form_id';
}
```
This only adds a form to the "inject the conditions UI here" list; it does not by itself add
`restricted_operations`. There is also `hook_entity_type_access_conditions_info_alter` (plugin alter
hook) to modify discovered plugin definitions.

Remember: conditions are only *enforced* for operations present in a type's `restricted_operations`,
and evaluation delegates to Conditions Helper / core Condition plugins.
