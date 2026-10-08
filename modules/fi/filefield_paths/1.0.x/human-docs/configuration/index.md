# Configuration

Configuration happens in **two places**: a per‑field settings section on every
File/Image field (where the real work is), and one small global form that sets the
default temporary upload location.

## Per‑field settings (the main configuration)

Go to **Structure → Content types → *(your content type)* → Manage fields**, edit a
File or Image field, and open its **Field settings**. File (Field) Paths adds a
**File (Field) Path settings** section there.

First tick **"Enable File (Field) Paths?"** to reveal the settings. Then fill them in:

- **File path** — a token pattern for the destination **directory**. For example
  `articles/[node:nid]` puts each article's uploads in a folder named after the node
  ID. If the Token module is installed, you get a token‑tree link to browse the
  available tokens (from the field's own entity type, plus `file` and `date` tokens).
- **File name** — a token pattern for the **stored filename**. For example
  `[node:nid]-[file:name]` prefixes the original filename with the node ID, which also
  helps avoid collisions.
- **File path/name cleanup options** — each of the two patterns above has the same set
  of checkboxes:
  - **Remove slashes** — strip `/` characters out of token values, so a multi‑part
    token can't accidentally create extra subfolders.
  - **Clean up using Pathauto** — run the segment through Pathauto's alias cleaner
    rules (available only when the Pathauto module is enabled).
  - **Transliterate** — convert non‑Latin characters to safe US‑ASCII on upload.
- **Temporary file location** — the scheme where uploads for *this field* land before
  they're processed. Leave it blank to use the global default (below).
- **Create Redirect** — when a file moves to a new path, create a redirect from its old
  URL to the new one. Available only when the Redirect module is enabled.
- **Retroactive update** — when you save the field, run a one‑time batch that
  **moves/renames every existing file** of that bundle to match the current patterns,
  then switches itself back off. Use with care, ideally on a copy of the site first.
- **Active updating** — re‑move/rename a file **every time** its parent entity is
  saved. Also a careful/advanced option.

### How files actually move

Because the full token values aren't known while a file is still uploading, the file
is first saved to the temporary location, then moved to its final token‑built path
when the entity is inserted or updated. That's why the destination reflects, say, the
node title even though the title didn't exist as a saved value at upload time.

### Where these settings are stored

All per‑field values are saved as **third‑party settings on the field's
configuration**, so they export and deploy together with the field itself via
`drush config:export` / `import`.

## Global settings form

At **Configuration → Media → File system → File (Field) Paths**
(`/admin/config/media/file-system/filefield-paths`), with the **Administer site
configuration** permission, you set one thing:

- **Temporary file location** — the default temporary upload location used whenever a
  field leaves its own "Temporary file location" blank. The default is
  `public://filefield_paths`.

The form recommends using `temporary://` (or `private://` if you need file previews
before the entity is saved) and warns against `public://` on sites that support
private files, since files briefly live there before being moved into place.
