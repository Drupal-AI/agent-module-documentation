# Vendor Stream Wrapper — manual setup guide

**Vendor Stream Wrapper** (`vendor_stream_wrapper`) lets you reference CSS, JS,
fonts, and other assets that live inside Composer's `vendor/` directory — usually
outside the webroot — directly from your Drupal libraries, without copying them
into the docroot or setting up a build step. It registers a read-only `vendor://`
stream wrapper, so a path like `vendor://vendor-name/package/path/file.css`
resolves to the real file inside `vendor/` and gets served with a proper public
URL.

The main payoff is cleaner dependency management. A Composer package that ships
front-end assets can have those assets used straight from where Composer installed
them, so you never commit vendor files into your site's web directory or maintain
symlinks. You reference them in a `*.libraries.yml` file with the `vendor://`
scheme and the module rewrites the path to a working URL automatically; there is
also a helper, `vendor_stream_wrapper_create_url()`, for resolving URIs in PHP.

Because `vendor/` contains far more than a few stylesheets, access is deliberately
locked down. **Nothing under `vendor/` is web-accessible until you explicitly
allow it** with a safe-list of glob patterns. Files are served through a dedicated
`/vendor_files/{filepath}` route, and a file is only downloadable if it matches one
of your patterns — so you expose exactly the assets you intend and block
everything else. Other modules can also contribute their own safe-list patterns
programmatically.

This guide is written for a **human** setting up a site. If you want terse,
token-cheap references for an AI coding agent — the services, the download route,
and the safe-list event — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

Because this is a developer-oriented module, its usage and its one settings screen
are described together below rather than on a separate page.

## Where it lives in the admin menu

The safe-list settings form is at **Configuration → Media → Vendor Stream
Wrapper** (`/admin/config/media/vendor-stream-wrapper`), available to users with
the **Administer site configuration** permission.

## How to use it

**1. Reference a vendor asset from a library.** In any `*.libraries.yml` file, use
the `vendor://` scheme pointing at the file inside `vendor/`:

```yaml
my_library:
  css:
    theme:
      vendor://some-vendor/some-package/dist/style.css: {}
  js:
    vendor://some-vendor/some-package/dist/widget.js: {}
```

The module rewrites those `vendor://` paths to real URLs when the library is used.
To build a URL in PHP instead, call
`vendor_stream_wrapper_create_url('vendor://some-vendor/some-package/file.css')`
(pass `FALSE` as the second argument for a root-relative path).

**2. Safe-list the files you want served.** This is the required step —
until you do it, nothing under `vendor/` will download and Drupal's status report
shows a warning. Go to **Configuration → Media → Vendor Stream Wrapper** and, in
the **allowed file patterns** textarea, add one glob pattern per line, relative to
the vendor directory. `*` is the only wildcard:

```
some-vendor/some-package/dist/*.css
some-vendor/some-package/dist/*.js
some-vendor/other-package/fonts/*
```

Save. Each line becomes a rule that permits matching files to be served through
`/vendor_files/...`. Patterns are re-read per request, so changes take effect
without a cache rebuild. (If you prefer, other modules can add patterns in code by
subscribing to the module's safe-list collection event — see the
[`agent/`](../agent/start.md) docs.)

**3. (If needed) tell the module where `vendor/` is.** By default it looks for the
vendor directory at `../vendor` then `./vendor`. If yours is somewhere else, set it
in `settings.php` — this is a settings value, not editable from the admin UI:

```php
$settings['vendor_file_path'] = '/path/to/vendor';
```
