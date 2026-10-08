# CKEditor5 FeColor Plugin — manual setup guide

**CKEditor5 FeColor Plugin** (`ckeditor5_fe_color`) adds a **text colour picker**
to Drupal's CKEditor 5 editor, but with a twist aimed at brand consistency: instead
of an open-ended colour wheel, it offers **predefined, configurable colour
palettes**. Content editors apply your organization's approved colours, so rich
text stays visually consistent across the whole site.

You enable the plugin by adding its **FeColor** button to a CKEditor 5 toolbar per
text format. Once it is there, editors select text and pick a colour from your
palette, which applies both a colour and a corresponding CSS class to the text.

One thing to know up front: **the colour palettes are defined in code, not through
a UI**. The default palette lives in the module's `ckeditor5_fe_color.ckeditor5.yml`
file, and the recommended way to customize colours is from a small custom module
using Drupal hooks (for example `hook_editor_js_settings_alter()` to set the colour
list, `hook_ckeditor5_plugin_info_alter()` to register the colour CSS classes, and
`hook_library_info_alter()` to load your colour stylesheet into the editor). The
module ships an example submodule, **`ckeditor5_fe_color_config_example`**, that
demonstrates a working configuration you can copy from.

The module depends only on core's CKEditor 5, requires Drupal 10.1 or newer, and is
inspired by CU Boulder's `ucb_ckeditor_plugins`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and (optionally) enable the example submodule.

There is **no settings page** — colour palettes are configured in code (see below).
You enable the button per text format, also described below.

## How to use it

1. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`).
2. Edit the text format whose editor is CKEditor 5.
3. In the CKEditor 5 toolbar configuration, drag the **FeColor** (Fe Font Color)
   button into your active toolbar.
4. Save the text format.

Editors can now select text and apply a colour from the palette. To change the
palette itself, override the colours from a custom module using the hooks described
above — the bundled **`ckeditor5_fe_color_config_example`** submodule is the easiest
starting point. Best practice is to define your colours in your own module rather
than editing this module directly, so your customization survives updates.
