# Gantt — manual setup guide

**Gantt** (`gantt`) turns date‑based content into an interactive **Gantt chart** —
a project‑timeline view where each task is a bar spanning its start and end dates,
with dependencies drawn between them. It renders the chart with the
[dhtmlxGantt](https://dhtmlx.com/docs/products/dhtmlxGantt/) JavaScript library and
feeds it from a **View**, so any content with dates (projects, schedules, tasks)
can be shown as a timeline.

If you are comfortable with Views, you build a View of your task content, choose
the Gantt format, and map which fields supply the start date, end date, and
dependencies. If you would rather not build that by hand, the module ships a
**Gantt Node** demo submodule (`gantt_node`) that creates a ready‑made "Gantt"
content type and a matching View — install it, add a task at `/node/add/gantt`,
then visit `/gantt` to see the interactive chart and get started.

By default the dhtmlxGantt library loads from a CDN; if you own the PRO version of
the library you can drop it into `/libraries/gantt/codebase/` instead. Gantt is a
content‑display/Views feature and provides its own permissions; the chart shows
what the underlying View is allowed to show and respects the View's access.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally the Gantt Node demo.

There is **no global settings form** — you configure the chart on a View (or use
the Gantt Node demo), as described in "How to use it" below.

## Where it lives in the admin menu

Gantt provides its own permissions, managed at **People → Permissions**. You
configure the chart from **Structure → Views** (`/admin/structure/views`). If you
enable the Gantt Node demo, task content is created at **`/node/add/gantt`** and
the chart is at **`/gantt`**.

## How to use it

**The quick way — Gantt Node demo:**

1. Enable the `gantt_node` submodule (see Installation).
2. The first time, create a task at **`/node/add/gantt`**.
3. Visit **`/gantt`** to see the interactive Gantt interface and start adding and
   linking tasks.

**The custom way — your own View:**

1. Go to **Structure → Views** and build a View of your task/date content.
2. Set the View's **Format** to the **Gantt** style.
3. Map the fields that supply each task's start date, end date, and any
   dependencies, then save.
4. View the page or block to see the tasks rendered as a timeline.
