<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Helper services & static utilities

Services are `autowire`d and the class FQCN is aliased to the `helper.*` id, so type-hint either
the id or the class. Signatures below are the public API (from `src/`).

## `helper.config` — `Drupal\helper\Config`

Programmatic config import/export.

- `updateExisting(bool $update = TRUE): self` / `skipExisting(): self` — behavior for existing config.
- `isExported(string $config_name = 'system.site'): bool`, `getSyncDirectory(): string`.
- `exists(string $name): bool`, `load(string $name)`, `create(string $name, array $data)`, `getData($config)`.
- `importFile($uri, $contents = NULL): void`, `importDirectory(string $dir, array $options = []): void`.
- `importModule(string $module, string $directory = 'install', array $options = []): void`.
- `exportFile(string $name, ?string $dir = NULL, array $options = []): void`,
  `reExportDirectory(...)`, `reExportModule(string $module, string $directory = 'install', array $options = [])`.

## `helper.entity_type` — `Drupal\helper\EntityType`

- `getEntityOptions(string $entity_type_id, ?array $properties = NULL): array` — id => label options.
- `getBundleOptions(string $entity_type_id): array`, `getBundleLabel(string $entity_type_id, string $bundle): string`.
- `getEntityReferenceSelection(string $entity_type_id, ?string $handler = NULL, array $settings = [], ?EntityInterface $entity = NULL): SelectionInterface`.
- `getEntityReferenceFieldSelection(FieldDefinitionInterface $fieldDefinition, ?EntityInterface $entity = NULL): SelectionInterface`.

## `helper.current_entity` — `Drupal\helper\CurrentEntity`

Resolve "the entity in play":
`fromRouteMatch(?RouteMatchInterface, ?string $matchRouteName)`, `fromRequest(Request, ?string)`,
`fromRouteAndParameters(string $routeName, ParameterBag)`, `fromLayoutBuilderContext()`,
`fromContextId(string $contextId)`.

## `helper.entity` — `Drupal\helper\EntityHelper`

- `matchesPath(EntityInterface $entity, string $path, ?string $rel = NULL, array $options = []): bool`.

## `helper.menu` — `Drupal\helper\Menu`

Build render-ready menus from data: `buildMenu($menu_name, $level = 1, $depth = 0, $expand_all_items = FALSE)`,
`buildLinksAsMenu($menu_name, array $links)`, `buildLinkFieldAsMenu($menu_name, FieldItemListInterface $items)`,
`convertLinksToMenuLinks(array $links)`, `getMenuLinkForEntity(EntityInterface $entity, ?string $menu_name = NULL)`,
plus `addLinkOptions()` / `addItemAttributes()`.

## `helper.file` — `Drupal\helper\File`

- `createOrReuseFromUri(string $uri, bool $reuse_existing = TRUE): FileInterface`.
- `getDataUri(string $uri, bool $base_64_encode = TRUE, ?string $mimetype = NULL): string` (the Twig `file_data_uri`).
- static `filterValidFiles(FileInterface $file): bool`.

## `helper.text_format` — `Drupal\helper\TextFormat`

- `addTag(FilterFormatInterface $format, string $tag, array $attributes = [])`, `removeTag(...)`,
  `removeTagAttributes(...)`, `isTagAllowed(...): bool`, `isAttributeAllowed(...): ?bool`.

## `helper.theme` — `Drupal\helper\Theme`

- `isActive(string $theme, bool $check_base_themes = FALSE): bool`, `isDefault(...)`,
  `isBaseTheme(string $base_theme, string $theme): bool`, `setDefault(string $theme): bool`.

## Static utilities (no service)

- `Drupal\helper\ArrayHelper`: `hasValue`, `replaceValue(s)`, `replaceKey(s)`, `addUniqueValue`,
  `removeValue`, `mapKeys`, `filterKeys`, `chunkEvenly`.
- `Drupal\helper\Utility`: `registerUniqueShutdownFunction`, `runBatch`, `runSandboxBatch`,
  `execCommand`, `callPlugin`, `camelCase`, `matchString`.
- `Drupal\helper\Html`: `removeComments($markup): ?string`.
- `Drupal\helper\Field`: `getDuplicateValues(FieldItemListInterface $items, $property = NULL)`.

Other services: `helper.layout_builder` (`Drupal\helper\LayoutBuilder`), `helper.pathauto`
(`Drupal\helper\PathautoHelper`, tagged `module_dependency: pathauto`), `helper.install_profile`,
`twig.extension.helper`.
