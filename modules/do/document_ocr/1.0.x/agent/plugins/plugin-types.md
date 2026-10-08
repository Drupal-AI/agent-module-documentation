<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin types: processors & transformers

Document OCR defines two annotation-based plugin types. Both use standard `DefaultPluginManager`
subclasses, cached, with alter hooks.

## Processor plugin type (`document_ocr_processor`)

- Manager: `\Drupal\document_ocr\Plugin\ProcessorManager` (service
  `plugin.manager.document_ocr_processor`). Discovery dir `Plugin/document_ocr/processor`,
  interface `ProcessorInterface`, annotation `@DocumentOcrProcessor`, alter hook
  `document_ocr_processor`, cache key `processor`.
- Annotation (`src/Annotation/DocumentOcrProcessor.php`) keys: `id`, `name`, `group`,
  `extensions` (space-separated file extensions the plugin can read), `config_dialog_width`,
  `requires` (array; recognised values `credentials`, `template`), `supports` (array; recognised
  values `asynchronous`, `store_json`).
- Base class `\Drupal\document_ocr\Plugin\ProcessorBase` (implements `ProcessorInterface`,
  `ContainerFactoryPluginInterface`) injects `tempstore.private`, `file_system`, `logger.factory`
  and uses `TempKeyValTrait`, `UploadPathTrait`. Key methods a plugin overrides:
  - `requirementsAreMet()` — return TRUE only when the underlying library/binary exists (default
    FALSE).
  - `configurationForm()` / `configurationValues()` — build and harvest the processor config form.
  - `getMappingData()` — read `$this->getFile()`, run OCR, and populate options/values via
    `setOption($key,$label)` + `setOptionValue($key,$value)`; return `$this` (a
    `ProcessorInterface`). `Process::saveEntity()` reads back `getValues()`.
  - Async support: `getAsyncMappingData($task)`, `asyncComplete($task)`; helper flags
    `isAsynchronous()` (from `supports:asynchronous`), `isJsonResponse()` (from
    `supports:store_json`), `requireCredentials()`, `requireTemplate()`.
  - Credentials: `getCredentials()` reads the config's stored file path via
    `file_system->realpath()` + `file_get_contents()` + `json_decode()` (Google service-account
    JSON). The path is set by an admin in the processor config entity.

## Transformer plugin type (`document_ocr_transformer`)

- Manager: `\Drupal\document_ocr\Plugin\TransformerManager` (service
  `plugin.manager.document_ocr_transformer`). Discovery dir `Plugin/document_ocr/transformer`,
  interface `TransformerInterface`, annotation `@DocumentOcrTransformer`, alter hook
  `document_ocr_transformer`, cache key `transformer`.
- Annotation (`src/Annotation/DocumentOcrTransformer.php`) keys: `id`, `name`, `group`,
  `description`, `config_dialog_width`, `requires` (e.g. `credentials`), `field_types` (array of
  Drupal field types the transformer is offered for).
- Base class `\Drupal\document_ocr\Plugin\TransformerBase` (implements `TransformerInterface`,
  `ContainerFactoryPluginInterface`) injects `entity_type.manager`, `file_system`,
  `logger.factory`. Key method: `transform($value)` — return the modified value (default:
  identity). Also `setMappingData()`/`getMappingData()` give access to the processor's
  `ProcessorInterface` result (so a transformer can read other extracted properties), and
  `getTransformers()`/`getTransformer($id)` enumerate configured transformer config entities
  (used by the Pipeline transformer).

## How the two types are consumed

`Process::saveEntity()` (`src/Services/Process.php`) walks the mapping's `mapping` array: for each
destination field with a `property`, it takes the processor's extracted value, and if the mapping
row names a `transformer` (a `document_ocr_transformer` config entity id) it loads that entity,
instantiates its plugin, calls `transform()`, then sets the field. A special row transformer
`custom_value` (see `Traits/CustomValueTrait`) substitutes `%property%` tokens instead of running a
plugin.

## Extending

Add a class under `your_module/src/Plugin/document_ocr/processor/` or `.../transformer/` extending
`ProcessorBase`/`TransformerBase` with the matching annotation. Register the config-entity wrapper
by adding a Processor/Transformer config entity through the admin UI (see
[entities/entities.md](../entities/entities.md)). ParamConverters
`paramconverter.document_ocr_processor` / `paramconverter.document_ocr_transformer` resolve plugin
ids in the "new" wizard routes.
