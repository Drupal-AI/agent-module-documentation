# Configuration

File Download has **no global settings page**. You configure it per field, per view
mode, on the entity's *Manage display* page by choosing one of its two formatters.
The one thing you set globally is the **access file download** permission (see
[Installation](../installation/index.md)).

## Choose a formatter on a field

1. Go to the bundle's **Manage display**, e.g. an Article:
   *Structure → Content types → Article → Manage display*
   (`/admin/structure/types/manage/article/display`).
2. Find your file or image field's row. In the **Format** column, open the dropdown
   and pick **File Download** (the download-link formatter) or **File Download URI**
   (the raw-URL formatter).
3. Click the gear/cog icon on that row to open the formatter's settings.
4. Set the options (below), click **Update**, then **Save** at the bottom of the
   page.

## The File Download formatter (file and image fields)

This renders each file as a forced-download link. Its settings:

- **Link title** — what the link text should be. Choose one of:
  - *File* (the default) — use the file's own filename as the link text.
  - *Entity title* — use the parent entity's title, e.g. "Download Annual Report".
  - *Description* — use the file field item's description text.
  - *Nothing* — no text, an icon-only download control.
  - *Custom* — type your own text in the field that appears (see below).
- **Custom title text** — only used when *Link title* is set to *Custom*. This is
  **token-aware**: you can include tokens for the current user, the file, and the
  parent entity, and it accepts a limited set of HTML. For example
  `Download [file:name] ([file:type])`. The module adds a handy **`[file:type]`**
  token that outputs the short file type (e.g. `pdf` for a PDF).
- **File size** — tick this to append the human-readable file size next to the link
  (e.g. "report.pdf (2.3 MB)").

Out of the box the formatter uses the filename as link text, no custom text, and no
file size.

## The File Download URI formatter (file and image fields)

This outputs just the **download URL string** — no clickable link — which is handy
when you want to build your own markup in a custom template or a Views field. Its
only setting:

- **Absolute URL** — tick this to output a full absolute URL (including scheme and
  domain), for example for use in emails or feeds; leave it unticked for a
  root-relative URL.

## What the download link actually does

The links produced by these formatters point at a route the module provides,
`/file-download/download/{scheme}/{fid}`. When a user clicks it, the module streams
the file back with headers that tell the browser to **save it as an attachment**
rather than display it — with the correct content type and length. This is what
makes documents and even images download to disk instead of opening in the tab.

Because it goes through this controlled route, it works for files in the **private**
file system too, and it honours core's file-access rules: a user still needs the
**access file download** permission, and private files still respect any
`hook_file_download` access checks other modules add. The route also verifies that
the requested file scheme matches the file's real storage, so users cannot swap
`public` for `private` to grab a protected file.

## Where the settings are stored

Formatter choices live in the entity view display config, at
`core.entity_view_display.<entity_type>.<bundle>.<view_mode>`, under the field's
component (its `type` plus the `settings` you chose). That means you can export the
configuration and deploy it with the rest of your site. You can read a display's
current setup with:

```bash
drush cget core.entity_view_display.node.article.default content.field_attachment
```

## Tip: different labels per view mode

Because the formatter is set per view mode, you can give the same field different
download labels in different contexts — for example "Download the full report" on
the full page and just "Download" on the teaser. Configure each view mode's *Manage
display* separately.
