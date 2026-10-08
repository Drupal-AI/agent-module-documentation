<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `Autotagger` plugin type

autotagger's whole job is to define one plugin type and invoke every plugin at two moments: when a
**node type form** is built, and when a **node is presaved**. Files under `src/`.

## Pieces

- **Annotation** `Drupal\autotagger\Annotation\Autotagger` (`src/Annotation/Autotagger.php`), extends
  `Plugin`. Properties: `id`, `title`, `description`, `configurable` (bool).
- **Interface** `AutotaggerInterface` (`src/AutotaggerInterface.php`). Methods:
  `label()`, `description()`, `isConfigurable()`, `addFormOptions(&$form, FormStateInterface $form_state, $form_id)`.
  Note: `entityPresave()` is **not** on the interface even though the hook calls it (see caveat).
- **Base class** `AutotaggerPluginBase` (`src/AutotaggerPluginBase.php`), extends `PluginBase`:
  - `label()` / `description()` — cast `pluginDefinition['label'|'description']` to string.
  - `isConfigurable()` — `pluginDefinition['configurable'] === 'true'` (string compare; see caveat).
  - `id()` — reads `pluginDefinition['id']` but **does not return it** (bug; unused in shipped flow).
- **Manager** `AutotaggerPluginManager` (`src/AutotaggerPluginManager.php`), extends
  `DefaultPluginManager`, service `plugin.manager.autotagger` (`autotagger.services.yml`,
  `parent: default_plugin_manager`). Discovery subdir `Plugin/Autotagger`; interface + annotation as
  above; `alterInfo('autotagger_info')`; `setCacheBackend($cache, 'autotagger_plugins')`.

## How plugins get invoked (`src/Hook/AutotaggerHooks.php`)

`AutotaggerHooks` is a plain service (constructor-injected `AutotaggerPluginManager`,
`autowire: true`). `autotagger.module` exposes `#[LegacyHook]` shims that delegate to it.

- **`formAlter($form, $form_state, $form_id)`** (`#[Hook('form_alter')]`): iterates
  `$manager->getDefinitions()`, `createInstance()`s each plugin, and calls
  `$plugin->addFormOptions($form, $form_state, $form_id)`. Runs on **every** form — the plugin itself
  must early-return on forms it does not care about.
- **`nodePresave(NodeInterface $node)`** (`#[Hook('node_presave')]`): iterates all plugin definitions,
  `createInstance()`s each, and calls `$plugin->entityPresave($node)`.
- **`help($route_name, $route_match)`** (`#[Hook('help')]`): one-line About text on
  `help.page.autotagger`.

## Writing a custom Autotagger plugin

1. Put the class in `Plugin/Autotagger/` of your module, extend `AutotaggerPluginBase`.
2. Add the `@Autotagger(id=…, label=@Translation(…), description=@Translation(…), configurable=…)`
   annotation (attribute discovery is not set up; use the annotation).
3. Implement **`entityPresave(NodeInterface $node)`** — this is required even though it is not on the
   interface, because `nodePresave()` calls it unconditionally on every plugin. Inside it, read your
   config (e.g. node-type third-party settings), decide the tags, and append term references.
4. If you need settings, implement `addFormOptions()` to inject fields into
   `node_type_add_form` / `node_type_edit_form`, and register an `#entity_builders` callback that
   writes them with `$node_type->setThirdPartySetting('autotagger', '<your_key>', …)`. Add a
   matching `node.type.*.third_party.autotagger` schema key.
5. Append tags without clobbering existing ones: read the destination field, dedupe by `target_id`,
   `appendItem(['target_id' => $tid])`.

The bundled `autotagger_search_in_text` plugin is the reference implementation of all of the above.
