# Entity Browser - Table Layout — manual setup guide

**Entity Browser - Table Layout** (`entity_browser_table`) adds one new field
widget — **"Entity Browser - Table"** — that displays the entities currently
referenced by a field as a neat, sortable **table** instead of
[Entity Browser](https://www.drupal.org/project/entity_browser)'s default grid of
preview cards. Each referenced item becomes a row showing its label (or a
thumbnail), an optional status column, a drag handle for reordering, and
Edit / Replace / Remove buttons.

It is a thin extension of Entity Browser: it reuses whichever entity browser and
selection logic you already have, and only changes how the **current selection**
is presented on the edit form. All the usual Entity Browser widget settings still
apply and are inherited unchanged. The only setting this module adds is an
**Additional Fields** checkbox that turns on a **Status** column, which shows each
entity's published status — or, when Content Moderation is enabled and the entity
is moderated, its moderation state (draft/published/archived).

The widget works on `entity_reference` and `entity_reference_revisions` fields and
is chosen per field, per form mode, on the bundle's *Manage form display* page.
There is no global settings page, no permissions, and no Drush commands. Developers
can add extra columns to the table with `hook_entity_browser_table_alter()`.
The module requires the [Entity Browser](https://www.drupal.org/project/entity_browser)
module (`^2.15`) and Drupal 10.3 or newer.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (and Entity Browser) and enable it.

## How to use it

You need Entity Browser enabled with at least one entity browser already
configured (at `/admin/config/content/entity_browser`) — this module reuses an
existing browser rather than creating one. Then, per field:

1. Go to the host bundle's **Manage form display** page — for example
   **Structure → Content types → Article → Manage form display**
   (`/admin/structure/types/manage/article/form-display`).
2. Find your entity‑reference (or entity‑reference‑revisions) field and, in its
   **Widget** select list, choose **Entity Browser - Table**.
3. Click the widget's cog to open its settings. These are the standard Entity
   Browser options — which **entity browser** to open, the **entity display
   plugin** (choose **Entity label** for a title column, or **Rendered entity**
   for a thumbnail column), the **Edit / Remove / Replace** button toggles, the
   selection mode, and the open behaviour.
4. The one setting this module adds is **Additional Fields → "Status"** — tick it
   to add a Status column to the table.
5. Click **Update**, then **Save**.

Now, when you edit content with that field, the referenced entities appear as a
table you can reorder by dragging rows. (The Replace action is offered only when
exactly one entity is currently referenced.)
