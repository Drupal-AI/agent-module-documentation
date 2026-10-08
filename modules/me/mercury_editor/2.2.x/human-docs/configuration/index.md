# Configuration

All of Mercury Editor's settings live under **Configuration → Content authoring →
Mercury Editor** (`/admin/config/content/mercury-editor`), gated by core's
**Administer site configuration** permission. The page has four tabs:

| Tab | Path | What it controls |
|-----|------|------------------|
| **Settings** | `/admin/config/content/mercury-editor` | Which bundles use Mercury Editor, the edit‑tray theme, and mobile preview presets. |
| **Skip form** | `…/skip-form` | Paragraph types whose create form is skipped, so they insert immediately. |
| **Menu** | `…/menu` | How the "add component" menu is grouped. |
| **Dialog** | `…/dialog` | Dialog defaults, the edit‑tray width, and hover padding. |

## Enabling Mercury Editor for a bundle

On the main **Settings** tab, tick the bundles that should use the builder. Only
entity types that support it are listed (by default node, taxonomy term, and custom
block). Ticking a bundle makes Mercury Editor take over its "edit" experience.

Remember the bundle must already be set up for **Layout Paragraphs** — that is, it
needs a Layout Paragraphs field — otherwise the builder has nothing to edit.

## Settings tab options

- **Edit screen theme** — the admin theme used for the edit tray. Leave it empty to
  use the site's normal admin theme, or choose a dedicated one (for example Gin).
- **Mobile presets** — the device sizes offered in the preview's mobile view. It
  ships with iPhone 12 Pro, iPhone XR, and Pixel 5; add your own, one per line, in
  the format `name|width|height`.

## Skip form tab

List the **paragraph types** whose "create" form should be skipped, so that when an
editor adds one of those components it is inserted straight onto the canvas instead
of opening a form first. Handy for simple components that don't need any up‑front
input.

## Menu tab

Organise the **component menu** — the "add component" list — into groups, so a long
list of paragraph types is easier to browse.

## Dialog tab

Fine‑tune the editing UI:

- **Dialog settings** — per‑dialog‑type width, height, CSS class, whether it's
  resizable, and button behaviour, for the modals that component edit forms open in.
- **Edit tray width** — the default width of the editing tray in pixels (default
  400).
- **Rollover padding** — the vertical and horizontal hover padding drawn around
  components on the canvas.

Save each tab after making changes. Enabled bundles then open in the Mercury Editor
builder the next time you edit one.
