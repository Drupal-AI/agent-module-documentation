<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity expand is a small developer utility that decorates a loaded Drupal entity with an `EntityExpandBase` wrapper so you can attach custom methods per entity type and use fluent field helpers.

---

It exposes a procedural `entity_expand_load($entity)` (and `_entity_load($type, $id)`) that invokes the `hook_entity_expand_load($entity, $entity_type_id)` hook, letting any module swap in its own subclass of `EntityExpandBase` (e.g. a `UserExpand` with domain methods like `newname()`), then falls back to the base wrapper. The base class adds convenience helpers on top of the wrapped entity: `get()`, `setValues([...])`, `bundleKey()`, plus field-item helpers such as `val()`, `ref()`/`refs()`, `targets()` and `listTextLabel()` for reading reference targets and list labels fluently. There is no UI, no route, no permission and no config — it is purely an API for module code, and it wraps entities you have already loaded (so it inherits whatever access you applied when loading them).

Typical use: in a custom module implement `hook_entity_expand_load()` to return your `EntityExpandBase` subclass for a given entity type, then call `entity_expand_load(User::load(1))->yourMethod()` or chain field helpers like `$node->field_ref->ref()->yourMethod()`.
---
- Wrap a loaded entity with `entity_expand_load($entity)`
- Load-and-wrap in one call with `_entity_load($type, $id)`
- Load the unchanged (persisted) entity via the `$unchanged` flag
- Register per-entity-type methods via `hook_entity_expand_load()`
- Return a custom `EntityExpandBase` subclass for a given entity type
- Add domain methods (e.g. `newname()`) callable directly on the entity
- Read a field value with a default via `->val('default')`
- Set multiple field values at once with `->setValues([...])`
- Follow a single entity reference with `->ref()->method()`
- Iterate reference targets with `->refs(fn($e) => ...)`
- Get all target ids of a multi-value reference with `->targets()`
- Render the wrapped entity in a view mode via `->view('full')`
- Get the display label of a list/select field with `->listTextLabel()`
- Resolve the bundle key of any entity with `->bundleKey()`
- Chain helpers across referenced entities fluently
- Keep entity-type-specific logic out of hooks and in dedicated classes
- Use as a lightweight decorator instead of subclassing core entity classes
- Provide reusable field-access helpers across a codebase
