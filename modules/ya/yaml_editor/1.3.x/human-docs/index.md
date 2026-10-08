# YAML Editor — manual setup guide

**YAML Editor** (`yaml_editor`) loads an [Ace](https://ace.c9.io) code editor over YAML
textareas in the admin UI, giving them syntax highlighting, a YAML mode, and tidy
2‑space indentation. It is a small quality‑of‑life tool for anyone who edits structured
YAML by hand — core's Configuration synchronization import/export boxes, a Webform's
YAML source, and similar admin fields become much friendlier to work in.

It works two ways. First, on **admin pages only**, it automatically enhances any
textarea that carries a `data-yaml-editor` attribute — hiding the plain textarea and
mounting an Ace editor that mirrors your edits back so the form still submits normally.
Several other contrib modules (Linked Field, Menu Link Attributes, Block Attributes,
Responsive SVG) tag their YAML fields this way, so those light up automatically once
YAML Editor is installed. Second, it ships a field **widget** so you can turn the editor
on for any *Text (plain, long)* field from Manage form display, no code required.

Ace itself is loaded from a configurable source (a CDN by default, or a self‑hosted
copy for offline sites), and the editor color theme is configurable too. Note this is
an editing aid only — it highlights and indents, but does **not** validate your YAML on
the server.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — the widget id and the exact JS
behavior — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Settings — the Ace source and theme

The only settings are which Ace build to load and which Ace theme to use. Find them at
**Configuration → Development → YAML editor** (`/admin/config/development/yaml_editor`),
guarded by the **Configure yaml_editor** permission:

- **Editor source** — the URL of Ace's `ace.min.js`. It defaults to a cdnjs CDN URL.
  Point it at a self‑hosted copy (for example `/libraries/ace/ace.min.js`) for offline
  or air‑gapped sites, or to pin a specific Ace version.
- **Editor theme** — the Ace theme id, e.g. `ace/theme/chrome` (the default) or a dark
  theme like `ace/theme/monokai`. The matching theme file must be available in the Ace
  build you load.

Changes take effect on the next admin page load. You can also set them from the command
line:

```bash
drush config:set yaml_editor.config editor_theme ace/theme/monokai -y
drush config:set yaml_editor.config editor_source /libraries/ace/ace.min.js -y
```

## How to turn the editor on for a field

For any **Text (plain, long)** field:

1. Go to the entity's **Manage form display**.
2. Set that field's widget to **Text area with YAML editor**.
3. Save. The field now renders with the Ace editor on admin forms.

To enhance a textarea in your own admin form, simply add a `data-yaml-editor="true"`
attribute to it — you do not need to attach any library yourself; YAML Editor does that
on every admin route. (On front‑end forms the attribute is ignored: the editor is
scoped to admin pages by design.)
