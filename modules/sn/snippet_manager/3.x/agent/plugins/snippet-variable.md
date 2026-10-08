<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin type: `SnippetVariable`

A snippet variable is a plugin whose `build()` render array is injected into the snippet's Twig
context under the variable's name. This is the module's one plugin type.

- Manager: `plugin.manager.snippet_variable` (`SnippetVariablePluginManager`), extends
  `DefaultPluginManager`.
- Discovery dir: `Plugin/SnippetVariable`. Annotation:
  `Drupal\snippet_manager\Annotation\SnippetVariable` (`id`, `title`, `category`; supports `deriver`).
- Interface: `SnippetVariableInterface`; base class: `SnippetVariableBase`.
- Alter hook: `snippet_variable_info` (`hook_snippet_variable_info_alter`). Cache bin key:
  `snippet_variable_plugins`.
- Config: each snippet stores variables as `variables[<name>] = {plugin_id, configuration}`
  (schema `snippet_manager_variable_settings.<plugin_id>` in `config/schema/`).

## Interface / base contract

`SnippetVariableBase` (`src/SnippetVariableBase.php`) provides the plumbing; a plugin typically
overrides:

- `build(): array` — the render array that becomes the Twig context value (required, from
  `SnippetVariableInterface`).
- `buildConfigurationForm()`, `validateConfigurationForm()`, `submitConfigurationForm()`,
  `defaultConfiguration()` — the per-variable settings on the Variables tab.
- `getType()` (label shown in the UI, default "String"), `getOperations()` (extra operation links),
  `calculateDependencies()`, `preDelete()`.
- Plugins needing the owning snippet implement `SnippetAwareInterface` + `SnippetAwareTrait`
  (`getSnippet()`); e.g. `file`, `text`.

## Built-in variable plugins (plugin ids)

- `block` (deriver `BlockDeriver`) — render a block plugin. Config schema `type: ignore`.
- `condition` (deriver `ConditionDeriver`) — evaluate a Condition plugin (boolean-ish context value).
- `display_variant:main_content` — the page main content (`DisplayVariantMainContent`).
- `display_variant:title` — the page title (`DisplayVariantTitle`).
- `entity` (deriver `EntityDeriver`) — render a referenced entity (or one upcast from the route) in a
  view mode; options `entity_id`, `view_mode`, `render_mode` (`entity`/`fields`), **`bypass_access`**
  (render ignoring the entity's view access — trusted-admin option).
- `entity_form` (deriver `EntityFormDeriver`) — embed an entity form (`form_mode`, `bundle`).
- `file` — a managed file (`format`: `generic` file link or `url`). Upload allowlist is broad by
  design (snippet admins are trusted); `#upload_location public://snippet`.
- `form` (deriver `FormDeriver`) — embed an arbitrary Drupal form.
- `layout_region` — declares a region for the `snippet_layout` layout (`label`, `weight`).
- `menu` (deriver `MenuDeriver`) — render a menu (`level`, `depth`).
- `mini_snippet` — an inline Twig template stored on the variable itself (`template`), rendered via
  `inline_template` (same non-sandboxed Twig as the main template).
- `text` — formatted text (`content` = `{value, format}`), rendered via `#type => processed_text`;
  tracks file usage for embedded files.
- `url` — a path turned into a `Url` object (`path`).
- `view` (deriver `ViewDeriver`) — render a Views display (`display`).

## Add a custom variable type

Create `src/Plugin/SnippetVariable/MyVar.php`:

```php
namespace Drupal\my_module\Plugin\SnippetVariable;

use Drupal\snippet_manager\SnippetVariableBase;

/**
 * @SnippetVariable(
 *   id = "my_var",
 *   title = @Translation("My variable"),
 *   category = @Translation("Other"),
 * )
 */
class MyVar extends SnippetVariableBase {

  public function build() {
    return ['#markup' => 'Hello'];
  }

}
```

Add a `snippet_manager_variable_settings.my_var` schema mapping if the plugin stores configuration.
Use a `deriver` to expose one plugin per entity type / view / block, following the `*Deriver` classes
above.
