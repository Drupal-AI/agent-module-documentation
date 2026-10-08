# CKEditor 4 - LTS — manual setup guide

**CKEditor 4 - LTS** (machine name `ckeditor`, Composer project
`drupal/ckeditor_lts`) brings back the CKEditor 4 WYSIWYG editor that was removed
from Drupal core in favour of CKEditor 5. It is essentially the old core CKEditor 4
module lifted into contrib, bundling the commercially supported **"Long Term
Support" build 4.25.1-lts** and adding a field for the LTS license key that build
requires.

Because it is the old core module, its architecture matches core CKEditor 4 exactly:
it registers a `ckeditor` text-editor plugin for the core **Text Editor** (`editor`)
module, you attach it to a text format, and you build the toolbar with the
drag-and-drop toolbar builder. It ships the familiar Drupal integration plugins —
`drupalimage`, `drupalimagecaption`, `drupallink`, `drupalmedia`,
`drupalmedialibrary`, `language`, and `stylescombo` — and defines the `CKEditorPlugin`
plugin type so custom CKEditor 4 plugins keep working.

> **Important — this is a migration bridge, not a long-term choice.** CKEditor 4
> reached **end of life in June 2023**. This LTS build carries post-EOL security
> patches, but those patches require a **paid Extended Support Model license key**.
> Use this module to keep an existing CKEditor 4 setup (and any custom CKEditor 4
> plugins) working on Drupal 10/11 while you migrate to **CKEditor 5**, which is the
> right editor for new sites. Note also that the editor itself is not XSS-safe by
> design, so — exactly as in core — keep a proper HTML-restricting filter enabled on
> any text format that uses it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter the LTS license key, attach
   CKEditor to a text format, and build its toolbar.

## Where it lives in the admin menu

- The module's own **LTS license-key** form is at **Configuration → Content
  authoring → CKEditor4 - LTS** (`/admin/config/ckeditor-lts/settings`).
- You attach the editor and build its toolbar at **Configuration → Content
  authoring → Text formats and editors** (`/admin/config/content/formats`), exactly
  as with any Drupal text editor.
