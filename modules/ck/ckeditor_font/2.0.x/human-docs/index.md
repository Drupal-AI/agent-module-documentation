# CKEditor Font — manual setup guide

**CKEditor Font** (`ckeditor_font`) adds four typography controls to the CKEditor 5
toolbar: **Font Family**, **Font Size**, **Font Color**, and **Font Background
Color** (highlight). Each appears as a dropdown in the editor, and each draws from a
list of allowed values that *you* define per text format — so editors get a curated,
on‑brand set of choices rather than free rein. The chosen styles are applied as
inline `<span style="…">` markup, and the module makes sure that markup survives the
text format's HTML filtering.

Because the lists are configured **per text format**, you can offer different options
in different formats — for example a small, tightly controlled set of sizes in "Basic
HTML" and a fuller palette in "Full HTML". Font sizes can be given in `px`, `em`, `%`,
`pt`, `rem`, or CSS keywords, each with a friendly label; font families are entered as
comma‑separated fallback stacks; and colors accept hex, `rgb()`, or `hsl()` values
with custom labels. If you don't curate a list, the Font Size & Family control falls
back to sensible built‑in defaults.

A couple of practical touches: "Support all values" checkboxes let pasted content keep
font sizes or families that fall outside your list instead of stripping them, and a
CKEditor 4 → 5 upgrade path maps the old `Font`/`FontSize` buttons and their settings
onto these plugins automatically.

> **Heads‑up:** this 2.0.x release is a **beta**, and the project README marks the
> module as **deprecated** in favor of the **CKEditor5 Plugin Pack** module for new
> sites. If you're starting fresh, consider that alternative; use CKEditor Font mainly
> to keep existing sites working.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enabling the toolbar buttons and
   configuring the font, size, and color lists per text format.

## Where it lives in the admin menu

CKEditor Font has **no settings page of its own**. You configure it wherever you
configure a text editor: **Configuration → Content authoring → Text formats and
editors** (`/admin/config/content/formats`). The plugin settings appear on each text
format that uses CKEditor 5, below the toolbar, once you add the buttons.

## How to use it

Enable the module, then edit a text format that uses CKEditor 5, drag the Font
Family / Font Size / Font Color / Font Background Color buttons into the active
toolbar, fill in the allowed values that appear below it, and save. Full details are
in [Configuration](configuration/index.md).
