# Configuration

All of Responsive Favicons' settings live on one form. To open it, log in as a user
with the **Administer responsive favicons** permission and go to **Configuration →
User interface → Responsive Favicons**, or navigate directly to
`/admin/config/user-interface/responsive_favicons`.

## Before you start

Generate a favicon package and its HTML snippet at
[realfavicongenerator.net](https://realfavicongenerator.net/). When it asks where the
files will live, choose the **"place files at the root of my site"** option — the
module rewrites the URLs itself, so you do not need to move anything into the
docroot.

## The HTML tags

Paste the `<link>` and `<meta>` snippet that realfavicongenerator.net gave you into
the **HTML tags** textarea (one line per tag). These are the tags the module injects
into every page's head.

## Where the icon files come from

Choose how the module finds the actual icon files:

- **Upload** *(default)* — upload the favicon `.zip` package on this form and the
  module unpacks it into a directory under your site's public files
  (`public://`). The **upload path** field sets that subdirectory (default
  `favicons`). This is the option that keeps per-site icons out of a shared
  multisite docroot.
- **Use internal path** — instead of uploading, point at a directory of icons that
  already lives in your repository, such as
  `/themes/custom/mytheme/favicons`. The **local path** field (relative to the
  Drupal root) sets that location.

Two upload-only helpers appear in upload mode:

- **Upload** — the `.zip` file field itself.
- **Remove previously uploaded files** — recursively delete the existing upload
  folder before unpacking, so a fresh package fully replaces the old one.

## Options

- **Remove default favicon** — strip the `favicon.ico` `<link>` that Drupal core or
  your theme adds, so it does not conflict with your custom icons.
- **Cache refresh suffix** — append a cache-busting query string to icon URLs, so
  browsers pick up updated icons without you having to clear their cache manually.
- **Show missing** — still emit the favicon tags even when some referenced files are
  missing. Useful for a staged rollout where the icons are not all in place yet.

## Save and verify

Click **Save configuration**, then visit **Reports → Status report**
(`/admin/reports/status`). The module reports:

- a "Found N favicon tags" line confirming how many tags it is emitting;
- an error listing any referenced icon files it cannot find (or that carry stray
  cache-busting parameters);
- a warning if the redundant **favicon** module is also enabled, or if the **pwa**
  module is active with a conflicting web manifest.

## `.htaccess` tweak for `/favicon.ico`

For the module to serve `/favicon.ico` itself, comment out this line in your site's
`.htaccess`:

```
# RewriteCond %{REQUEST_URI} !=/favicon.ico
```

## Setting options from Drush

The scalar/path options can be set from the command line, though pasting the HTML
tags and uploading a zip must be done through the form:

```bash
drush cset responsive_favicons.settings path_type path -y
drush cset responsive_favicons.settings path '/themes/custom/mytheme/favicons' -y
drush cset responsive_favicons.settings remove_default 1 -y
drush cr   # clear caches so the new tags are re-read
```
