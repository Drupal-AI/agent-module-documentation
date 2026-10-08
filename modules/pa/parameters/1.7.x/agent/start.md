<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Parameters (parameters) — agent index

Define **named, typed configuration values** ("Parameter" plugins) inside exportable
`parameters_collection` config entities, and read them via auto-generated **tokens**, a Twig
**`p()`** function, ECA, or the **`Drupal\parameters\Parameter`** PHP helper. Version **1.7.4**,
core `^10.3 || ^11`, PHP `>=8.1`. GPL-2.0-or-later. No non-core dependencies.

This is **not** a schema-less "arbitrary key/value" store: each value is a typed plugin with its
own config schema (`parameter.string`, `parameter.integer`, `parameter.secret`, …). "Arbitrary
properties" means *you choose which parameters exist*, not that validation is skipped.

## Module layout

- **parameters** (base) — storage, plugin type, tokens, Twig, PHP API. Provides no UI and no
  permissions on its own.
- **parameters_ui** (submodule) — the web UI ("Manage parameters" tab next to Field UI,
  `/admin/config/parameters`) and **all permissions** (`administer parameters`,
  `unlock parameters`, per-entity-type and per-bundle `administer <id> parameters`).
- **parameters_content** (submodule, **deprecated**) — a `content` parameter type backed by a full
  content entity; discouraged for performance reasons. Requires `drupal:serialization`.

## Core mechanism

- **Config entity `parameters_collection`** (`config_prefix: collection`). Ships one `global`
  collection at install; `parameters_ui` adds one collection per fieldable entity bundle
  (id `entity_type.bundle`, e.g. `node.article`). Each collection holds a weight-sorted, name-keyed
  list of parameter plugin configs under its `parameters` key.
- **Parameter plugins** live in `Plugin/Parameter`, discovered via the
  `Drupal\parameters\Attribute\Parameter` attribute and `plugin.manager.parameter`
  (`ParameterManager`). Base class `ParameterBase`; each plugin defines its config schema, form,
  validation and a `getProcessedData()` typed value.
- **Resolution** (`ParameterRepository::getParameter`): builds an ordered collection list from the
  call context (explicit collection, an entity's bundle collection, then `global`), walks the
  requested dotted name from longest to shortest slug, and returns the matching plugin — descending
  into sub-properties for `PropertyParameterInterface` plugins (YAML, HTTP, Icon).
- **Auto-locking**: the first read of a parameter in an unlocked collection calls `lockAndSave()`
  (service parameter `parameters_collection.autolock`, default `true`). Locked collections cannot be
  deleted via UI and their parameters cannot be removed; needs `unlock parameters` to reverse.

## Reading a parameter

- **Token**: `[parameter:global:name]`, `[parameter:node.article:name]`, `[node:parameter:name]`
  (reads the node's bundle collection, falls back to `global`), or bare `[parameter:name]`
  (contextual). Dotted tails address properties: `[parameter:endpoint:foo.bar]`.
- **Twig**: `{{ p('name', node) }}` renders; `{{ p('name', node, 'value') }}` returns the raw value
  (better for conditions). Icons support `{{ p('logo')|set_attribute('fill', '#000') }}`.
- **PHP**: `Parameter::get('name', $entity)` returns the plugin (a `NullObject` if missing);
  `Parameter::value('name', $entity)` returns the processed value; add `'strict'` to throw
  `ParameterNotFoundException` instead.

## Where to look next

- `agent/config/collections.md` — the collection config entity, schema, per-bundle collections,
  locking, and the Secret salt / config-management notes.
- `agent/api/reading.md` — tokens, Twig, the `Parameter` helper, and resolution/fallback semantics.
- `agent/plugins/types.md` — the full parameter type catalog and how to add a custom type.

## Parameter types (plugin ids)

`string` (Raw string), `text` (Formatted text), `integer`, `float`, `boolean`, `datetime`,
`machine_name`, `color`, `options`, `icon` (SVG), `secret` (encrypted), `yaml` (Nested YAML),
`http` (Http endpoint), `increment` (Incrementing integer), `reference` (Referenced parameter),
`types` / `bundles` / `fields` / `roles` (entity/role selections), `null` (Null object), and
`content` (deprecated, from `parameters_content`).
