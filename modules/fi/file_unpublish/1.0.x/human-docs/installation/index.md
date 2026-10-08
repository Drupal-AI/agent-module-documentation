# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- Core's **Media** (`media`) and **File** (`file`) modules — enabled automatically
  as dependencies.
- The ability to **adjust your web-server configuration** (Apache `.htaccess` or an
  equivalent Nginx rule). This is not optional — the module's protection relies on
  a web-server rule that checks for marker files.
- On **Apache**, `mod_rewrite` must be enabled.

This is a release candidate (`1.0.0-rc1`) and is **not covered by Drupal's security
advisory policy** — assess it accordingly.

## Install with Composer

From the project root:

```bash
composer require drupal/file_unpublish -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_unpublish -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_unpublish -y
```

## Add the web-server configuration (required)

The module creates marker files, but it is your web server that must refuse to
serve a file when a marker is present. Without this rule the module has no effect.

### Apache

Prepend the following snippet to Drupal's `.htaccess` file. It uses a marker
extension of `.x410` (matching the module's default); adjust to taste if you change
the extension.

```apache
# mod_rewrite is required.
RewriteEngine on

# Files which have a special marker in the file system are not served; a
# "410 Gone" status is returned instead. The marker is an empty file named after
# the original file plus a special extension. For "/path/to/file.pdf" the marker
# is "/path/to/file.pdf.x410". The [G] flag forces a "410 Gone" status.
RewriteRule ^(.*)\.x410$ /$1 [L,R=301]

RewriteCond %{REQUEST_URI} ^/sites/(.*)/files/(.*)$
RewriteCond %{DOCUMENT_ROOT}/sites/%1/files/%2.x410 -f
RewriteRule .* - [G,L]
```

The project can also add this snippet to `.htaccess` automatically during the
Composer install. If you rely on automatic insertion, confirm the snippet is
present in your `.htaccess` afterward.

### Nginx and other servers

Drupal ships no default Nginx config, so there is no snippet to prepend. Implement
the same logic in your own server configuration: for any request under
`/sites/.../files/…`, check whether a companion marker file (the same path plus the
marker extension) exists, and return *410 Gone* if it does.

## Verify it worked

1. Upload a file to a media entity and confirm you can download it directly by URL.
2. Unpublish that media entity.
3. Request the file's direct URL again — it should now return **410 Gone** instead
   of the file, and a marker file (for example `my-file.pdf.x410`) should exist next
   to the original in the filesystem.
4. Republish the media entity and confirm the file serves normally again.
