Context UI is the admin interface for the Context module: it lets site builders create and manage `context` config entities (conditions + reactions) at **/admin/structure/context** without writing config by hand. (Part of the Context 5.0.0-rc2 release candidate.)

---

Context UI is a thin submodule of Context that supplies the admin screens the base module deliberately omits. Enabling it adds a **Context** entry under Administration → Structure (`entity.context.collection`, path `/admin/structure/context`), where you list, add, edit, duplicate, disable and delete contexts. Its forms (`ContextAddForm`, `ContextEditForm`, `ContextDeleteForm`, `ContextDisableForm`, `ContextDuplicateForm`, plus condition/reaction add-and-delete forms) let you attach core Condition plugins and Context reaction plugins to a context and configure each one — including the block-placement reaction's full block-library and region UI. It provides the `entity.context.collection` list builder (`ContextListBuilder`), a `ContextUIController` (condition/reaction libraries, group autocomplete, AJAX add), and a **Context Inspector** block (`ContextInspector`) that shows which contexts are active on the current page for debugging. All of this is gated by the `administer contexts` permission (defined here). It ships no config schema and no config entities of its own — it only edits the parent module's `context` entity.

---

- Open the Context admin list at Administration → Structure → Context (`/admin/structure/context`).
- Add a new context through a form instead of writing `context.context.*` config by hand.
- Attach conditions (core Condition plugins) to a context via the condition library UI.
- Attach reactions (blocks, theme, body_class, page_title, menu, …) via the reaction library UI.
- Configure the blocks reaction: pick a theme, browse the block library, place blocks in regions.
- Toggle "require all conditions" (AND) vs any (OR) on the edit form.
- Duplicate an existing context as a starting point for a new one.
- Disable a context temporarily without deleting it.
- Delete a context, condition, or reaction with confirmation forms.
- Group and weight contexts from the UI (group autocomplete).
- Place the **Context Inspector** block to see which contexts are active on a page (debugging).
- Grant the `administer contexts` permission to a trusted role so editors can manage contexts.
- Build a section's block layout per-context as an alternative to core Block layout.
- Set the active theme for a section of the site through the theme reaction form.
- Add body classes or template suggestions to matched pages without touching code.
