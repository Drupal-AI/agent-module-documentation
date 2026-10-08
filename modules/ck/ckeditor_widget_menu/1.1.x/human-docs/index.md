# CKEditor Widget Menu — manual setup guide

**CKEditor Widget Menu** (`ckeditor_widget_menu`) tidies a crowded CKEditor
toolbar by **collecting a group of buttons into a single dropdown**. Instead of a
long row of widget buttons taking up space, you place one **Widget Menu** button
in the toolbar; the buttons next to it (in the same group) are removed from the
main toolbar and tucked into a dropdown behind that single button.

It works with both **CKEditor 5** (core) and the contrib **CKEditor 4** module.
The module itself has no other Drupal dependencies, but it does need a small
third-party **JavaScript library** placed in your site's `libraries` directory
before the dropdown will work — see the installation guide. There is no settings
page: you configure which buttons get grouped simply by where you position the
Widget Menu button relative to other buttons in the toolbar.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   download the required JavaScript library, and enable it.

There is **no configuration page** for this module. Grouping is controlled by
toolbar layout, described below.

## Where it lives in the admin menu

CKEditor Widget Menu adds no admin page. You set it up per text format at
**Administration → Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`):

- **CKEditor 5:** place the **widget_menu** button in the toolbar between pipe
  (`|`) separators, with the buttons you want grouped positioned to its right.
  Those buttons are moved into the dropdown.
- **CKEditor 4:** place the **widget_menu** button inside a toolbar *group* that
  contains the other buttons; each button in that group is moved into the dropdown.

Position the button, save, and the grouped buttons appear under a single dropdown
in the editor.
