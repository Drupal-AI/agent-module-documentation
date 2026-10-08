# Download File — manual setup guide

**Download File** (`download_file`) adds a *Direct Download* formatter for file
fields. Normally, core's file formatters produce a link straight to the file, and
what happens next is up to the browser — PDFs, images and text files usually open
inline in a new tab. This module changes that: its formatter points links at a
Drupal controller that serves the file's bytes with download headers, so the file
saves to disk instead of opening in the browser.

The mechanics are simple and safe. The `direct_download` field formatter renders
links to a controller route; the controller returns the file with headers that
force a download. Crucially, **access is not bypassed** — the download route
defers to Drupal's own file access check (`download` access on the file), so
private-file rules and any contrib access logic are honoured exactly as they would
be for a normal file link. The module adds no permission and no bypass of its own.

For developers, there is a `hook_download_file_headers_alter()` hook that lets
other modules adjust the response headers per file — the documented example being
setting an `Expires` header for CDN behaviour.

There is no configuration page, no permissions and no Drush commands: the only
setting is choosing the formatter on a file field's display.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Download File adds no pages of its own. You select the **Direct Download**
formatter on a file field's **Manage display** screen (Structure → Content types →
*type* → Manage display, or the equivalent for other entity types and view modes).

## How to use it

1. Have a **file field** on a content type, media type or other entity.
2. Go to the entity's **Manage display** screen — for example **Structure →
   Content types → Article → Manage display** — and pick the view mode you want
   (Default, Teaser, and so on).
3. Set the file field's **Format** to **Direct Download**, then save.

Now that field's links point at `/download/file/{file}`, and clicking one forces
the file to download rather than open inline. Some things worth knowing:

- **You can offer both behaviours.** Use Direct Download on one view mode (a
  "download" link) and a normal file link on another (a "view" link).
- **Access is preserved.** Because the download route uses the file's own
  `download` access check, this works correctly for private files — a user who
  cannot access the file still cannot download it.
- **Downloads stream through PHP.** Very large files bypass any web-server-level
  `X-Sendfile` optimisation unless you add it yourself via the headers hook.
- **It needs a file entity.** The route takes a file entity id, so raw file paths
  that are not backed by a `file` entity are not supported.
- **Developers can tune the headers** per file with
  `hook_download_file_headers_alter()` — see the [`agent/`](../agent/start.md)
  docs for an example.
