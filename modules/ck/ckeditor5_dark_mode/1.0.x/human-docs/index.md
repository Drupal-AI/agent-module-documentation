# CKEditor 5 - Dark Mode plugin — manual setup guide

**CKEditor 5 - Dark Mode plugin** (`ckeditor5_dark_mode`) adds a toolbar button
that switches the CKEditor 5 **editing surface** between a light and a dark theme.
It is a comfort and accessibility feature for editors who prefer to write in a
darker interface — and it changes only the editor's appearance, not your content
and not any access rules.

Beyond comfort, it solves a practical problem: if you use plugins that let editors
set text or background colours (such as a CKEditor 5 font-colour or font-size /
font-family plugin) and white text is one of the options, that white text is
invisible against the editor's default white background. Toggling the editor into
dark mode makes such text visible while editing.

The module depends only on core's CKEditor 5 module and runs on a wide range of
Drupal versions (8.8 through 11). It has no central settings page; you make its
button available on a per-text-format basis, walked through in
[Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the Dark Mode button to your
   CKEditor 5 text formats.

## Where it lives in the admin menu

Dark Mode has no standalone settings page. You add its button per text format at
**Administration → Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`) — see [Configuration](configuration/index.md).
