Entity Reference Override adds an "Entity reference w/custom text" field type: a normal entity reference paired with an extra per-reference text field, letting the referencing entity override the referenced entity's title (or add a CSS class, a note, or replace one of its text fields) without editing the referenced entity itself.

---

The module provides the field type `entity_reference_override`, a subclass of core's `EntityReferenceItem` that adds two storage columns, `override` (varchar 4094) and `override_format`. Field settings are `override_label` (the label/placeholder shown for the custom-text box) and `override_format` (a text format: `NULL` means a single plain-text line — the only mode that can override a label/class — while choosing any filter format turns the box into a `text_format` widget for overriding an actual text field). It ships two widgets — `entity_reference_override_autocomplete` (default) and `entity_reference_override_select` — both built on the core reference widgets via `OverrideTextWidgetTrait`, which appends the override text element next to the entity autocomplete/select. Two formatters consume the override: `entity_reference_override_label` (default) renders the referenced entity's label and applies the override via an `override_action` setting — `title` (replace), `title-append` (append in parentheses), `suffix` (note after the link), `class` (add a CSS class to the link), or `hide`; and `entity_reference_override_entity` renders the full referenced entity and can splice the override text into a chosen stringy field (`string`, `text_long`, `email`) on the rendered entity. It also integrates with Diff (a field diff builder plugin), Feeds (a target plugin), and Entity Usage (tracks references). There is no admin settings page, no permissions, and only one text field per instance, so only one aspect can be overridden at a time. Two optional submodules extend it: `entity_reference_override_entity_browser` (Entity Browser widget) and `entity_reference_override_revisions` (Entity Reference Revisions integration, experimental).

---

- Reference a node/media/term but show a different, per-placement title than the entity's real title.
- Give the same referenced article a different headline on each page that references it.
- Append a short qualifier to a referenced entity's title in parentheses (e.g. "Team page (2024)").
- Add a note after a referenced link without changing the target entity.
- Attach a per-reference CSS class to a referenced entity's rendered link for styling.
- Hide the referenced entity's label while keeping the reference (e.g. logo-only link lists).
- Build curated "related content" lists where each item's displayed title is editorially chosen.
- Override the title of referenced media items in a gallery per placement.
- Provide a custom call-to-action label for a referenced page in a promo block.
- Replace one text field (string, long text, or email) of a referenced entity for a specific placement using the rendered-entity formatter.
- Use an autocomplete widget with an inline custom-text box for editors.
- Use a select-list widget variant with the same override text box.
- Let editors enter override text through a WYSIWYG when a filter format is chosen for the override.
- Keep referenced entities canonical while allowing contextual, placement-specific display text.
- Configure the override box's label/placeholder per field via `override_label`.
- Restrict the override to a single plain-text line (labels/classes) or a formatted text area (fields) via `override_format`.
- Choose how the label formatter applies the override (`title`, `title-append`, `suffix`, `class`, `hide`).
- Track referenced-entity usage through the Entity Usage module (the field type is registered for tracking).
- Compare override values in entity revisions via the Diff module integration.
- Import override values through Feeds using the provided target plugin.
- Reference entities with overridable titles from an Entity Browser (with the entity_browser submodule).
- Override titles on Entity Reference Revisions fields (with the revisions submodule, experimental).
- Migrate curated menus or link lists that need per-item custom labels into structured fields.
- Avoid duplicating entities just to show different titles in different contexts.
