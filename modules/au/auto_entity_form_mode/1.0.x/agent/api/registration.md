<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Form-mode auto-registration

The whole module is one procedural hook in `auto_entity_form_mode.module`.

## Install / enable

`drush en auto_entity_form_mode -y`. No dependencies, no config to set. Behavior applies to every
entity type as soon as the module is enabled and the entity-type definitions are rebuilt (`drush cr`
after adding form modes if they don't appear).

## The hook

```php
function auto_entity_form_mode_entity_type_alter(array &$entity_types) { … }
```

Runs during entity-type build/alter. For each `$entity_type_id => $entity_type`:

1. `\Drupal::configFactory()->listAll('core.entity_form_mode.' . $entity_type_id)` — lists that
   entity type's form-mode config object names directly from config. It uses the **config factory,
   not entity storage**, on purpose: loading the `entity_form_mode` storage here would recurse into
   the entity-type build it is currently altering.
2. For each config object, read `->get('id')` (e.g. `node.my_custom_node_form_display`), coerce to
   string, and `explode('.', $id)` — the **second** segment (`my_custom_node_form_display`) is the
   form-handler key.
3. If `$entity_types[$entity_type_id]->hasHandlerClass('form', $key)` is already true, skip (never
   overrides an existing form class — e.g. `default`, `add`, `edit`, `delete`, or one another module
   registered).
4. Otherwise `setFormClass($key, $entity_types[$entity_type_id]->getFormClass('default'))` — the new
   mode reuses the entity type's **default** form class.

## Using a registered mode in custom code

Once enabled, build a form for any custom mode without your own registration hook:

```php
$form = \Drupal::service('entity.form_builder')->getForm($node, 'my_custom_node_form_display');
```

Which fields show, and in what order, is controlled by the mode's `EntityFormDisplay`
(*Manage form display* for that form mode) — not by this module. The module only guarantees the mode
has a form class so `getForm()` no longer throws
`InvalidPluginDefinitionException: The "<type>" entity type did not specify a "<mode>" form class.`

## Notes

- Because it reuses the `default` form class, validation, submit handling, and core entity/field
  access are identical to the entity's standard add/edit form; the module adds no new access path and
  registers no route, so a mode is reachable only from code that explicitly requests it.
- Kernel coverage: `tests/src/Kernel/AutoEntityFormModeKernelTest.php` asserts that node, taxonomy
  term, and user each gain a form handler for the fixture form modes shipped by the
  `auto_entity_form_mode_test` submodule (`tests/modules/auto_entity_form_mode_test/config/install/`).
- The `tests/modules/auto_entity_form_mode_test` submodule is a test fixture only; it is not a
  shipped feature and should not be enabled in production.
