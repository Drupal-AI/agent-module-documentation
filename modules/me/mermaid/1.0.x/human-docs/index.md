# Mermaid — manual setup guide

**Mermaid** (`mermaid`) brings the [Mermaid JavaScript library](https://mermaid.js.org/)
to Drupal, so you can describe a diagram in a compact text syntax and have the
browser draw it for you — flowcharts, sequence diagrams, Gantt charts, entity
relationship diagrams and more. Instead of exporting an image from a drawing tool
and re-uploading it every time something changes, you edit a few lines of text and
the picture redraws itself.

The base module does one thing: it registers Mermaid as a Drupal asset library so
other code and submodules can use it. On its own it has no visible feature — the
value comes from the two submodules it ships. **Mermaid Filter**
(`mermaid_filter`) adds a text-format filter that renders anything you wrap in
`[mermaid]...[/mermaid]` inside body text or other formatted fields. **Mermaid
GraphAPI** (`mermaid_graphapi`) generates diagrams programmatically, such as entity
relationship diagrams (`erDiagram`) and flowcharts, from Drupal's GraphAPI.

One safety point worth understanding before you switch the filter on: the filter
renders diagram source that **content authors write**, and Mermaid runs that source
live in the visitor's browser. Treat it like any other active-content feature —
enable the filter only on text formats used by **trusted authors**, and rely on the
overall configuration of that text format. The filter is not an access-control
mechanism.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module, and turn on the submodule(s) you need.

There is **no central settings page** for this module. The base module only
provides the library; the Mermaid Filter is configured per text format under
**Structure → Text formats and editors**, as described below.

## Where it lives in the admin menu

Mermaid adds no configuration page of its own (`configure` is null). Once you enable
**Mermaid Filter**, you configure it on a text format at **Configuration → Content
authoring → Text formats and editors** (`/admin/config/content/formats`).

## How to use it

The typical workflow with the **Mermaid Filter** submodule:

1. Enable `mermaid` and `mermaid_filter` (see [Installation](installation/index.md)).
2. Go to **Configuration → Content authoring → Text formats and editors**, pick a
   format used by trusted authors (for example *Full HTML*), and edit it.
3. In the **Enabled filters** list, tick the Mermaid filter, then save the format.
   Mind the filter processing order so Mermaid runs before or after other filters as
   appropriate for your content.
4. In any field that uses that format, write a diagram between `[mermaid]` and
   `[/mermaid]` tags, for example a simple flowchart:

   ```
   [mermaid]
   flowchart TD
     A[Start] --> B{Is it working?}
     B -->|Yes| C[Ship it]
     B -->|No| D[Debug]
     D --> B
   [/mermaid]
   ```

5. Save the content and view it — the text is replaced by a rendered diagram.

If you are a developer, the **Mermaid GraphAPI** submodule lets you build entity
relationship diagrams and flowcharts from code rather than from author-written text.
