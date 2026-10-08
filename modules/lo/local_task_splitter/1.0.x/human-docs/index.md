# Local Task Splitter — manual setup guide

**Local Task Splitter** (`local_task_splitter`) gives you granular control over
where Drupal's **local tasks** — the tabs that appear on entity and admin pages,
such as *View*, *Edit*, *Delete*, *Revisions* — are placed and how they render.
Out of the box, Drupal shows all of a page's tabs together in a single "Tabs"
block. This module lets you **split those tabs into separate blocks**, so you can
put some tabs in one region and others elsewhere, and optionally render a group of
tabs as a space-saving **dropbutton** (a dropdown of actions).

It is most useful on pages that carry many administrative tasks and start to feel
cluttered. You might, for example, keep the primary tabs where they are but tuck
secondary actions like *Delete* and *Revisions* into a dropbutton, or move a group
of tabs into a different region entirely. When the **UI Icons** module is
installed, you can also add icons to the dropbuttons for a more intuitive look.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create split configurations and place
   the resulting blocks.

## Where it lives in the admin menu

You define split configurations at **Configuration → User interface → Local Task
Split** (`/admin/structure/local_task_splits`), and you place the resulting blocks
from **Structure → Block layout** (`/admin/structure/block`).
