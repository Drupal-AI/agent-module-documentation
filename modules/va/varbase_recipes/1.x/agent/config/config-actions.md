<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config-action plugins

Nine config actions in `src/Plugin/ConfigAction/`. Each is `final`, carries a
`#[ConfigAction(id: …, admin_label: …, entity_types: […])]` attribute, implements
`ConfigActionPluginInterface` + `ContainerFactoryPluginInterface`, and exposes `apply(string
$configName, mixed $value)`. Recipes invoke them under `config.actions.<config name>.<id>`. All
resolve their target with `ConfigManagerInterface::loadConfigEntityByName()` (or the config
factory) and log to `logger.channel.varbase_recipes`. Most are **idempotent / skip-on-mismatch**
(warn-and-return when the target is missing), so re-applying a recipe is safe. All are marked
`@internal` / experimental.

## CKEditor 5 / text-format actions

- **`mergeAllowedHtml`** (`MergeAllowedHtml.php`, entity_types `filter_format`). Value = an
  allowed-HTML string. Merges tags/attributes into
  `filters.filter_html.settings.allowed_html` instead of replacing it (unlike core
  `simpleConfigUpdate`). Private `mergeAllowedHtml()`/`mergeAttributes()`/`parseAttributes()`
  dedupe tags, union `class` values, override other attrs, and support `drupal-*` custom tags.
  YAML: `filter.format.full_html: { mergeAllowedHtml: '<drupal-media data-media-width> <figure class>' }`.

- **`enableCKEditorPlugin`** (`EnableCKEditorPlugin.php`, `editor`). Value keys: `plugin_id`
  (required), `config` (optional overrides). Initialises a CKEditor 5 plugin that has **no toolbar
  button**. Reads the plugin's `defaultConfiguration()` (via `CKEditor5PluginManagerInterface`) for
  configurable plugins, `array_replace_recursive`s overrides, and writes
  `settings.plugins.<plugin_id>`. No-op if the plugin key already exists. Non-configurable plugins
  store `config` as-is.

- **`addButtonPluginIntoActiveToolbar`** (`AddButtonPluginIntoActiveToolbar.php`, `editor`). Value
  keys: `button_name` (required), `button_index` (`-1` append / `0` prepend / N splice; default
  `-1`), `plugin_name` (optional), `plugin_settings` (optional). Inserts the button into
  `settings.toolbar.items` (skips if present) and optionally registers `settings.plugins.<plugin_name>`.
  Warn-and-return if the editor config is missing.

- **`updatePluginSettings`** (`UpdatePluginSettings.php`, `editor`). Value keys: `plugin_name`
  (required), `plugin_settings`. Replaces `settings.plugins.<plugin_name>` **only if that key
  already exists** — otherwise a no-op (use `enableCKEditorPlugin` first). Asserts the loaded entity
  is an `EditorInterface`.

- **`setCKEditorMediaEmbedVersion`** (`SetCKEditorMediaEmbedVersion.php`, entity_types `*`). Value
  ignored (pass any truthy). Calls `ckeditor_media_embed`'s `AssetManager::getCKEditorVersion()`
  and writes `ckeditor_media_embed.settings.plugins_version_installed`. Install-safe alternative to
  the `ckeditor_media_embed:install` Drush command (which flushes caches). Requires the
  `ckeditor_media_embed` module's classes to be present.

## Field / view / AI actions

- **`setEntityReferenceHandler`** (`SetEntityReferenceHandler.php`, `field_config`). Value keys:
  `handler` (required plugin id string, e.g. `default:taxonomy_term`), `handler_settings` (optional,
  merged into existing). Rewrites the field's `handler` and `array_merge`s `handler_settings`,
  preserving existing keys. Warn-and-return if not a `FieldConfigInterface`.

- **`setAiContextItemsDefaultScope`** (`SetAiContextItemsDefaultScope.php`, no entity_types —
  attaches to `ai_context.scope_settings.*` config). Value = list of scope values. Scope id is
  parsed from the config name after prefix `ai_context.scope_settings.`. Because recipe config
  actions run **before** the content step, `apply()` registers an in-process listener on
  `RecipeAppliedEvent`; the listener loads every `ai_context_item` whose `scope` is still empty and
  calls `setScopeValues($scope_id, $values)`. Works around core's default-content importer being
  unable to write `map` fields with arbitrary keys. Items with a scope are left alone (idempotent).
  YAML: `ai_context.scope_settings.global: { setAiContextItemsDefaultScope: [global] }`.

## Drupal Canvas actions

These target Canvas config entities (`content_template`, `page_region`, `canvas_page`). A base
recipe ships Canvas templates against the base theme; a site template with its own theme uses these
to adapt them without re-declaring the whole tree.

- **`setComponentTreeIfComponentsExist`** (`SetComponentTreeIfComponentsExist.php`). Value =
  `{component_tree: {uuid: {component_id, component_version, inputs, …}}}`. Calls the Canvas
  `ComponentSourceManager::generateComponents()` (referenced by string —
  `Drupal\canvas\ComponentSource\ComponentSourceManager`, only if the service exists), then sets
  the tree **only when every `component_id` already exists** as a `component` entity; otherwise logs
  and skips (a later site-template action wins). Avoids the "config does not exist" install abort a
  plain `simpleConfigUpdate` would cause.

- **`repointComponentTreeToTheme`** (`RepointComponentTreeToTheme.php`). Value = `{theme: <machine>|default}`
  (`default` reads `system.theme:default`). For each `sdc.<theme>.<name>` component in the tree
  whose `sdc.<target theme>.<name>` exists, rewrites `component_id`, re-resolves `component_version`
  to the target's `getActiveVersion()`, and drops any `inputs` key not in the target version's
  `prop_field_definitions` (so a stale pinned prop can't abort the install). Non-SDC and absent
  components are left untouched.

- **`setViewsComponentStyleTheme`** (`SetViewsComponentStyleTheme.php`, `view`). Value =
  `{theme: <machine>|default}`. Across all displays, rewrites the theme part of
  `style.options.component_id` and `exposed_form.options.component_id` (`<theme>:<name>` →
  `<target>:<name>`), keeping the component name. Saves only if something changed.

## Notes

- Assertions (`assert(...)`) guard value shape; under production `assert.exception=0` a malformed
  value degrades rather than throws, but recipes are authored/applied by admins, not end users.
- Config actions run during `drush recipe`, profile install, or a Project Browser recipe apply —
  all admin/CLI operations. There is no runtime route that triggers an action.
