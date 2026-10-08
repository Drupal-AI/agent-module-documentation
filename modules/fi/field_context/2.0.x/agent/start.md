<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Context (field_context) — agent index

Ships a single Views **argument default** plugin (`fcmatch`, "Field from route context") that
reads a contextual filter's default value from a chosen field on the **node of the current
route**. Lets one embedded view filter itself by the host node's own field value, with no URL
argument. Depends on core `views`.

No settings page (`configure` null). No permissions, no Drush, no services, no hooks, no
routing. Defines no plugin *type* — it provides one implementation of core Views'
`argument_default` plugin type. Ships only Views config schema.

- **Configure/operate the `fcmatch` plugin inside a view (options, form, runtime, cache)** →
  [views/argument_default.md](views/argument_default.md)

Key facts:
- Plugin class `Drupal\field_context\Plugin\views\argument_default\FieldContext`,
  attribute `#[ViewsArgumentDefault(id: 'fcmatch', title: 'Field from route context')]`,
  `extends ArgumentDefaultPluginBase implements CacheableDependencyInterface`.
- Injects `current_route_match` and `entity_field.manager` (via `create()`).
- Options: `fcftype` (chosen node bundle) plus one `fc<bundle>` per bundle (chosen field name).
  Form builds the bundle→field map from `entityFieldManager->getFieldMap()['node']` and uses
  core `#states` (not AJAX) to reveal the right per-bundle field select.
- `getArgument()` is **node-only**: reads the `node` route param, checks `instanceof
  NodeInterface`, verifies the node has the chosen field, returns `->getString()`; otherwise
  returns NULL (silent fallback to the view's "value not available" behavior).
- Cacheability: `getCacheContexts()` → `['url']`, `getCacheMaxAge()` → `Cache::PERMANENT`.
- Config schema key: `views.argument_default.fcmatch` (sequence of string) in
  `config/schema/field_context.views.schema.yml`. No config/install.
