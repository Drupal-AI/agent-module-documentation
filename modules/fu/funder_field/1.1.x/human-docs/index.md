# Funder Field — manual setup guide

**Funder Field** (`funder_field`) gives you a dedicated field type for recording
who funded a piece of research. Instead of typing a funder's name into a plain
text field and hoping everyone spells it the same way, editors search against the
**CrossRef Funder Registry** — the standard, canonical list of research‑funding
organisations — and store the registry‑linked funder (and the awards it
sponsors) as structured metadata on your content.

It is aimed squarely at academic and research sites: journals, institutional
repositories, grant catalogues, and anywhere a publication needs a clean,
machine‑readable record of its funding source. The field offers autocomplete
against funder IDs so the value you save is tied to the registry rather than to
free text, which keeps attribution consistent and reportable.

Funder Field is a field provider and nothing more. It has no front‑end pages of
its own and no public‑facing role; administering it is gated behind the
`administer funder_field` permission. It supports Drupal 10 and 11. Note that at
this release it is a **beta** (`1.1.0-beta1`) and is marked minimally maintained,
so test it before relying on it in production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated settings page** for this module — it has no global
configuration form. You set it up entirely by adding a Funder field to an entity
and configuring that field, as described in "How to use it" below.

## Where it lives in the admin menu

Funder Field adds no admin page of its own. You work with it from **Structure →
Content types (or any entity bundle) → *(bundle)* → Manage fields**, where the
Funder field type becomes available when you add a new field. The
`administer funder_field` permission it provides is managed at **People →
Permissions**.

## How to use it

1. Go to the bundle you want to attach funding metadata to — for example
   **Structure → Content types → Article → Manage fields**.
2. Choose **Add field** and pick the **Funder** field type. Give it a label such
   as *Funder* and save.
3. When editing content, use the field's autocomplete to search the CrossRef
   Funder Registry and select the correct funder (and, where offered, the award
   it sponsored). The registry‑linked value is stored on the entity.
4. Grant the `administer funder_field` permission only to the roles that manage
   funding metadata.
