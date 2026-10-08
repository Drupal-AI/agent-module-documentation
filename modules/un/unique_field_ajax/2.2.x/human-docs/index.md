# Unique Field Ajax — manual setup guide

**Unique Field Ajax** (`unique_field_ajax`) lets you mark a single-value field —
or a content type's title — as **unique**, so editors cannot save a second piece
of content that reuses a value already in use. Think product SKUs, event slugs,
reference numbers, or simply making node titles unique within a content type.

Uniqueness is checked when the form is submitted, and optionally **live via
AJAX** as the editor types, giving them an inline "this value is already taken"
message before they even hit Save. You can make the check case-sensitive or
case-insensitive, scope it per language, and choose whether a duplicate blocks
the save outright or just shows a soft warning that still lets the content
through.

There is **no central admin settings page**. Instead, the module adds a "Unique
field settings" section to a field's own settings form, and a "Unique title
settings" section to the content-type add/edit form. Your choices are saved as
third-party settings on that field or content type, so they travel with your
exported configuration. Two developer hooks let other modules adjust the
uniqueness query or its results. The module has no dependencies beyond Drupal
core and adds no permission of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — turn on uniqueness for a field or a
   node title, and what each option means.

## Where it lives in the admin menu

Unique Field Ajax has no page of its own. You configure it in two places:

- **On a field:** *Structure → Content types → (a type) → Manage fields → Edit*
  for an eligible single-value field — the settings appear as a **Unique field
  settings** fieldset.
- **On a node title:** *Structure → Content types → Add/Edit content type* — a
  **Unique title settings** fieldset governs that type's title.
