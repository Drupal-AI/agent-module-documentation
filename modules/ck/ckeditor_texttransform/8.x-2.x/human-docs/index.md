# Text Transform — manual setup guide

**Text Transform** (`ckeditor_texttransform`) is a simple module that adds
case-changing buttons to **CKEditor 4**. With selected text, an editor can convert
it to **UPPERCASE**, **lowercase**, or **Capitalize Each Word**, or use a
**switcher** button that loops through all the cases in turn.

This is a **CKEditor 4** integration: it depends on the contrib **CKEditor**
module (the CKEditor 4 editor), not core's CKEditor 5. It supports Drupal 8, 9,
and 10. Importantly, the module only provides the Drupal glue — the actual editor
behaviour comes from the third-party **Text Transform** CKEditor add-on, which you
must **download and place in your site's `libraries` directory** before the buttons
will work. See the installation guide for that step.

There is no settings page. Once the library is in place and the module is enabled,
you add the button(s) to a format's toolbar.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   download the required CKEditor library, and enable it.

There is **no configuration page** for this module. Setup is the library download
(covered in Installation) plus a per-format toolbar step, described below.

## Where it lives in the admin menu

Text Transform adds no admin page. After the library is in place, you add its
button(s) per text format at **Administration → Configuration → Content authoring →
Text formats and editors** (`/admin/config/content/formats`): edit a format that
uses the CKEditor 4 editor, drag in the Text Transform button(s) — uppercase,
lowercase, capitalize, and/or the switcher — and save. Editors then select text and
click a button to change its case.
