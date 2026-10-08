Entity reference override Revisions (EXPERIMENTAL) provides an `entity_reference_override_revisions` field type: an Entity Reference Revisions reference (as used by Paragraphs and composite entities) paired with a per-reference override text field for overriding the referenced revision's title.

---

This experimental submodule brings entity_reference_override's "custom text" idea to the Entity Reference Revisions field type. It defines the field type `entity_reference_override_revisions`, a subclass of `EntityReferenceRevisionsItem`, adding a single `override` storage column (varchar 255) and the field setting `override_label`. It ships an autocomplete widget `entity_reference_override_revisions_autocomplete` (subclass of the core autocomplete widget) that renders the reference input plus an `override` textfield, and reuses the parent module's `entity_reference_override_label` formatter as its default formatter to apply the override (title/append/suffix/class/hide). Unlike the base module it has no `override_format` (plain text only). It depends on `entity_reference_override` and `entity_reference_revisions`, has no config form, no permissions, and no services. Being experimental, it is best used where you already rely on Entity Reference Revisions (e.g. composite/versioned content) and need contextual title overrides.

---

- Reference revisioned entities (as with Paragraphs / Entity Reference Revisions) and override their displayed title per reference.
- Give a referenced paragraph or composite entity a placement-specific title without editing the revision.
- Add per-reference custom text to Entity Reference Revisions fields.
- Use an autocomplete widget that references a revision and captures an override title.
- Apply the override via the shared label formatter (`title`, `title-append`, `suffix`, `class`, `hide`).
- Keep referenced revisions canonical while showing editorially chosen titles.
- Configure the override box label/placeholder per field via `override_label`.
- Curate versioned content lists where each item's title is contextual.
- Migrate versioned reference structures that need per-item custom labels.
- Combine revision-pinned references with overridable display titles.
- Support multi-value revision references with per-item override placeholders.
- Provide contextual titles for referenced revisions in view displays.
- Avoid duplicating revisioned entities just to vary their displayed title.
- Layer custom display text on top of Entity Reference Revisions without changing its storage semantics.
- Prototype overridable-title behaviour for composite content (experimental).
