# CKEditor Accessibility Checker — manual setup guide

**CKEditor Accessibility Checker** (`ckeditor_a11ychecker`) adds an **Accessibility
Checker** button to the CKEditor 5 toolbar. When an editor clicks it, the module runs
the bundled **Sa11y** accessibility engine over the content they're editing and reports
problems — missing alt text, skipped headings, low contrast, vague link text, and so
on — inline in the editor, so issues get caught at authoring time rather than after
publishing.

It's a pure front-end plugin: there's no server-side PHP, no permissions, no settings
page, and nothing stored in your content. You enable it simply by adding its toolbar
button to a text format's CKEditor 5 configuration. It depends only on core's
**CKEditor 5** module.

A nice property for privacy- and offline-conscious sites: the Sa11y engine and its
English language strings ship **with the module and run entirely in the browser**.
There's no external accessibility service to call, no CDN, and no API key — all assets
are self-hosted.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — adding the button to a text format's
   toolbar.

## Where it lives in the admin menu

There's no settings page of its own. You add the button per format at **Configuration →
Content authoring → Text formats and editors** (`/admin/config/content/formats`) —
edit a CKEditor 5 format and drag the **Accessibility Checker** button into the active
toolbar.
