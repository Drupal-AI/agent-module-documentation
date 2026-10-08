# Paragraphs Usage — manual setup guide

**Paragraphs Usage** (`paragraphs_usage`) answers a simple but important question:
"where is this paragraph type actually used?" It adds a **Usage** tab (and
operation) to every Paragraphs type that lists which entity types, bundles, and
fields reference that paragraph type — so before you edit, rename, or delete a
paragraph type, you can see exactly what depends on it.

It is a read‑only reporting tool: it changes nothing, it just reports. When you open
a paragraph type's Usage report, the module scans **all** content entity types and
bundles on the site — not just nodes, but taxonomy terms, users, media, and any
other fieldable entity — and inspects every entity‑reference‑revisions field (the
field type Paragraphs uses). It reports every field that can hold that paragraph
type, correctly handling both normal "these bundles" fields and the "exclude these
bundles" (negate) configuration, plus fields that accept any bundle. Each row links
straight to the host bundle's *Manage fields* page.

The module has no settings, no configuration, and no permissions of its own. Access
to the report is gated by Paragraphs' existing **Administer paragraph types**
permission. If you also run **Admin Toolbar Extra Tools** (`admin_toolbar_tools`), a
**Usage** link is nested under each paragraph type in the admin toolbar for quick
access. It requires the contributed **Paragraphs** module (`^1.12`) and works on
Drupal 9, 10, and 11.

For developers, a small service
(`paragraphs_usage.paragraphs_usage_service`) exposes the same scan
programmatically — call `setParagraphType()` then `getUsedParagraphs()` to get the
list of references in code.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and Paragraphs with
   Composer, then enable it.

## Where it lives in the admin menu

There is no settings page. The report appears as a **Usage** tab/operation on each
paragraph type under **Structure → Paragraphs types**
(`/admin/structure/paragraphs_type/{type}`). With Admin Toolbar Extra Tools enabled,
a **Usage** link also appears under each paragraph type in the admin toolbar.

## How to use it

1. Go to **Structure → Paragraphs types** and pick the paragraph type you want to
   check.
2. Open its **Usage** tab (or choose **Usage** from the type's operations).
3. Read the table. Each row shows a **Bundle**, its **Machine name**, its **Type**,
   and the **Field name** that references the paragraph type. The Bundle cell links
   to that bundle's *Manage fields* page so you can jump straight there. If nothing
   references the type, the report says "This paragraph is not used in any content
   type."

Typical uses: checking the impact before deleting or restructuring a paragraph type,
finding orphaned paragraph types that no field targets, auditing paragraph reuse
across a content model, or confirming that a new paragraph type was actually added
to the intended field. You need the **Administer paragraph types** permission to view
the report.
