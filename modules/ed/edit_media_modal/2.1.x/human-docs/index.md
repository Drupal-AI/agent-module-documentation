# Edit Media Entity in Modal — manual setup guide

**Edit Media Entity in Modal** (`edit_media_modal`) lets content editors fix an
embedded Media entity in a pop-up dialog without leaving the page they are working
on. Its headline feature is an **edit** button added to the CKEditor 5 media
toolbar: when an editor clicks an embedded image or media item, an edit button
appears, opening the media's edit form in a modal so they can correct the alt text,
caption, or other metadata and save — all without navigating away from the article.

Under the hood the module has two parts. It ships a **CKEditor 5 plugin**
(`media_edit_media_modal`) that adds the edit button to the media (drupalMedia)
toolbar; you switch it on per text format, and it only activates on formats that
already have Drupal's core media embedding. And it replaces the Media entity's edit
form with an AJAX-aware version so the modal submits cleanly. Beyond CKEditor, a
developer can add an "Edit this media" modal link anywhere by rendering the media's
edit link with an `edit_media_in_modal=TRUE` query flag.

The CKEditor plugin has a few per-format options you set on the text-format edit
page: the **dialog height** (as a percentage), a **skip access check** toggle
(shows the edit button without checking per-item edit permission — fine for simple
sites), and a per-media-bundle map choosing **which form mode** opens in the modal
(so images, documents, and remote video can each use a different, streamlined edit
form). The module depends only on core **Media**; it defines no settings object,
permissions, or Drush commands of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

Turning the edit button on for a text format and its options are covered in the
*How to use it* section below.

## Where it lives in the admin menu

There is no dedicated settings page (the module's info file has no configure
route). You enable and tune the edit button per text format at **Configuration →
Content authoring → Text formats and editors**
(`/admin/config/content/formats`), in the CKEditor 5 plugin settings.

## How to use it

1. Go to *Configuration → Content authoring → Text formats and editors* and edit a
   format that uses **CKEditor 5** *and* has Drupal's media embed button on its
   toolbar (this module's button only activates when core media embedding is
   present).
2. Scroll to the CKEditor 5 plugin settings and find the **Edit Media Modal**
   section. Here you can set:
   - **Dialog height** — the modal height as a percentage (1–100; default 75).
   - **Skip access check** — when ticked, the edit button shows without checking
     whether the current user may edit each media item. Convenient for simple
     sites; leave it off where media edit permissions matter.
   - **Form mode per media bundle** — choose which media *form mode* opens in the
     modal for each bundle (e.g. a lightweight "quick edit" mode for documents,
     the default form for images).
3. **Save**. Now, when editing content with that format, click an embedded media
   item and use the new **edit** button on its toolbar to open the media form in a
   modal, edit, and save — without leaving the page.

Developers can reuse the same modal editing on custom links; see the
[`agent/`](../agent/start.md) docs for the `edit_media_in_modal` query flag and the
helper routes.
