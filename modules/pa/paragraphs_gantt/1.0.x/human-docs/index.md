# Paragraphs Gantt — manual setup guide

**Paragraphs Gantt** (`paragraphs_gantt`) renders a Paragraphs field as an
interactive **Gantt chart**. If you build project or schedule content out of
Paragraphs — each paragraph holding a task with a start and end date — this
module turns that set of paragraphs into a timeline view with bars laid out
across a calendar, instead of a plain stacked list. It uses the dhtmlx Gantt
JavaScript library to draw the chart.

On install it adds a ready-made **Gantt** paragraph type, but you don't have to
use it: you can point the formatter at your own paragraph type and map your own
fields to the chart's task, start-date and end-date slots on the field's
*Manage display* screen. The project also ships a demo you can switch on to try
every option quickly, and the maintainer notes it looks best with a Bootstrap 5
admin theme. It depends only on the Paragraphs module and supports Drupal 8.8
through 12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   confirm the Gantt paragraph type and formatter are available.

There is **no dedicated configuration page** for this module. You set it up
entirely on a Paragraphs field's *Manage display*, described in "How to use it"
below.

## Where it lives in the admin menu

Paragraphs Gantt adds no admin settings page of its own. You work with it from
**Structure → Content types (or Paragraph types) → *(bundle)* → Manage display**,
where you choose the Gantt formatter for your Paragraphs field. The Gantt
paragraph type it installs appears under **Structure → Paragraph types**.

## How to use it

1. Make sure the **Paragraphs** module is enabled and you already have a
   Paragraphs field on a content type (for example a "Tasks" field on a Project
   content type).
2. Use the installed **Gantt** paragraph type, or use your own paragraph type
   that has the fields a timeline needs — at minimum a task label and a start
   and end date.
3. On the host bundle's **Manage display**, set the Paragraphs field's format to
   the **Gantt** formatter and map which paragraph fields supply the task name,
   start date and end date.
4. Add paragraphs (tasks) to your content and view the page — the paragraphs
   render as an interactive Gantt timeline.

> **Tip:** To explore the options before wiring up your own content, enable the
> module's Gantt demo. The chart is drawn with the dhtmlx Gantt library and, per
> the maintainer, displays best under a Bootstrap 5 admin theme.
