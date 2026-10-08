# File Link — manual setup guide

**File Link** (`file_link`) provides a `file_link` field type that extends core's
Link field so it can point **only at files** — and automatically records each
target file's **size** and **MIME type** as extra field data. It's the tidy way to
build a "Download" field: editors paste a URL to a document, and the field stores
the byte size and content type alongside the link, so you can show a friendly "1.2
MB · PDF" next to it without importing the file into Drupal as a managed File
entity. It works with files on your own server or on another server.

The field type behaves like a normal link (it stores a URI and title) but adds two
indexed columns, `size` and `format` (MIME type). Those are populated by making an
HTTP request to the target URL when the field is saved, reading the
`Content-Length` and `Content-Type` response headers. A `LinkToFile` validation
constraint makes sure the URL points at an actual file (not a directory) with an
allowed extension. Per field you control which extensions are allowed, whether
extension‑less URLs are permitted, and whether the metadata fetch happens
immediately on save or is deferred to cron (handy for big imports and slow targets,
processed by the module's queue worker). There is no admin settings page, no
permissions, and no Drush; everything is set through the field's own settings and
display.

File Link ships a default widget and two formatters — **File link** (a single link
that can display the formatted file size) and **File link separate** (title and URL
rendered as separate, screen‑reader‑friendly elements). Two `settings.php` flags
tune the HTTP behaviour site‑wide (see below). Its dependencies are core's **Link**
and **File** modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module adds no page of its own. You use it wherever you manage a bundle's
fields — **Structure → Content types → (your type) → Manage fields**
(`/admin/structure/types/manage/article/fields`) to add and configure a File Link
field, and **Manage display** to pick a formatter.

## How to use it

**1. Add the field.** On a content type's **Manage fields** page, add a new field
of type **File Link**. On its settings form you can set:

- **Allowed file extensions** — a space‑separated list such as `pdf` or
  `pdf doc docx zip` (defaults to `txt`). The `LinkToFile` constraint rejects links
  to other extensions.
- **Allow URLs with no extension** — tick this if you need to link to
  extension‑less URLs (for example API endpoints).
- **Defer metadata request** — when ticked, the field is not validated/fetched on
  save; instead the entity is queued and its size/format are filled in on the next
  cron run. Use this for bulk imports or slow/unreachable targets.

**2. Choose a formatter.** On **Manage display**, set the field's format to **File
link** or **File link separate**. Both offer a **Format file size** option that
shows the stored size as a human‑readable value (e.g. "1.2 MB"). The core link
formatter still works too, but only the `file_link` formatters expose the metadata.

**3. Use the metadata.** Because `size` and `format` are stored field properties,
you can also surface them in tokens, Views fields, or theme code.

## Site‑wide HTTP settings (settings.php)

Two flags in `settings.php` tune how File Link makes its HTTP requests:

```php
// Do not follow HTTP redirects when validating a file_link (default: TRUE, follow).
$settings['file_link.follow_redirect_on_validate'] = FALSE;

// Completely disable ALL outbound HTTP requests for file_link fields — no size/format
// is fetched and no validation request is made. Recommended for bulk content imports
// (default: FALSE).
$settings['file_link.disable_http_requests'] = TRUE;
```

Setting `disable_http_requests` to `TRUE` keeps migrations fast and offline‑safe;
turn it back off afterward so metadata is fetched again on save.
