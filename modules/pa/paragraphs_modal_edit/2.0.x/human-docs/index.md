# Paragraphs Modal Edit — manual setup guide

**Paragraphs Modal Edit** (`paragraphs_modal_edit`) is a small usability layer on
top of the
[Paragraphs Edit](https://www.drupal.org/project/paragraphs_edit) module. It makes
a rendered paragraph's contextual **edit / clone / delete** links open the
Paragraphs Edit forms inside a Drupal **AJAX modal dialog** — right where the
paragraph appears on the page — instead of navigating away to a full‑page form.
After you save, only that one paragraph is re‑rendered in place, so editors keep
their scroll position and avoid a full‑page reload when tweaking a single
paragraph among many.

It's a "thin" module: content editors get no new forms, and there's nothing to
learn beyond the contextual links they already use. Everything happens through
hooks — the module attaches the dialog libraries, turns the paragraph contextual
links into AJAX modal triggers, and swaps the edit/clone/delete form buttons to
AJAX callbacks that close the dialog and update (or remove) the paragraph on
success, then return you to the page you were on. It also bumps the parent node's
"changed" timestamp when a paragraph is edited this way.

The module requires **Paragraphs** and **Paragraphs Edit** (plus Entity Reference
Revisions), and runs on **Drupal 10.3+, 11, or 12**. It has one configuration
option — the modal's width — and no permissions or Drush commands of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Paragraphs and Paragraphs Edit.

## Where it lives in the admin menu

The one setting lives at **Configuration → User interface → Paragraphs Modal
Edit** (`/admin/config/user-interface/paragraphs-modal-edit`), which requires the
**Administer site configuration** permission.

## How to use it

There's nothing to switch on beyond enabling the module — the modal behavior
applies automatically to the paragraph contextual links on your rendered content.
As an editor, hover a paragraph on the front end, open its contextual menu, and
choose **Edit** (or **Clone** / **Delete**); the form opens in a modal dialog.
Save, and just that paragraph updates in place; delete, and it's removed from the
page. Cancel or a validation error keeps the dialog open. This works even for
paragraphs nested inside other paragraphs — the module resolves the root parent
entity for you.

**Setting the modal width.** Go to **Configuration → User interface → Paragraphs
Modal Edit** and pick a **modal width** from the dropdown — the options run from
**60%** to **100%** (default **90%**). Widen it for paragraph forms that have many
fields or media. You can also set it from Drush (the stored value is `6`–`10`,
mapping to 60%–100%):

```bash
drush config:set paragraphs_modal_edit.settings modal_width 10 -y   # 100% wide dialog
```
