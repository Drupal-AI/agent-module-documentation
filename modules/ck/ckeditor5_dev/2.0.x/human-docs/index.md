# CKEditor 5 Dev tools — manual setup guide

**CKEditor 5 Dev tools** (`ckeditor5_dev`) is a developer's aid for anyone building
or debugging CKEditor 5 integrations in Drupal. It answers the two questions that
consume most CKEditor 5 integration time: *which CKEditor 5 plugins are registered
and what markup does each allow*, and *what is the editor's model doing while I type* —
the latter being something you cannot see by inspecting the DOM, because CKEditor's
model is not the DOM.

It does three things:

- **Enables the official CKEditor 5 Inspector**, a debugging overlay that appears
  on any page with an initialized CKEditor 5 instance, letting you inspect the
  editor's model, view, and commands live.
- **Adds a plugin report** at `/admin/reports/ckeditor5-plugins`, listing every
  CKEditor 5 plugin registered on the site (label, id, allowed HTML elements, and
  the providing module) — the full registered set, not one text format's subset.
- **Ships a plugin starter template** (in `ckeditor5_plugin_starter_template/`)
  that scaffolds a module providing a custom CKEditor 5 plugin.

The module depends only on core's CKEditor 5 and runs on Drupal 10.5, 11, and 12.
It defines a permission, **access ckeditor5 plugin report**, controlling who can
see the report.

**Important: this is a development tool — do not leave it enabled in production.**
The Inspector is a debugging overlay and the report exposes editor configuration.
It is exactly the kind of module a production-readiness check will flag. Enable it
in your local or development environment while you work, and disable it before
deploying.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (in development only).

There is **no settings form**. Once enabled, the Inspector appears automatically
and the report lives in the admin menu, described below.

## Where it lives in the admin menu

- The **plugin report** is at **Administration → Reports → CKEditor 5 plugins**
  (`/admin/reports/ckeditor5-plugins`), visible to users with the *access
  ckeditor5 plugin report* permission.
- The **Inspector** is not a menu item — it appears automatically as an overlay on
  any page that has an initialized CKEditor 5 editor (for example a node edit
  form).
- The **starter template** is a directory in the module
  (`ckeditor5_plugin_starter_template/`) that you copy when scaffolding your own
  custom plugin module.
