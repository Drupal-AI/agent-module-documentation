# Field Zip File — manual setup guide

**Field Zip File** (`field_zip_file`) provides a field type for uploading a **ZIP
archive** that the module automatically **extracts on save**. Instead of unpacking
files by hand, you attach the field to a content type, upload a `.zip`, and the
archive's contents become available once the entity is saved. It can even serve
extracted HTML (for example in an iframe), which makes it handy for hosting a
packaged HTML5 asset or a self-contained report.

Extraction is delegated to Drupal core's ZIP archiver (the same mechanism core uses
for module installs), and the module layers on two safeguards: a **zip-bomb
scanner** that inspects an archive before extraction, and a configurable
**forbidden-extensions** filter that blocks file types you do not want unpacked. It
also ships a "bypass content restrictions" permission for trusted roles. It depends
only on core's Field and File modules.

Restrict the upload field to trusted roles, and set the forbidden-extension
filter to block file types you do not want unpacked before letting other users
upload.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

This module has **no site-wide settings page**. Its options (the file directory,
the forbidden-extensions filter, and how contents are displayed) live on the
**field** you add and on that field's display — see "How to use it" below.

## Where it lives in the admin menu

Field Zip File adds no admin configuration page of its own. You use it by adding
the **Zip File** field type to a content type (or other fieldable entity) under
**Structure → *(entity type)* → Manage fields**, and by choosing how its contents
are shown under **Manage display**.

## How to use it

1. Go to **Structure → Content types → *(your type)* → Manage fields → Add field**
   and choose the **Zip File** field type.
2. Configure the field's settings (including the **forbidden extensions** you want
   blocked — set these before allowing untrusted uploads) and save.
3. On **Manage display**, pick how extracted contents are presented — for example
   an iframe/HTML formatter if you are hosting a packaged HTML asset.
4. Create or edit content of that type, upload a `.zip` file, and save. The module
   scans the archive, blocks forbidden extensions, and extracts the contents.
5. Restrict who can upload archives via the module's permissions on
   **People → Permissions**, granting the "bypass content restrictions" permission
   only to fully trusted roles.
