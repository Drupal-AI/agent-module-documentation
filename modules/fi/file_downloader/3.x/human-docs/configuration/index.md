# Configuration

Setting up File Downloader is a three-part job: create the download options,
apply the formatter to a field, and grant the permissions that let people use
each option.

## 1. Create Download Option Config entities

A **Download Option Config** entity describes one downloadable variant. Each one
selects a plugin and carries its own settings — most importantly, the file
extensions it is allowed to apply to. Two plugins ship with the module:

- **Original file** — offers a download link to the original file stored on the
  server.
- **Image Style** — lets you select an image style and offers a download link for
  that derivative. If the styled image has not been generated yet at the moment of
  download, the plugin generates it first.

Create one Download Option Config entity per variant you want to offer. For
example, to give editors both a high-resolution and a low-resolution download of
an image, create two entities — one *Original file* and one *Image Style* — each
with the appropriate allowed extensions.

## 2. Apply the File downloader formatter to a field

1. Go to **Structure → Content types → *(type)* → Manage display** (or the
   equivalent *Manage display* for whatever entity holds the field).
2. For your file or image field, set the format to **File downloader**.
3. Open the formatter settings and tick the **Download Option Config** entities
   you want to expose as links on that field.

When the field is rendered, File Downloader validates that each file's extension
falls within a given option's configuration; if it does, it renders that option's
download link.

## 3. Grant the per-option permissions

Each Download Option Config entity has its own permission, named
`use {id} download option link` (where `{id}` is the entity's machine name). A
download link only works for users whose role holds the matching permission.

Go to **People → Permissions** and grant each option's permission to the roles
that should be able to use it. This is how you decide *who* may download through
each option.

## How access is enforced

File Downloader serves files through its own controller route, and it checks
access properly at download time:

1. the per-option permission (`use {id} download option link`) must be held;
2. the file's extension must fall within the option's configured extensions; and
3. the file's **own view access** must pass (`$file->access('view')`).

Because the file's view access is always checked, a user cannot download a private
file they could not otherwise view simply by guessing its id. Set the per-option
permissions to match who should download, and core's file-access layer handles the
rest.
