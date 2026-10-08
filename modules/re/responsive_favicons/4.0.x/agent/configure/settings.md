# Configure Responsive Favicons

**Route:** `responsive_favicons.admin` → `/admin/config/user-interface/responsive_favicons`
(menu link under *Configuration › User interface*). Requires the
`administer responsive favicons` permission. Form class:
`Drupal\responsive_favicons\Form\ResponsiveFaviconsAdmin` (a `ConfigFormBase`).

## Prerequisite

Generate a favicon package + HTML snippet at https://realfavicongenerator.net/. Choose the
"place files at the root of my site" option there — the module rewrites the URLs itself.

## Config object: `responsive_favicons.settings`

Defaults (`config/install/responsive_favicons.settings.yml`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `path_type` | string | `upload` | `upload` = unpack an uploaded zip into public files; `path` = use an existing in-repo directory. |
| `path` | string | `favicons` | In `upload` mode: subdirectory under `public://`. In `path` mode: path relative to `DRUPAL_ROOT` (e.g. `/themes/custom/mytheme/favicons`). |
| `tags` | sequence(string) | `[]` | The favicon `<link>`/`<meta>` lines pasted from realfavicongenerator.net (one per line; stored as an array). |
| `remove_default` | integer | `0` | If truthy, strips Drupal's default `core`/`themes` `favicon.ico` head link. |
| `cache_refresh_suffix` | integer | (unset) | If truthy, appends a cache-busting query suffix to icon URLs. |
| `show_missing` | integer | (unset) | If truthy, emit tags even when the referenced files are missing. |

Form-only fields (not stored directly): `upload` (the zip file), `remove_existing_files`
(recursively delete the upload folder before unpacking). Radios `path_type` toggle whether
the "upload path" (`public://`-relative) or "local path" (`DRUPAL_ROOT`-relative) textfield
is used; both write to the single `path` key.

## Set via drush (instead of the UI, for the `path` mode)

```
drush cset responsive_favicons.settings path_type path -y
drush cset responsive_favicons.settings path '/themes/custom/mytheme/favicons' -y
drush cset responsive_favicons.settings remove_default 1 -y
```

Read current config: `drush cget responsive_favicons.settings`.
Pasting the HTML tags and uploading a zip must be done through the form (multi-line
textarea + file upload); drush can only set the scalar/path options and a pre-built `tags`
array. After changing files or config, clear caches (`drush cr`) so `page_attachments`
re-reads them.

## `.htaccess` note for `/favicon.ico`

For the module to serve `/favicon.ico`, comment out this line in the site's `.htaccess`:

```
# RewriteCond %{REQUEST_URI} !=/favicon.ico
```

## Verify

The status report (`/admin/reports/status`, or `drush core:requirements`) shows a
"Found N favicon tags" line, an error listing any missing/mis-referenced icon files, and
warnings if the `favicon` or `pwa` modules conflict (see `hook_requirements()` in
`responsive_favicons.install`).
