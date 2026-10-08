# CKEditor Span — manual setup guide

**CKEditor Span** (`ckeditor_span`) adds a toolbar button to CKEditor 5 that lets
editors wrap selected text in a `<span>` tag. Out of the box, CKEditor 5 has no
simple way to add an inline `<span>` around a run of text; this small plugin fills
that gap so editors can create inline wrappers — typically as a hook for CSS
classes or other inline styling — directly from the editor.

It is a lightweight CKEditor 5 plugin that depends only on core's CKEditor 5
module. There is no settings page: you enable it per text format by adding its
button to the toolbar. Keep in mind that what the `<span>` may ultimately carry
(for example a `class` attribute) is still governed by the text format's allowed
HTML — the plugin adds the button, but your format decides what markup is allowed
to be saved.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. Setup is a single per-format
step, described below.

## Where it lives in the admin menu

CKEditor Span adds no admin page of its own. You enable it per text format at
**Administration → Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`): edit a format that uses CKEditor 5 and drag the
**Span** button from *Available buttons* into the *Active toolbar*, then save.
Editors then select text and click the button to wrap it in a `<span>`.
