# System Stream Wrapper — manual setup guide

**System Stream Wrapper** (`system_stream_wrapper`) is a small, developer‑focused
module that registers four **read‑only** PHP stream wrappers — `module://`,
`theme://`, `profile://`, and `library://`. These let your code refer to files
that ship inside a module, theme, install profile, or the `libraries/` folder by
a stable *logical* URI instead of a hardcoded filesystem path that changes
between environments.

For example, instead of composing a path with
`\Drupal::service('extension.list.module')->getPath()`, you can write
`file_get_contents('module://mymodule/data/seed.json')`, or build a public URL
to a shipped asset with the stream wrapper manager's `getExternalUrl()`. The
`library://` scheme resolves front‑end libraries placed under `libraries/`, so
you can migrate away from legacy hardcoded `sites/all/libraries` paths.

This module is **pure infrastructure**: it has no admin UI, no settings, no
permissions, and no configuration page. It does its job the instant it is
enabled, and it is consumed entirely from PHP code. It is a common low‑level
dependency of other modules that need to reference their own or a library's
files portably. It requires only Drupal core 10 or 11.

This guide is written for a **human** setting the module up. Because everything
here is code‑facing, the detailed API references — the four schemes, how URIs
resolve, external URLs, the read‑only guarantees, and how to add your own scheme
— live in the sibling [`agent/`](../agent/start.md) docs, which are the best
reference even for a human developer.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — there is no settings page and nothing appears in the admin menu. The
module works silently once enabled.

## How to use it

Enable the module, then use the four schemes anywhere a stream‑aware PHP or
Drupal API accepts a URI:

```php
// Read a file shipped inside a module
$data = file_get_contents('module://mymodule/data/countries.json');

// Read a theme or profile file by machine name (no on-disk path needed)
$svg  = file_get_contents('theme://mytheme/logo.svg');

// Reference a front-end library placed under libraries/
$js   = file_get_contents('library://swiper/swiper.min.js');

// Turn a URI into a public, browser-facing URL
$url  = \Drupal::service('stream_wrapper_manager')
  ->getViaUri('module://mymodule/images/logo.png')
  ->getExternalUrl();
```

The URI shape is always `scheme://<owner>/<target/path/file>`, where *owner* is
the module/theme/profile machine name or the `libraries/` folder name. All four
wrappers are strictly **read‑only** — any attempt to write, delete, rename, or
create a directory through them is a no‑op that emits a warning. Referencing an
owner that is not installed (or a library folder that does not exist) throws an
`\InvalidArgumentException`, so mistakes fail fast.

For the full class hierarchy, the read‑only contract, error behaviour, and
instructions for subclassing the base classes to add your own scheme, see the
[`agent/`](../agent/start.md) docs.
