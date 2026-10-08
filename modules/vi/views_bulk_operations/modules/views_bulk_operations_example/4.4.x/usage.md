A demonstration submodule shipping a single VBO action plugin that exercises nearly every option (preconfiguration, configuration form, access, custom result messages) as a copy-paste reference for building your own bulk actions.

---

This is an example/learning module, not something you enable on a production site for its own features. It contains one class, `ViewsBulkOperationExampleAction`, registered with the core `#[Action]` attribute and extending VBO's `ViewsBulkOperationsActionBase`. The class shows how to implement a preconfiguration form (fixed settings chosen by the site builder in the View), a per-run configuration form, an `access()` check, and an `execute()` method that returns a translatable result message and prints the current configuration. Because its action `type` is left empty, it appears for all entity types. Install it on a dev site, add the "VBO example action" to a View's bulk-operations field, and step through configure → confirm → execute to see how the pieces fit before writing a real action. Read the source alongside the main module's `plugins/vbo-action.md` doc.

---

- Learn the anatomy of a VBO Action plugin from a working example.
- Copy the class as a starting template for a custom bulk action.
- See how `buildPreConfigurationForm()` exposes site-builder settings.
- See how `buildConfigurationForm()` collects per-run input.
- Understand how `$this->configuration` flows into `execute()`.
- Observe how a result message / `TranslatableMarkup` is returned per row.
- Test the configure → confirm → execute multi-step flow end to end.
- Demonstrate an action that applies to all entity types (`type: ''`).
- Show how `access()` gates an action per entity.
- Verify VBO is working on a fresh install with a harmless action.
- Reference `api_version` message-count behavior in comments.
- Teach new developers the VBO extension model in a workshop.
- Prototype a bulk action's UI before implementing real logic.
- Confirm preconfiguration vs configuration semantics interactively.
- Use as a fixture when debugging VBO selection/tempstore behavior.
