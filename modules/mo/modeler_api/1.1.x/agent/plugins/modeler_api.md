# Plugin types defined by modeler_api

modeler_api defines **5 plugin types**. Two are the core pair (PHP attributes); three are
YAML-only metadata plugins. Every type supports an `*_info_alter` hook.

| Plugin type | Discovery | Attribute / file | Namespace | Interface / base |
|---|---|---|---|---|
| **Modeler** | PHP attribute | `#[Drupal\modeler_api\Attribute\Modeler]` | `Plugin/ModelerApiModeler` | `ModelerInterface` / `ModelerBase` |
| **ModelOwner** | PHP attribute | `#[Drupal\modeler_api\Attribute\ModelOwner]` | `Plugin/ModelerApiModelOwner` | `ModelOwnerInterface` / `ModelOwnerBase` |
| **Context** | YAML | `MODULE.modeler_api.contexts.yml` | — | `Drupal\modeler_api\Context` |
| **Dependency** | YAML | `MODULE.modeler_api.dependencies.yml` | — | `Drupal\modeler_api\Dependency` |
| **Template Token** | YAML | `MODULE.modeler_api.template_tokens.yml` | — | `Drupal\modeler_api\TemplateToken` |

Managers: `plugin.manager.modeler_api.modeler` / `.model_owner` / `.context` / `.dependency` /
`.template_token`. The Modeler manager is a `FallbackPluginManagerInterface` (fallback id `fallback`).

## The generic component model

Owners and modelers never touch directly — they exchange `Component` value objects typed by
`Api::COMPONENT_TYPE_*` (int constants): `START=1`, `SUBPROCESS=2`, `SWIMLANE=3`, `ELEMENT=4`,
`LINK=5`, `GATEWAY=6`, `ANNOTATION=7`. `Api::COMPONENT_TYPE_NAMES` maps these to YAML keys
(`start`, `subprocess`, …). A model owner declares which types it supports via
`supportedOwnerComponentTypes()`; a modeler maps them to its native elements.

## Modeler plugin (how bpmn_io plugs in)

A **Modeler** provides the visual editor. Declare `#[Modeler(id, label, description)]` on a class
in `Plugin/ModelerApiModeler/` extending `ModelerBase`, and implement `ModelerInterface`. Key methods:

- `getRawFileExtension(): ?string`, `isEditable(): bool`, `generateId(): string`.
- `edit($owner, $id, $data, $isNew, $readOnly): array` — the canvas render array.
- `convert($owner, ConfigEntityInterface $model, $readOnly): array` — lay out an existing entity
  that has no diagram yet.
- `prepareEmptyModelData(string &$id): string` — seed a new, empty model.
- `parseData($owner, string $data): void` then `readComponents(): Component[]` — parse native
  format into generic components; `updateComponents($owner): bool`, `getRawData(): string`.
- `enable/disable/clone($owner, …)`, `configForm($owner): JsonResponse`, and model getters
  `getId/getLabel/getTags/getChangelog/getTemplate/getStorage/getDocumentation/getStatus/getVersion`.

`bpmn_io` (project `bpmn_io`) is exactly such a plugin — its `BpmnIo` class registers id `bpmn_io`
and maps component types to `bpmn:StartEvent`/`bpmn:Task`/`bpmn:SequenceFlow`/etc. **Workflow
Modeler** (`modeler`) is another (React Flow, JSON). To add your own editor, copy one of these.

## ModelOwner plugin (how ECA / AI Agents plug in)

A **ModelOwner** owns config entities and defines their components. Declare
`#[ModelOwner(id, label, description, uiLabelNewModel, uiLabelNewModelWithModeler)]` in
`Plugin/ModelerApiModelOwner/` extending `ModelOwnerBase`, implementing `ModelOwnerInterface`
(large — ~90 methods, most defaulted in the base). The essentials:

- Identity/routing: `configEntityTypeId()`, `configEntityProviderId()`, `configEntityBasePath()`
  (return `NULL` to control routing yourself), `modelIdExistsCallback()`, `settingsForm()`.
- Components: `supportedOwnerComponentTypes()`, `componentLabels()` / `…Plural()`,
  `availableOwnerComponents(int $type)`, `favoriteOwnerComponents()`, `ownerComponent(...)`,
  `ownerComponentId()`, `ownerComponentDefaultConfig()`, `modelConstraints()` (min/max counts and
  successors, incl. `requireConditionWhenParallel`).
- Save cycle (called by `Api`): `resetComponents($model)`, `addComponent($model, Component)`,
  `updateComponent(...)`, `finalizeAddingComponents($model)`, plus `usedComponents()` /
  `getUsedComponents()` (base implements the latter as final).
- Metadata get/set pairs for label, status, version, template, storage, documentation, tags,
  changelog, annotations, colors, swimlanes, model data, modeler id.
- Storage: `defaultStorageMethod()`, `enforceDefaultStorageMethod()`, `storageMethod()`, `storageId()`.
- Opt-in capabilities: `supportsStatus()`, `supportsTemplate()` + `applyTemplate()`,
  `supportsTesting()` + `startTestJob()`/`pollTestJob()`/`cancelTestJob()`,
  `supportsReplayData()` + `getReplayData()`/`getReplayDataByComponent()`.

Known owners: **ECA** (via `eca_ui`) and **AI Agents** (`ai_agents`, uses enforced storage and
`ComponentWrapperPlugin` for non-plugin components).

## The three YAML plugin types

Any module can drop these YAML files (no PHP) to shape the modeling experience for an owner:

- **Context** (`MODULE.modeler_api.contexts.yml`): entries with `topic`, `model_owner`, optional
  `includes`, and `components.<type>.plugins: [...]` to curate which plugins appear per component
  type per use case. Valid `<type>` keys come from `Api::COMPONENT_TYPE_NAMES`.
- **Dependency** (`MODULE.modeler_api.dependencies.yml`): constrains valid component orderings.
- **Template Token** (`MODULE.modeler_api.template_tokens.yml`): defines token trees resolved at
  runtime for model templates.
