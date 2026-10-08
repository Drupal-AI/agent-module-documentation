<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AttemptProcessing plugin type

An annotation-based plugin type a consumer module implements to validate or react to attempts.

## Manager & discovery
- Service `plugin.manager.attempt_processing.processor` → `src/Plugin/AttemptProcessingManager.php` (`extends DefaultPluginManager`, `parent: default_plugin_manager`).
- Subdir scanned: `Plugin/AttemptProcessing` in any module's `src/`.
- Interface: `Drupal\attempt_mgmt\Plugin\AttemptProcessingInterface`.
- Annotation: `Drupal\attempt_mgmt\Annotation\AttemptProcessing` — fields `id` (must equal the attempt type) and `provider`.
- Alter hook: `attempt_mgmt_attempt_processing_info`. Cache key: `attempt_mgmt_attempt_processing_plugins`.

## Base class — `src/Plugin/AttemptProcessingBase.php`
`abstract class AttemptProcessingBase extends PluginBase implements AttemptProcessingInterface, ContainerFactoryPluginInterface` (uses `StringTranslationTrait`). Its `create()` injects `entity_type.manager`, `entity_field.manager`, and `attempt_mgmt.factory` (available as `$this->entityTypeManager`, `$this->entityFieldManager`, `$this->attemptFactory`). Default method implementations:
- `setAttemptToActive(array $data): bool` — returns FALSE (override to activate).
- `validateAttempt(array $data, $entity, $user_id, $session_id)` — returns TRUE (override to validate).

## Manager helper
`AttemptProcessingManager::getOptionsList(array $entities = [])` builds an options list of plugins keyed by id → escaped label (`Html::escape`), filtered by the plugin definition's `entities[<entity_type>]` (and optional bundle) mapping.

## Implementing one
1. In your module create `src/Plugin/AttemptProcessing/MyProcessor.php`.
2. Annotate with `@AttemptProcessing(id = "<attempt_type_machine_name>", provider = "my_module")`.
3. Extend `AttemptProcessingBase` and override `validateAttempt()` / `setAttemptToActive()` as needed; use `$this->attemptFactory` to create/update attempts.
4. Clear caches. The convention (`id` = attempt type) lets a module resolve the right processor for a host entity's configured attempt type.

Note: the commented scaffolding in `attempt_mgmt.module` (`hook_form_alter`, `hook_entity_view`) shows the intended lookup (`plugin_id = 'attempt_' . entity_type . '_' . bundle`) but is not active — driving logic lives in the consumer module (e.g. scorm_field).
