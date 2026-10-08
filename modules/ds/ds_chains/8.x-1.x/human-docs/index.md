# Display Suite Chains — manual setup guide

**Display Suite Chains** (`ds_chains`) lets a
[Display Suite](https://www.drupal.org/project/ds) layout place a **single field
from a referenced entity** directly among the host entity's own fields — without
rendering the whole referenced entity. If your entity has an entity reference
field, you can reach through it and drop any field of the referenced entity onto
your **Manage display** screen.

The classic example: an article references an author profile, and the byline
needs just the author's name and photograph — not the author's rendered teaser
with its biography and links. With field chaining you place those two fields as
placements, in the same interface where you configure the rest of the display.
The alternatives it replaces are clumsy: building a dedicated view mode for every
placement (which multiplies view modes until nobody knows which is used where),
or writing a preprocess function that loads the reference and extracts the field
(which turns a display decision into code).

It differs from the similar **Field formatter** approach in that Display Suite
Chains lets you configure **each referenced field on its own**, whereas a field
formatter typically surfaces a single field from the reference.

Two things are worth knowing before you rely on it, both consequences of
reaching through a reference:

- **Choose placements deliberately.** A chained field appears wherever that
  display mode is shown, so place only referenced fields that are appropriate for
  that display's audience, and review the result on a representative piece of
  content before relying on it.
- **Mind performance.** Each chained field is an entity load. A listing of, say,
  fifty rows that each reach through a reference means fifty extra loads unless
  something caches them — the usual reason a chained listing feels slow.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and confirm Display Suite is present.

There is **no configuration page** for this module. You use it entirely from the
**Manage display** screens, described below.

## Where it lives in the admin menu

Display Suite Chains adds no admin settings page. You use it from **Structure →
Content types → *(your type)* → Manage display** (or the Manage display screen of
any entity that has an entity reference field), using the Display Suite layout
tools.

## How to use it

1. Make sure the host entity type has an **entity reference** field pointing at
   the entity whose field you want to show (for example an "Author" reference on
   an Article).
2. On that content type's **Manage display**, use Display Suite to arrange the
   layout.
3. The fields of the referenced entity become available to place among the host
   entity's own fields — add just the ones you need (for example the author's
   name and photograph) and position them in your regions.
4. Save the display and view a piece of content to confirm the referenced field
   appears where you placed it.
