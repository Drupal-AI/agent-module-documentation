# Programmatic API

The mediator is the **`modeler_api.service`** service (`Drupal\modeler_api\Api`), the sole
translator between Model Owner and Modeler plugins. Autowired alias:
`Drupal\modeler_api\Api` → `@modeler_api.service`. Also available statically via `Api::get()`.

## `Api` service — key public methods

- `findOwner(ConfigEntityInterface|string $model): ?ModelOwnerInterface` — the model owner plugin
  that owns a config entity (or entity-type id).
- `getModeler(): ?ModelerInterface` — the single non-fallback modeler if exactly one is installed.
- `embedIntoForm(array &$form, FormStateInterface, ConfigEntityInterface $model, string $default_modeler_id): array`
  — embed a modeler canvas into a config-entity form; paired with `validateEmbed()` and
  `buildEntity()`.
- `edit(ConfigEntityInterface $model, ?string $modelerId = NULL, bool $readOnly = FALSE): array`
  and `view($model, ?$modelerId)` — render the editor / read-only view.
- `prepareModelFromData(string $data, string $model_owner_id, string $modeler_id, bool $isNew, bool $dry_run = FALSE, ?ConfigEntityInterface $model = NULL): ?ConfigEntityInterface`
  — **the save-cycle core**: parses raw modeler data, resets the owner's components, adds each back,
  finalizes and returns the populated entity (or validates only when `dry_run` is TRUE).
- `exportArchive(ModelOwnerInterface $owner, ConfigEntityInterface $entity, ?string $archiveFileName = NULL): array`
  and `getNestedDependencies(array &$all, array $deps)` — `.tar.gz` export with resolved config deps.
- `availableOwnerComponents(ModelOwnerInterface $owner, int $type): array`.
- Contexts/dependencies: `getContexts()`, `getContext($id)`, `getContextsByModelOwner($owner)`,
  `getDependencies()`, `getDependency($id)`, `getDependenciesByModelOwner($owner)`.
- `getErrors(): array`, `editUrl(string $type, string $id): Url`, `getRouteByName($name): ?Route`,
  `getParentMenuName($path)`, `prepareGlobalTokens()`, `prepareTemplateTokens($owner)`.

Component type constants live on `Api`: `COMPONENT_TYPE_START|SUBPROCESS|SWIMLANE|ELEMENT|LINK|GATEWAY|ANNOTATION`
(ints 1–7), with `AVAILABLE_COMPONENT_TYPES` and `COMPONENT_TYPE_NAMES` (int → YAML key).

## Other services (`modeler_api.services.yml`)

- `modeler_api.export.recipe` (`ExportRecipe`) — export a model as a full Drupal recipe.
- `modeler_api.update` (`Update`) — bulk-update models when plugins change (backs the Drush command).
- `modeler_api.template_token_resolver` (`TemplateTokenResolver`) — resolve template token trees.
- `modeler_api.param_converter` (`ModelerApiConverter`) — route param converter for models.
- Plugin managers: `plugin.manager.modeler_api.{model_owner,modeler,context,dependency,template_token}`.
  The `model_owner` and `modeler` managers expose `getAllInstances(bool $reload = FALSE)`; the
  context manager adds `getAllContexts()`, `getContext($id)`, `getContextsByModelOwner($id)`.
- List builders: `modeler_api.{context,dependency,template_token}_list_builder`;
  logger channel `logger.channel.modeler_api`.

## Value objects (facts to pass around)

- `Component` — a generic node/edge exchanged between owner and modeler.
- `ComponentColor`, `ComponentSuccessor` — color and outgoing-connection metadata.
- `Context`, `Dependency`, `TemplateToken` — the resolved YAML-plugin objects.

## Alter hooks

Each of the five plugin managers fires an info-alter hook, so other modules can modify discovered
definitions: `hook_modeler_api_modeler_info_alter`, `…_model_owner_info_alter`,
`…_context_info_alter`, `…_dependency_info_alter`, `…_template_token_info_alter`.
(The module ships no `.api.php` file; these come from the managers' `alterInfo()` calls.)
