# Configuration

File Field Sources has no global settings page. Instead, you turn sources on and
configure them **per field, on that field's widget**, from a **Manage form
display** screen. That means a single File or Image field can offer different
sources in different form modes, and the setup exports with your form-display
configuration.

## Enable sources on a field

1. Go to the **Manage form display** for the bundle that has your File or Image
   field — for example **Structure → Content types → Article → Manage form
   display** (`/admin/structure/types/manage/article/form-display`).
2. Find your **File** or **Image** field row (it uses the `file_generic` or
   `image_image` widget). Click the **gear icon** at the end of the row to open the
   widget's settings.
3. Open the **File sources** section. You will see a checkbox for each available
   source.
4. **Tick the sources you want to offer.** The core **Upload** source stays enabled
   automatically whenever any source is set, so editors never lose the ability to
   upload from their computer.
5. Set any per-source options that appear (see below).
6. Click **Update**, then **Save** the form display. The field's summary now shows
   "File field sources: …" listing what you enabled.

## The available sources

- **Upload** — core's default; always present.
- **Remote URL** (`remote`) — the editor pastes a URL and the module downloads the
  file into the field. Has its own transfer options.
- **Reference existing** (`reference`) — the editor autocompletes an existing
  managed file by name, reusing it instead of uploading a new copy.
- **File attach** (`attach`) — the editor picks a file from a server directory you
  designate (handy for files placed on the server by an external process or FTP).
- **File browser** (`imce`) — choose a file via the IMCE browser. Only shown when
  the IMCE module is installed and the user has access to it.
- **Clipboard** (`clipboard`) — the editor pastes a file (for example a screenshot)
  straight from the clipboard.

## Per-source settings

Some sources add their own options within the **File sources** section:

- **Reference existing** — options such as whether to use autocomplete and whether
  to search across all file fields when matching names.
- **File attach** — the server **path** to pick files from, whether that path is
  absolute or relative, and the **attach mode** (for example move vs copy the file
  out of that directory).
- **Remote URL** — file transfer options for the download.

Fill these in to match how your team supplies files, then **Update** and **Save**.

## Doing it in configuration

The enabled sources and their settings are stored as a third-party setting on the
form-display config entity
(`core.entity_form_display.<entity>.<bundle>.<mode>`), so they deploy with your
exported configuration across environments. The exact config path and a scriptable
example are in the [`agent/`](../agent/start.md) docs.
