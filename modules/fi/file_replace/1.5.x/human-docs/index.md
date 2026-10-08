# File replace — manual setup guide

**File replace** (`file_replace`) is a small admin utility that lets you overwrite
the *contents* of an existing managed file with a freshly uploaded one — while
keeping the original file's URL, filename, and file entity ID exactly the same. That
means every existing link, embed, or reference to the file keeps working and simply
starts serving the new content. No hunting down old links, no re-pointing menus, no
broken bookmarks.

This is the tool you reach for when, say, a PDF price list is linked from dozens of
pages and you need to publish a corrected version at the same URL, or when a logo
embedded across the site needs swapping out, or when someone uploaded the wrong file
and you want to fix it without changing its ID. To keep things safe, the replacement
must use the **same file extension** as the original, and only **permanent** files
can be replaced (temporary or unmanaged files cannot).

The module adds a **Replace** form for core file entities at
`/admin/content/files/replace/{file}`. If the replaced file is an image and core's
Image module is on, it automatically flushes that image's cached style derivatives
so thumbnails regenerate from the new content. There is **no settings form** — you
just wire the replace link into wherever you manage files, then use it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the
`hook_file_replace()` extension point — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally add the shell-exec submodule.

## Where it lives in the admin menu

There is no dedicated configuration page. The replace action surfaces in the places
where you already work with files:

- On the admin **Files** listing (**Content → Files**,
  `/admin/content/files`), a **Replace** operation is added automatically to each
  file's operations dropdown.
- In any View based on **Files**, you can add a **Link to replace file** field.
- Anywhere you like (a text field, block, or Twig template), you can link to
  `admin/content/files/replace/{{ fid }}` manually.

Access is gated by the **Replace files** (`replace files`) permission, which is
marked security-sensitive — grant it only to trusted roles, since replacing a file
overwrites content served at an existing, possibly widely-linked URL. Set it at
**People → Permissions** (`/admin/people/permissions`).

## How to use it

1. Enable the module and grant **Replace files** to the roles that should have it.
2. Go to **Content → Files**, find the file, and choose **Replace** from its
   operations (or visit `/admin/content/files/replace/{file id}` directly).
3. Upload the replacement — it must have the same extension as the original — and
   save. The file's URL, filename, and ID stay the same; its size and change date
   are recalculated, and any image thumbnails are refreshed.
