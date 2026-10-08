# File URL — manual setup guide

**File URL** (`file_url`) gives you a single field type that accepts *either*
an uploaded local file *or* a pasted link to a file that lives somewhere else —
a CDN, an S3 bucket, Dropbox, Google Drive, another site. Both cases are stored
the same way (as a URI), so an editor never has to decide up front whether a
document will be uploaded or linked; they just fill in whichever they have.

Under the hood it extends Drupal core's File field. The widget adds an **Upload
file / Remote file URL** choice to the normal file upload box. Uploaded files
are kept as a stable internal link of the form `/file-dereference/{fid}` that
redirects to the real file, while remote files are stored exactly as the URL you
typed. Because everything flows through one field type, a single multi-value
field can hold a mix of locally hosted and externally hosted files, and the same
display formatter renders both.

There is **no admin settings page** — you configure File URL entirely per field,
on the usual **Manage fields**, **Manage form display**, and **Manage display**
tabs, plus one optional site-wide setting for the link host. It depends only on
core's File module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

File URL adds no menu items of its own and has no configuration screen. You work
with it on any content type (or other fieldable entity) under **Structure →
Content types → *(your type)* → Manage fields**, where "File URL" appears as a
field type you can add.

## How to use it

1. **Add the field.** Go to **Manage fields** for your content type and add a
   new field of type **File URL**. Give it a label (for example "Attachment")
   and, if you want editors to add several files, set the allowed number of
   values above one.
2. **Check the form widget.** On **Manage form display** the field uses the
   *File URL generic* widget. When an editor edits content they get a radio pair
   — **Upload file** or **Remote file URL** — and either upload a file or paste
   an external link. On multi-value fields you can rename the "add another"
   label (the widget's *Add new label* setting).
3. **Choose how it displays.** On **Manage display** the *File URL default*
   formatter has one setting, **mode**:
   - **link** *(default)* — renders a clickable file link showing the file name
     and extension.
   - **plain** — renders the plain file URL as text.
4. **Save and try it.** Create a piece of content, upload one file and paste one
   remote URL into the field, and view the result. Both appear through the same
   formatter.

A few useful details:

- **File usage tracking.** Uploaded (local) files are recorded in Drupal's file
  usage table automatically, so they are not treated as orphaned. Remote URLs
  are not tracked — there is no local file to protect.
- **The dereference link.** Uploaded files are exposed through a stable
  `/file-dereference/{fid}` URL that 302-redirects to the real file. This is
  handy for decoupled front ends or external systems that need one durable link
  even if the underlying file path changes.
- **Canonical host (optional).** If those dereference links should point at a
  specific host (a CDN or public files domain) rather than the site's base URL,
  set the `file_url.settings` key `dereference_host`:

  ```bash
  drush cset file_url.settings dereference_host 'https://files.example.com' -y
  ```

  Leave it empty to use the site's own base URL. This is the only site-wide
  setting the module has, and there is no form for it — set it with Drush or in
  a config export.
