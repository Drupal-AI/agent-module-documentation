# Mercury Editor Page Templates — manual setup guide

**Mercury Editor Page Templates** (`mercury_editor_page_templates`) gives the
[Mercury Editor](https://www.drupal.org/project/mercury_editor) page builder a
**template system**: predefined page layouts and starting content that editors can
choose from when creating a new page. Instead of building every page from a blank
canvas, content creators pick a template, get a consistent, pre‑configured layout,
and save setup time — while the site keeps a consistent look across similar pages.

Templates are defined and managed through an admin interface, and can be organised
into labelled, sortable **groups** in the template selector, with drag‑and‑drop
ordering inside each group. Each template can be tied to specific content types and
can carry an optional **preview image** (PNG, JPEG, or WebP) shown in the selector.
Templates are stored as **YAML**, which makes them easy to edit and to keep in
version control, and they support any field machine name, nested paragraphs, and
resolved entity/paragraph references.

A standout feature is **Save as Page Template**: editors with the right permission
can capture the layout of any page they have open in Mercury Editor as a brand‑new
reusable template — or update an existing one — straight from the editor toolbar,
without leaving the editing experience. The module provides its own permissions and
depends on **Mercury Editor**, **Layout Paragraphs**, **Paragraphs**, and core's
**File** module. It needs Drupal 10 or 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Mercury Editor and Layout Paragraphs.
2. [Configuration](configuration/index.md) — create and organise page templates,
   and use *Save as Page Template* from the editor.

## Where it lives in the admin menu

Templates are managed at **Configuration → Content authoring → Mercury Editor Page
Templates**. From there you add templates, assign them to content types, and use the
**Groups** tab to organise and order them.
