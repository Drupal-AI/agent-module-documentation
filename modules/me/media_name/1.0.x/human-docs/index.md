# Media Name — manual setup guide

**Media Name** (`media_name`) fixes two small but persistent annoyances with
Drupal's core Media *Name* field. First, when the Name field is shown on a
media add/edit form, core forces editors to type something. Media Name makes that
field **optional** — leave it blank and the media is named after its file, exactly
as core would do on its own. Second, and more usefully, it **preserves a custom
media name when the underlying file is replaced**: if you called a document "User
manual" and later swap `user_manual_v1.pdf` for `user_manual_v2.pdf`, the title
stays "User manual" instead of silently changing to the new filename.

The module works quietly through form and field alterations — it only acts on
media types where the Name field is actually shown on the form, and it leaves
core's automatic naming untouched everywhere else. It pairs naturally with the
Media Entity File Replace workflow, because it compares filenames (not internal
file IDs) when deciding whether to keep your custom name.

There is one optional setting, a single checkbox that lets you opt back into
core's "name follows the file name" behaviour when that suits your site better.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Media Name adds one settings page at **Configuration → Media → Media Name
settings** (`/admin/config/media/media-name/settings`), which is gated by the core
**Administer media** permission.

## How to use it

The core behaviour — optional name and preserved-name-on-file-replace — is active
as soon as you enable the module, with one important prerequisite: it only acts on
media types whose **Name field is visible on the form**. If a bundle hides the
Name field, expose it at *Structure → Media types → (your type) → Manage form
display* first.

The settings page has a single control:

- **File name override** *(off by default)* — leave this **off** to keep your
  custom media name when a file is replaced (the module's headline feature). Turn
  it **on** to restore core's behaviour, where replacing a file updates the media
  name to the new file name — but only when the media name still matched the old
  file name and wasn't manually edited in the same save. Turn it on if your
  editors expect the title to track the filename.
