<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Autotagger (autotagger) — agent index

Plugin **framework** that auto-assigns taxonomy terms to **nodes** on save. Ships **no tagging logic**
of its own — it defines the `Autotagger` plugin type + manager and three hooks that fan out to every
registered plugin. To get any result you must enable a submodule (bundled: `autotagger_search_in_text`)
or write your own plugin. Package `autotagger`. Depends only on core **`taxonomy`** (plugin manager also
uses core `node`). Core requirement `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.5.
No routes, no permissions, no Drush, no settings form.

- **The `Autotagger` plugin type — annotation, base class, manager, how the hooks call plugins, how to
  write your own** → [plugins/plugin-type.md](plugins/plugin-type.md)
- **Bundled submodule** (the only shipped implementation, local substring matcher) →
  [modules/autotagger_search_in_text/1.0.x/agent/start.md](modules/autotagger_search_in_text/1.0.x/agent/start.md)

## What it actually is (from source)

- **Plugin type `Autotagger`** — discovery dir `Plugin/Autotagger`, annotation
  `Drupal\autotagger\Annotation\Autotagger` (keys `id`, `title`, `description`, `configurable`),
  interface `AutotaggerInterface`, base `AutotaggerPluginBase`. Manager
  `AutotaggerPluginManager` (service `plugin.manager.autotagger`, alter hook `autotagger_info`,
  cache key `autotagger_plugins`).
- **Hooks** (OOP, in `src/Hook/AutotaggerHooks.php`, service `autowire: true`; thin
  `#[LegacyHook]` wrappers in `autotagger.module`):
  - `hook_help` — help.page.autotagger prints a one-line About blurb.
  - `hook_form_alter` — loads **all** plugin definitions and calls
    `$plugin->addFormOptions($form, $form_state, $form_id)` on each. Plugins decide which forms to
    act on (the bundled plugin only touches `node_type_add_form` / `node_type_edit_form`).
  - `hook_ENTITY_TYPE_presave` for **nodes** (`autotagger_node_presave` → `nodePresave`) — loads all
    plugin definitions and calls `$plugin->entityPresave($node)` on each.
- **Config schema** — only `node.type.*.third_party.autotagger` with a
  `search_in_text_fields: type: ignore` mapping (`config/schema/autotagger.schema.yml`). No config
  objects, no `config/install`. Tagging config is stored as **node-type third-party settings** under
  provider `autotagger`.

## Important caveats (from source)

- `AutotaggerHooks::nodePresave()` calls `$plugin->entityPresave($node)` on every plugin, but
  `entityPresave()` is **not declared** on `AutotaggerInterface` nor implemented in
  `AutotaggerPluginBase`. A plugin that does not implement `entityPresave()` will fatal on node save.
  Any custom plugin **must** implement it.
- `AutotaggerPluginBase::isConfigurable()` returns `$this->pluginDefinition['configurable'] === 'true'`
  (compares to the **string** `'true'`), while the annotation value is a PHP bool — so it effectively
  always returns FALSE. `AutotaggerPluginBase::id()` has no `return`. Cosmetic in the shipped flow
  (the bundled plugin sets `configurable = false` and drives config from the form directly).
- Node-only in v1 (the presave hook is `node_presave`); the maintainers note v2 targets all content
  entities.

## Security / trust

Core module makes **no network calls**, exposes **no routes/permissions**, and reads/writes only via
the entity + config API. Tagging runs inside `node_presave` under whatever access already gated the
node save; it appends only `target_id`s of already-existing taxonomy terms. No user/remote text is
rendered as markup by this module.
