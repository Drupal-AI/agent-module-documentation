# FakeObjects — manual setup guide

**FakeObjects** (`fakeobjects`) registers the CKEditor **4** "fakeobjects" utility
plugin with Drupal so that other CKEditor 4 plugins that depend on it can work. It
is a behind-the-scenes support plugin: it has no toolbar button, adds no editor
configuration, and offers no settings of its own. You install it because some
*other* CKEditor 4 add-on (typically an image or link dialog plugin) lists
"fakeobjects" as a requirement, or because you're seeing a "plugin not detected"
error asking for it.

The module is a thin integration layer — it exposes the third-party JavaScript
library to Drupal's CKEditor 4 module and loads it into any text format that uses
CKEditor 4. The JavaScript itself is **not** bundled with the module: you download
the CKEditor add-on (version 4.5.11 or newer) from ckeditor.com and place it at
`/libraries/fakeobjects`. The module checks for that file on install and on the
status report, so a missing library is flagged early.

Two things to keep in mind. First, this targets **CKEditor 4 only** — if you have
migrated fully to CKEditor 5, you don't need it, and you can remove it. Second, on
**Drupal 10 and 11** CKEditor 4 is no longer part of core, so you also need the
contributed `drupal/ckeditor` module for this plugin to have an editor to attach
to.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   download and place the JavaScript library, and enable it.

## Where it lives in the admin menu

FakeObjects has no admin pages, no permissions, and no configuration. Once the
module is enabled and the library is in place, the plugin is loaded automatically
into CKEditor 4 text formats and used by whatever plugin required it. You can
confirm it's installed on the status report at **Reports → Status report**
(`/admin/reports/status`), which shows "Plugin detected" when the library file is
present.
