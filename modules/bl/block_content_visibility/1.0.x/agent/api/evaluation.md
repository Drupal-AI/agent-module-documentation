<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Base field, hooks, and render-time evaluation

All hooks are attribute-based in `src/Hook/BlockContentVisibilityHooks.php`
(registered as a service in `block_content_visibility.services.yml`).

## The base field

`entityBaseFieldInfo()` (`#[Hook('entity_base_field_info')]`) declares
`visibility_conditions` on `block_content` only: `BaseFieldDefinition::create('string_long')`,
revisionable, non-translatable, cardinality 1, not display-configurable. It is declared **only
after** the storage is installed (checked against
`EntityLastInstalledSchemaRepositoryInterface::getLastInstalledFieldStorageDefinitions()`), which
keeps `hook_uninstall()` from crashing on a dropped column. `string_long` (not `map`) is
deliberate: `MapItem` has no main property, so core's pre-uninstall `hasData()` could not resolve
a storage column. Stored value = JSON string of `array<plugin_id, condition_configuration>`.

## Editing hooks

- `blockTypeFormAlter()` (`#[Hook('block_type_form_alter')]`, from `block_form_alter`): permission
  + `enabled_bundles` gate, then `VisibilityFormBuilder::buildForm()`.
  - `buildForm()`: decodes any stored JSON, builds a `vertical_tabs` group, iterates
    `conditionManager->getDefinitionsForContexts(getAvailableContexts())` minus `disabled_plugins`,
    `ksort`ed. Each plugin gets a `details` tab (`#parents => ['visibility', $plugin_id]`) with an
    `enabled` "Apply this condition" checkbox and the plugin's own
    `buildConfigurationForm()`. Sets `gathered_contexts` temporary value (needed by
    `ConditionPluginBase` context_mapping). Registers the static `entityBuilder` callback.
  - `entityBuilder()` (static): reads `$form_state->getValue('visibility')`, **skips any tab
    whose `enabled` is empty** (primary defense against plugins that mutate config in
    `submitConfigurationForm()`), casts `negate` to bool (workaround for d.o #3114467), runs each
    plugin's `submitConfigurationForm()` into a `ConditionPluginCollection`, then stores
    `$collection->getConfiguration()` (core's default-vs-configured filter) as JSON — or `NULL`
    when empty.
- `formBlockFormAlter()` (`#[Hook('form_block_form_alter')]`): permission-gated notice on the
  block placement form when the underlying `block_content:*` entity has stored conditions. Labels
  are looked up from condition definitions and rendered via an `inline_template` (Twig
  autoescaped); links to the content `edit-form`.

## Render-time evaluation

`blockAccess()` (`#[Hook('block_access')]`): returns `neutral` unless `operation === 'view'` and
the plugin id starts with `block_content:` or `inline_block:`; otherwise delegates to
`Evaluator::access()` (`Access\Evaluator implements EvaluatorInterface`).

`Evaluator::access(BlockPluginInterface $plugin, AccountInterface $account)`:

1. `resolveEntity()` — for `block_content:<uuid>`, `entityRepository->loadEntityByUuid()`; for
   `inline_block:*`, `storage->loadRevision((int) $configuration['block_revision_id'])`. Anything
   else / not found → `NULL` → `neutral`.
2. Decode the field JSON; empty/invalid → `neutral`. Normalize each entry so it carries its `id`.
3. Build a `ConditionPluginCollection`. For each `ContextAwarePluginInterface` condition, apply
   implicit context assignments (`applyImplicitContextAssignments()` wires an unset single-match
   context slot, mirroring `ContextAwarePluginAssignmentTrait`), resolve runtime contexts, and
   `contextHandler->applyContextMapping()`. A `MissingValueContextException` or `ContextException`
   is tracked per-condition, not fatal.
4. If any context is missing → `AccessResult::forbidden(...)`; else
   `AccessResult::forbiddenIf(!resolveConditions($collection, 'and'))` — **all** conditions must
   pass (AND).
5. Add the entity and each condition as cacheable dependencies; return.
6. Any `\Throwable` on the whole path → logged + `AccessResult::neutral()` (fail-soft, never
   crashes the render).

The result is only ever `forbidden` or `neutral`, so this layer can restrict a block but never
grant it — it AND-combines with core's placement-level visibility.
