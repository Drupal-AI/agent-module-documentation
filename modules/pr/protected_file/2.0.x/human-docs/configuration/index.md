# Configuration

Protected File has **no global settings page**. You set it up in three steps: add a
Protected File field, configure its widget and formatter, and grant the download
permission. This page walks through all three.

## 1. Add a Protected File field

1. Go to **Structure → Content types → (your type) → Manage fields** (or the manage
   fields screen of any fieldable entity).
2. Add a field of type **Protected File**.
3. On the field settings you'll notice the **storage scheme is locked to Private
   files** — you can't choose Public. That's deliberate: protection only works for
   private files. Everything else (allowed file extensions, maximum upload size,
   upload directory, description field) works exactly like a normal File field.

## 2. Configure the widget (Manage form display)

Under **Manage form display**, the Protected File field uses the **Protected File**
widget. It behaves like the core file widget, but once a file is uploaded it shows a
**Protected** checkbox next to that file. For multi-value fields, a "Protected"
column appears in the file table. Editors tick this box, file by file, to decide
which uploads are gated and which are open.

## 3. Configure the formatter (Manage display)

Under **Manage display**, the field uses the **Protected File** formatter. This
controls what visitors see and where unauthorized users are sent. Its settings:

| Setting | Default | What it does |
|---|---|---|
| **Open in new window** | On | Opens the file link in a new browser tab. |
| **Redirect path** | `/user/login` | Where a user *without* the download permission is sent when they click a protected file. Leave it blank to render the filename as plain text (no link) instead. |
| **Redirect to file** | Off | When on, after the redirect the user is sent on to the file itself (for example, straight to the download after logging in) rather than back to the page they came from. |
| **Open in modal** | Off | Opens the redirect path (e.g. the login form) in an AJAX modal dialog instead of a full page load. |
| **Protected message** | "You need to be logged in to be able to download this file" | The tooltip/title text shown on a protected link. |

Users who **do** have the download permission always get a direct link to the file.
Users who **don't** see a lock icon, and their link points at the redirect path
instead of the file. Remember this is display-side polish only — the actual gate is
enforced server-side regardless of what the formatter shows.

## 4. Grant the download permission

At **People → Permissions**, grant **Download protected file**
(`download protected file`) to the roles that should be able to download protected
files — for example a *Members* or *Subscribers* role. Anyone without it is redirected
on the display side and denied on the download side, even if they know the direct
file URL.

## Using it day to day

When editing content, upload files to the Protected File field and tick **Protected**
on the ones you want to gate. Leave the box unticked for files that should stay openly
downloadable. You can mix protected and open files within a single multi-value field.

## Media entities

A `protected_file` media source is provided, so you can create a media type backed by
protected files if you manage downloads through the Media library.

## For developers: custom access rules

Every protected download dispatches a `ProtectedFileAccessEvent`
(`protected_file.check_access`). Subscribe to it to allow or deny per file based on
your own logic — the file's owner, a purchase record, group membership, and so on.
The event carries the current access result, the file URI, the file entity, and the
host entity. See the sibling [`agent/`](../agent/start.md) docs for a worked
subscriber example.
