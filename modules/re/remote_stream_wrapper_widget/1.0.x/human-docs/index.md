# Remote Stream Wrapper Widget — manual setup guide

**Remote Stream Wrapper Widget** (`remote_stream_wrapper_widget`) lets an editor
fill in a normal Drupal **File** or **Image** field by typing a remote
`http://` or `https://` URL instead of uploading a file from their computer. The
URL is stored as a real Drupal `file` entity that points at the remote address,
so the rest of the site treats it much like any other file — it just happens to
live on someone else's server.

The module is deliberately tiny. It adds exactly one field widget (called
**Remote stream wrapper**) and nothing else — no settings page, no permissions,
no Drush commands. The actual work of reading remote files (registering the
`http`/`https` stream wrappers and fetching the bytes when Drupal needs them,
for example to build an image thumbnail) is done by the required **Remote Stream
Wrapper** module that this one depends on.

Because the widget does no check on the file type or extension beyond the browser's
basic URL validation, it is best used on fields whose sources you trust, such as a
curated CDN or a partner server.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its Remote
   Stream Wrapper dependency) with Composer and enable it.

## Where it lives in the admin menu

There is no configuration page for this module — `configure` is `null`, and it
adds nothing to the admin menu. You turn the widget on per field, from a
bundle's **Manage form display** tab, as described below.

## How to use it

The widget is opt‑in on each File/Image field you want it on:

1. Add or reuse a **File** or **Image** field on your content type, media type,
   or other entity bundle.
2. Go to that bundle's **Manage form display** tab
   (`admin/structure/…/form-display`).
3. Find your field and change its **Widget** to **Remote stream wrapper**.
4. Click **Save**.

The field now shows a single URL text box instead of the usual file‑upload
control. When an editor enters a URL and saves the entity, the module looks for
an existing `file` entity with that exact address and reuses it if one is found;
otherwise it creates a new `file` entity (owned by the current user) pointing at
the URL and stores it on the field. Editing the URL later simply swaps the file
source — there is no need to re‑upload anything.

Typical uses include referencing an image hosted on an external CDN or digital
asset manager, pointing a File field at a document on a partner server, or
keeping a canonical remote source such as `https://cdn.example.com/logo.png` as
the field value without copying the bytes onto your own server.
