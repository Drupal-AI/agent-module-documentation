# Material Icons — manual setup guide

**Material Icons** (`material_icons`) brings Google's **Material Icons** and the
newer **Material Symbols** into Drupal in two ways: as a dedicated **field type**
with an autocomplete icon picker, and as a **CKEditor 5 toolbar button** for
dropping icons straight into rich text. Editors search for an icon by name, see a
live preview of each glyph as they type, and pick a style (Filled, Outlined,
Rounded, Sharp, Two‑Tone, or one of the Material Symbols families).

The module adds no icons to your pages on its own — you decide where they appear.
Add a Material Icons field to a content type and each node can carry an icon; or
add the toolbar button to a text format and authors can insert icons inline in the
body. A field value stores three parts: the icon name, the style (family), and any
extra CSS classes, and it renders as a small `<i class="material-icons …">` tag.

One thing worth knowing up front: the icon fonts are loaded from Google Fonts, and
only the **families you enable** on the settings page actually load on the page.
This keeps page weight down, but it also means an icon won't display until its
family is switched on. The module depends only on core's **Editor** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The settings form sits at **Configuration → Content authoring → Material Icons**
(`/admin/config/content/material_icons`). It is gated by the **Administer material
icons** permission. A second permission, **Use material icons**, controls who can
use the icon‑picker dialog and the autocomplete.

## How to use it

### 1. Choose which icon families load

Go to **Configuration → Content authoring → Material Icons**
(`/admin/config/content/material_icons`) and tick the families you want available
site‑wide. The default is just **baseline** (Filled). Each family you enable is
attached to every page as a Google Fonts stylesheet, so enable only what you need.
The available families are the classic Material Icons set — Filled (`baseline`),
Outlined, Round, Sharp, Two‑Tone — and the Material Symbols set — Outlined,
Rounded, Sharp.

### 2. Add an icon field to a content type

1. Edit a content type under **Structure → Content types → Manage fields**.
2. Add a new field of type **Material icons**.
3. On the form display (**Manage form display**), the widget shows an
   autocomplete name box plus a style dropdown. Its per‑widget settings let you:
   - **Allow style selection** — let editors pick the style, or lock the field to
     one style by turning this off.
   - **Default style** — pre‑select a style for new values.
   - **Allow classes** — show (or hide) a box for extra CSS classes such as an
     alignment helper.
4. On the display (**Manage display**), the Material Icons formatter renders each
   value as an icon.

### 3. Add the icon button to a text editor

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit a CKEditor 5 format (for example
   **Full HTML**).
2. Drag the **Material Icons** button from *Available buttons* into the active
   toolbar.
3. Make sure the format's filters allow `<span>` with a `class` attribute — the
   button inserts a `<span>` carrying the icon's classes.
4. Save. Authors now get a **Material Icons** button that opens the same icon
   picker and drops the chosen icon into the text.

Remember that inserted or attached icons only display if their font family is
enabled on the settings page (step 1).
