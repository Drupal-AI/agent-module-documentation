# Configuration

Breadcrumb Manager works the moment it is enabled — path‑based breadcrumbs appear
with no setup. Everything on this page is **optional tuning** of how those
breadcrumbs look and which paths they apply to.

## Open the settings form

1. Log in as a user with the **Administer Breadcrumb Manager** permission.
2. Go to **Configuration → User interface → Breadcrumb Manager**, or navigate
   directly to `/admin/config/user-interface/breadcrumb-manager`.

The settings are stored in the `breadcrumb_manager.config` configuration object.

## Which paths get breadcrumbs

- **Excluded paths** — a textarea, one path per line, listing paths the module
  should leave alone. Wildcards are allowed (for example `/user`, `search/*`). The
  default is `/user`. When "Show on front page" is off, the front page is treated as
  excluded too.
- **Show the breadcrumb on the front page** — off by default. Turn it on if you want
  a breadcrumb on the home page as well.

## The "Home" link

- **Show Home link** — on by default. Prepends a "Home" link to the start of every
  breadcrumb. Uncheck it to omit the Home link entirely.
- **Home label** — an optional text field to override the "Home" link's label. Leave
  it empty to use the word "Home"; set it to, say, your site name or "Start" to
  relabel it.

## The current page

- **Show current page** — on by default. Includes the current page as the final
  segment of the breadcrumb. Uncheck it to end the breadcrumb at the parent.
- **Show current page as a link** — on by default. When ticked, the last segment is
  a clickable link; when unticked, it is rendered as plain text.

## Route‑less "fake" segments

- **Show fake segments** — off by default. When enabled, path segments that have no
  matching route are still shown, using a humanized version of the raw path as the
  title. These segments can be relabeled or given a real link by a module
  implementing `hook_breadcrumb_manager_fake_segments_alter()` — useful when a URL
  contains a structural segment that is not itself a page.

## Title resolver priority

At the heart of the module is a **drag‑and‑drop table of title resolvers**. Each
row is one resolver plugin, with a checkbox to enable it and a weight to order it.
When building a breadcrumb, Breadcrumb Manager asks the **enabled** resolvers, in
weight order, for a title for each segment and uses the **first non‑empty** answer.

The three shipped resolvers are:

| Resolver | Default order | Where the title comes from |
|----------|---------------|----------------------------|
| **Menu link title** | first | The title of a menu link on that segment's route (prefers the main menu). |
| **Request title** | second | The route's page title. |
| **Raw path component** | last | A humanized version of the last path element (used as a fallback and for fake segments). |

Reorder them if you prefer a different source of truth — for example, move "Request
title" above "Menu link title" to favour page titles. Uncheck a resolver to disable
it. Any custom resolver plugins a developer adds appear here automatically.

## Save

Click **Save configuration**. Changes take effect immediately (breadcrumbs are
cached per URL with the config's cache tag, so saving refreshes them). You can also
set individual keys from the command line, for example:

```bash
drush config:set breadcrumb_manager.config show_home 0 -y
drush config:set breadcrumb_manager.config home 'Start' -y
```
