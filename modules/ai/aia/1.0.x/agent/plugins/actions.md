<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AiaAction plugin type & the seven actions

## Plugin type
- Namespace: `Plugin/AiaAction`. Attribute: `Drupal\aia\Attribute\AiaAction(id, label, description?, deriver?)` (legacy annotation `Drupal\aia\Annotation\AiaAction` also supported).
- Manager: `aia.action_manager` = `AiaActionManager extends DefaultPluginManager` (cache key `aia_action_plugins`, alter hook `aia_action_info`).
- Interface: `Drupal\aia\Action\AiaActionInterface`; base: `AiaActionBase extends PluginBase` (holds `userIntent`, injects `aia.ai_request_service`, `aia.structured_response_validator`, `aia.diff_generator`).
- Each concrete plugin implements `ContainerFactoryPluginInterface` and additionally injects `entity_type.manager`, a field-type manager where relevant, and its own `*_payload_validator` service.

Contract methods every action implements: `buildContext()`, `buildPrompt()`, `validateResponse()`, `generateDiff()`, `executeDryRun()`, `apply()`, `setUserIntent()/getUserIntent()`, `label()`. Dry-run must be side-effect free; `apply()` must only run after a successful dry-run.

## The seven action plugins (`src/Plugin/AiaAction/`)
| id | class | applies to | payload keys | writes |
|----|-------|-----------|--------------|--------|
| `generate_content_type` | `GenerateContentTypeAction` | node | `machine_name`, `label`, `description?`, `fields[]` | `node_type` + `field_storage_config`/`field_config` + form & view display components |
| `add_field` | `AddFieldAction` | node | `content_type`, `field_name`, `label`, `type`, `required?`, `cardinality?` | one field (storage if new + instance) on an existing content type |
| `generate_taxonomy` | `GenerateTaxonomyAction` | taxonomy | `machine_name`, `label`, `description?`, `terms[]` | `taxonomy_vocabulary` + `taxonomy_term`s |
| `generate_view` | `GenerateViewAction` | views | `machine_name`, `label`, `entity_type`, `bundle`, `displays[]`, `fields[]` | a `views.view.*` config entity |
| `generate_block` | `GenerateBlockAction` | block_content | `block_type`, `info`, `body`, `body_format?`, `reusable?` | a `block_content` entity |
| `generate_menu` | `GenerateMenuAction` | menu | `machine_name`, `label`, `description?`, `links[]` (`title`,`uri`,`weight`,`enabled`,`expanded`,`parent_index`) | a `menu` + `menu_link_content` links (nested via `parent_index`) |
| `generate_paragraph_type` | `GenerateParagraphTypeAction` | paragraphs (optional) | `machine_name`, `label`, `description?`, `fields[]` | a `paragraphs_type` + fields; no-ops/validator-fails if Paragraphs absent |

Field definitions (content type / paragraph / add_field) use: `field_name` (prefix `field_`), `label`, `type`, `required` (bool), `cardinality` (1 or -1). `GenerateContentTypeAction` maps each field type to sane default storage/instance settings, widget, and formatter (see its `getFieldStorageSettings()`/`getDefaultWidget()`/`getDefaultFormatter()` maps).

## Validators (`src/Validation/`)
`StructuredResponseValidator` validates the `{action, payload}` envelope; each `*PayloadValidator` (ContentType, AddField, Taxonomy, View, Block, Menu, ParagraphType) enforces action-specific business rules and raises `InvalidStructuredResponseException`. Conflict messages contain `already exists` and a quoted name, which the Drush layer detects for interactive auto-increment.

## Adding your own action
Create a class in `Plugin/AiaAction/` with the `#[AiaAction(id:..., label:...)]` attribute extending `AiaActionBase` + `ContainerFactoryPluginInterface`, implement the contract, and (optionally) register a payload validator service. It is auto-discovered by `aia.action_manager` and appears in the UI select, `drush aia:list`, and the router's action set.
