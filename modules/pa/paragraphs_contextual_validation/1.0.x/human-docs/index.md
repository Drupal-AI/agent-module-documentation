# Paragraphs Contextual Validation — manual setup guide

**Paragraphs Contextual Validation** (`paragraphs_contextual_validation`) adds
configurable validation rules to paragraph reference fields, letting you enforce
the **structure** of paragraph‑built content. If you use the
[Paragraphs](https://www.drupal.org/project/paragraphs) module to build flexible
pages — say landing pages assembled from Hero, CTA, and Text blocks — this module
lets you require things like "at most one Hero," "Hero must be first," or
"Disclaimer must be immediately above CTA."

It supports three kinds of rule:

- **Cardinality** — limit how many times a paragraph type may appear in the field
  (more than, at least, exactly, fewer than, or at most a given count).
- **Absolute position** — require a paragraph type to be the **first** or **last**
  item in the field.
- **Relative position** — require (or forbid) two paragraph types to sit
  **immediately next to** each other.

Rules are defined **per field**, right on the field's edit form, in a *Paragraphs
contextual validation* section — there is no separate configuration page or config
entity. Validation runs whenever the entity is validated: on form save, via
REST/JSON:API, or from any custom code. Violation messages use the paragraph type
**labels** (not machine names) so editors see clear errors, and the settings are
stored as third‑party settings on the field config, so they export with your
configuration. When a paragraph type is deleted, the module automatically removes
any constraints that referenced it. Other modules can also provide custom rule
plugins that appear in the same list.

It depends on the Paragraphs and Entity Reference Revisions modules, constrains
what editors can save, and has no access‑control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central configuration page** for this module. All rules are defined
per field on the field's edit form, as described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin settings page. You configure rules on individual fields at
**Structure → Content types → *(type)* → Manage fields → *(paragraph reference
field)* → Edit** (or the equivalent Manage fields page for any entity type that has
a paragraph reference field).

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to the **Manage fields** page for the content type (or other entity type)
   that has your paragraph reference field, and click **Edit** on that field.
3. Open the **Paragraphs contextual validation** section and check **Enable
   paragraphs contextual validation**.
4. Click **Add constraint**, choose a rule type (**Cardinality**, **Absolute
   position**, or **Relative position**), and fill in its options — the paragraph
   type plus an operator and count, or a position, or a relation between two types.
   Repeat for each rule you need.
5. Click **Save settings** at the bottom of the field form.

After saving, the rules run automatically whenever content using that field is
validated. If a rule is violated, the save is blocked and a clear, label‑based
error is shown next to the relevant paragraph(s). Because the rules live in
configuration, remember to export them (`drush config:export`) so they deploy with
the rest of your config.
