# Configuration

SD Breadcrumb is configured in four stages — global settings, per-content-type
patterns, optional custom patterns, and optional per-node overrides.

## 1. Global settings

1. Log in as a user with permission to administer the module.
2. Go to **Configuration → User interface → SD Breadcrumb**
   (`/admin/config/user-interface/sd-breadcrumb`).

Here you set the site-wide defaults:

- **Front page and current page inclusion** — whether to include the front-page
  segment and the current-page segment (these apply to *System Default* mode only).
- **Front page segment title** — the label for the front-page segment (default
  "Home"), with an option to replace it with an icon (System Default mode only).
- **Capitalisation** — capitalise the first letter of each word, with a
  configurable ignore list for words you do not want capitalised.
- **Remove duplicate segments** — automatically drop repeated segments from a trail.
- **Cache and logging** — a configurable cache max-age for performance, plus
  optional error and generation logging for troubleshooting.

## 2. Content-type patterns

On the same settings page, a table lists every content type. For each type you can:

- **Enable or disable** breadcrumbs entirely.
- Choose **System Default** (Drupal's path-based trail) or **Custom Pattern** mode.
- Click **Add/Edit Pattern** to open the visual builder.

## 3. Building a custom pattern

In the pattern editor, use the drag-and-drop builder to compose the trail. Add,
remove, and reorder segments; each segment has:

- **Label** — static text, or a token such as `[node:title]`, `[node:field_category]`,
  or `[node:author:name]`. A token browser is available when the Token module is
  installed.
- **Link** — an internal path (`/node/123`, `/about`), an external URL
  (`https://example.com`), an anchored link (`/page#section`, when enabled in global
  settings), the front page (`/`), or no link at all.
- **Icon** — chosen from the Media Library.
- **Display mode** — text only, icon only, or both.

Because all labels are stripped of HTML and user input is validated, you can build
these safely, but as always grant the module's administrative permission only to
trusted editors.

## 4. Per-node overrides

On any node's edit form, open the **Breadcrumb Settings** section to:

- **Disable** breadcrumbs for that specific node.
- Switch from the content-type pattern to a **node-specific pattern**, built with
  the same visual builder.

## Save

Save the settings form (and the node edit form for overrides). Changes take effect
on the affected pages immediately, subject to the cache max-age you configured.
