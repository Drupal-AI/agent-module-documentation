# Entity reference override Revisions (entity_reference_override_revisions) — agent index

**EXPERIMENTAL** submodule of **entity_reference_override**. Adds an *Entity Reference
Revisions* variant field type with a per-reference override (custom title). No config form, no
permissions, no services. Depends on `entity_reference_override` and
`entity_reference_revisions`.

This is a thin field-plugin shim — the facts below are the whole surface.

Key facts:
- Field type id **`entity_reference_override_revisions`** ("Entity reference revisions w/custom
  text"), class
  `Drupal\entity_reference_override_revisions\Plugin\Field\FieldType\EntityReferenceOverrideRevisions`,
  extends `EntityReferenceRevisionsItem`.
- Adds ONE storage column **`override`** (varchar **255**) and field setting **`override_label`**.
  **No `override_format`** — plain text only (unlike the base `entity_reference_override` type).
- `default_widget` = **`entity_reference_override_revisions_autocomplete`** (extends the core
  autocomplete widget; renders `target_id` + an `override` textfield).
- `default_formatter` = **`entity_reference_override_label`** — reuses the **parent module's**
  label formatter, so the same `override_action` modes apply (`title`, `title-append`, `suffix`,
  `class`, `hide`). See modules/en/entity_reference_override/2.0.x/agent/configure/field.md.
- Use where you already rely on Entity Reference Revisions (Paragraphs / composite, versioned
  references) and want contextual title overrides. Being experimental, prefer it only there.
