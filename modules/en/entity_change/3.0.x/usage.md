A developer plugin framework for detecting arbitrary changes on updated content entities by comparing the updated entity to its original.

---

Entity Change provides an `EntityChange` plugin type: each plugin answers one boolean question — "did this particular change occur on this entity?" — by comparing the updated content entity against the `original` entity that Drupal core attaches during entity update. Plugins declare which entity type and bundle they target through a `type` string (for example `node:*` or `node:article`), and the `EntityChangeManager` service locates, instantiates and filters the plugins that apply to a given `(entity, original)` pair. The project ships three example node plugins — Node Just Published, Node Just Unpublished, and Re-titled — and does nothing by itself; it is a foundation that other modules, custom code, or automation tools call to react when a meaningful change is detected. It works only on content entities, since only they carry an `original` copy during updates.

---

- Detect when a node is published for the first time (transition unpublished → published).
- Detect when a node is unpublished (transition published → unpublished).
- Detect when an entity's title changes between the old and new revision.
- Build a reusable "did X change?" test that any module can reuse via the plugin manager.
- Add a custom EntityChange plugin scoped to a single entity type with `type: 'user'`.
- Add a plugin scoped to one bundle with `type: 'node:article'`.
- Add a plugin that applies to every content entity with `type: '*'` (or an empty type).
- Compare specific field values (price, status, workflow state) between old and new entities.
- Trigger notifications only when a field actually changed, not on every entity save.
- Drive downstream automation (ECA/rules-style tools, queues, webhooks) from detected changes.
- Fire an email when an article moves into the published state.
- Fire an alert when a product goes out of stock (a boolean/field flip).
- Log an audit entry only when a moderation state transition occurs.
- Re-run an external sync only when relevant fields on an entity change.
- Let a custom module ask the manager which change plugins matched an update.
- Filter to only the change plugins that both match the entity type and actually applied.
- Encapsulate change-detection logic in testable plugin classes instead of scattered hooks.
- Reuse the `EntityChangeTrait` to get generic type/bundle matching in a custom plugin.
- Provide site builders a library of named "change events" to hang behavior on.
- Detect taxonomy term relabeling or hierarchy changes with a term-scoped plugin.
- Detect user account changes (email, roles, status) with a user-scoped plugin.
- Distinguish "just became true" transitions from "always true" states.
- Centralize change-comparison logic so multiple features share one definition of "changed".
- Support both attribute-based and legacy annotation-based plugin discovery.
- Serve as example/reference code for writing context-aware comparison plugins.
