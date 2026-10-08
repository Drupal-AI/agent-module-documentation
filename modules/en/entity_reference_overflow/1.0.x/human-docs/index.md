# Entity Reference Overflow — manual setup guide

**Entity Reference Overflow** (`entity_reference_overflow`) lets an
entity-reference field **display more entities than were manually selected** by
"overflowing" its output with additional, dynamically pulled entities. It is most
useful for building a "Related Content" section that mixes **manual curation with
a dynamic fallback**: editors hand‑pick a few references, and the field
automatically tops the list up with more content when there are not enough manual
selections.

The module reads the entity-reference field's own configuration to decide where to
pull the additional content from, so the extra entities come from the same pool
the field already references. It is a content‑display feature that affects field
rendering only — the referenced entities follow their own access rules, and the
module has no access‑control role of its own. You configure the behaviour on the
field's display formatter. It has no third‑party dependencies and runs on Drupal
8.8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no site‑wide settings
form. You configure the overflow on the field's formatter under *Manage display*,
described in "How to use it" below.

## Where it lives in the admin menu

Entity Reference Overflow adds no admin settings page. You use it from **Structure
→ Content types (or any fieldable entity) → *(bundle)* → Manage display**.

## How to use it

1. Go to the **Manage display** page of an entity that has an entity-reference
   field (for example **Structure → Content types → Article → Manage display**).
2. Set that field's **Format** to the Entity Reference Overflow formatter.
3. Open the format settings (the gear icon) and configure how many items to show
   and how the field should overflow — the module uses the field's own reference
   configuration to determine where to pull the additional content from.
4. Click **Update**, then **Save** the display.

The field will now render the manually selected references plus any dynamically
added overflow entities, according to your settings.
