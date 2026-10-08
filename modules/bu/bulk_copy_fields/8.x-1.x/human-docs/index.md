# Bulk Copy Fields — manual setup guide

**Bulk Copy Fields** (`bulk_copy_fields`) provides an action that copies values
from one field to another across a set of selected entities. It exists because
content-model changes are a constant on a long-lived site: a plain text field
becomes rich text, a single-value field becomes multi-value, two fields are
consolidated, or a field is "renamed" — which in Drupal means creating a new
field and moving the data, because fields cannot actually be renamed. The schema
change is the easy part; moving the existing content is the work.

Because it is a Drupal action, you run it from a **Views bulk operation**: build
or open a listing, select the rows you want, and apply the "copy field values"
action, scoped to whatever the view selected. That puts the job in the interface
rather than in a throwaway `drush php` loop nobody reviews. It depends on core's
**Action** module, supports Drupal 8 through 11, and is an **alpha** release
(`8.x-1.0-alpha6`).

**This writes to content in bulk, so three cautions apply:**

1. **Field types must be compatible, and the interesting failures are partial.**
   Rich text copied into a plain field loses its markup silently; a multi-value
   field copied into a single-value one keeps the first value and discards the
   rest without telling you.
2. **Run it on a copy first.** There is no undo, and the previous values are gone
   unless revisions were being kept.
3. **Saving entities in bulk fires everything that hooks entity save** — search
   reindexing, cache invalidation, workflow transitions, outbound webhooks. A
   copy across ten thousand nodes is a much larger operation than it looks.

This guide is written for a **human** setting the module up through the admin UI.
If you want a terse, token-cheap reference for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (it requires core Action).

## Where it lives in the admin menu

There is no settings page. The module registers an action that you apply from a
**Views bulk operations** listing — the action appears in the bulk-operation
dropdown once the module is enabled.

## How to use it

1. Install and enable `bulk_copy_fields` (see
   [Installation](installation/index.md)).
2. On a copy of your site (see caution 2), open a View that lists the entities
   you want to change and that has bulk operations enabled.
3. Select the rows to process, choose the copy-field-values action, and pick the
   source and destination fields — making sure the two field types are
   compatible (caution 1).
4. Run it. Remember this saves every selected entity, triggering all the usual
   save-time side effects (caution 3), so treat a large run as a significant
   operation and monitor it.
