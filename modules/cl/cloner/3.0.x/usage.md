<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A developer framework for cloning Drupal entities: you write plugins describing exactly how each entity type/bundle is duplicated, optionally exposed as clone forms and entity-operation links. Ships nothing ready-made and has no config UI.

---

Cloner is a plugin-driven entity duplication system aimed at developers. Unlike Entity Clone, which duplicates entities with zero configuration, Cloner does nothing until you write code: it gives you full, code-level control over how a given entity type and bundle is cloned, which is what you want for genuinely complex entities (for example Commerce products whose variations must be cloned alongside the parent). It defines three annotation-based plugin types — `@ClonerContentEntity` and `@ClonerConfigEntity` describe *how* an entity is cloned (you receive the original and a `createDuplicate()` copy and mutate the copy; the module saves it), while `@ClonerForm` provides the *UI*, deciding which entities it applies to, building the clone form, and naming the cloner plugin to run on submit. The module auto-generates a `cloner-form` route for every entity type; the form renders only when an applicable `@ClonerForm` plugin exists (otherwise 404), and an entity-operation "Clone" link appears when that plugin declares an `entity_operation_label`. You can also invoke the content/config cloner plugins directly from your own code, without any form or route. Access is gated by an `access all entity cloner` permission plus one dynamically generated `access {entity_type} cloner` permission per entity type. The optional `cloner_examples` submodule ships worked node-article and image-style examples. Requires PHP 8.1 and nothing outside Drupal core; no config schema, install hooks, or Drush commands.

---

- Clone content entities (nodes, media, etc.) with per-project control over exactly which fields and references are copied.
- Clone configuration entities (image styles, view modes, etc.), setting a new unique machine name for the copy.
- Write several clone plugins for the same entity type and bundle, selecting between them by weight.
- Duplicate complex entities where a naive copy is insufficient (e.g. Commerce products with variations).
- Add a "Clone" operation link to matching entities' operations lists by declaring an `entity_operation_label`.
- Build a custom clone form (extra fields, validation) that runs before the duplicate is saved.
- Pass submitted form values into the clone logic via the `$context['form_state']` array.
- Restrict a clone plugin to specific entity types/bundles by overriding `isApplicable()`.
- Temporarily disable a clone form while keeping it in the codebase (`enabled = FALSE`).
- Invoke a cloner plugin programmatically from any code path (another plugin, a form submit handler, a Drush command) without the generated UI.
- Gate who may clone via the `access all entity cloner` permission or the per-entity-type `access {type} cloner` permissions.
- Inject services into clone and form plugins using standard dependency injection.
- Alter discovered cloner plugin definitions via `hook_cloner_plugin_ContentEntity_alter` / `ConfigEntity` / `Form`.
- Learn the pattern from the `cloner_examples` submodule (node article clone form + cloner, image style clone form + cloner, programmatic clone button).
- Build cloning workflows without depending on any module outside Drupal core.
