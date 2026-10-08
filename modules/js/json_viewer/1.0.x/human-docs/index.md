# JSON Viewer — manual setup guide

**JSON Viewer** (`json_viewer`) is a lightweight tool for displaying and working
with JSON data in Drupal. Instead of showing a JSON value as one long,
unreadable string, it renders it as a structured, collapsible tree you can
expand, collapse, search, and view fullscreen — handy for config dumps, API
payloads, or any structured data stored on your site.

It gives you two things. First, a set of **field formatters** so JSON stored in
your content displays nicely on the page:

- **JSON Viewer** (for text fields) renders a JSON string from a `string`,
  `string_long`, or `text` field as a formatted, interactive tree, with built-in
  validation for invalid JSON.
- **JSON File Viewer** (for file fields) renders the contents of an uploaded
  `.json` file, checking its MIME type and handling file errors.
- **JSON Media Viewer** (for entity reference fields) renders a JSON file
  referenced by a Media entity, so you can manage JSON through the Media Library.

Second, a **JSON Previewer block** with a full editor on the left and a live
preview on the right — ideal for quickly editing, validating, and testing JSON
snippets.

Both the formatters and the block offer display options such as a choice of
colour palettes, how many levels of the tree to expand by default, and (for the
block) which controls to show. It requires only Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the formatter and block display
   options, field by field.

## Where it lives in the admin menu

JSON Viewer has no central settings page. You configure it in the two places its
features live:

- **Field formatters** — on any fieldable entity's **Manage display**
  (**Structure → Content types → *(type)* → Manage display**), by choosing one of
  the JSON Viewer formats for a compatible field.
- **The JSON Previewer block** — through the **Block layout**
  (`/admin/structure/block`), where you place and configure the block like any
  other.
