# Remote Stream Wrapper — manual setup guide

**Remote Stream Wrapper** (`remote_stream_wrapper`) lets Drupal treat a file that
lives on another server as if it were a normal managed file — **without ever
downloading it to your local disk**. It does this by registering `http://` and
`https://` as real Drupal "stream wrapper" schemes, so a managed file entity's URI
can simply *be* the remote URL. Point a file entity at
`https://cdn.example.com/photo.png` and Drupal happily creates it; the bytes stay
where they are.

Concretely, once the module is on, everyday PHP filesystem calls just work against
remote URLs: `file_exists('https://example.com/report.pdf')`,
`file_get_contents(...)`, `fopen(...)` and `File::create(['uri' => 'https://…'])`
all behave as expected, with Drupal's HTTP client doing the fetching behind the
scenes. The wrapper is deliberately **read‑only** — Drupal can read a remote file
but can never overwrite or delete the bytes on the other server (deleting the
*file entity* record is fine).

This is a good fit when your assets live in a CDN or a digital‑asset‑management
system, when you're cataloguing thousands of externally hosted files and want to
keep your own disk footprint flat, or when you're migrating legacy content that
already stores absolute URLs. The module can also generate **image‑style
derivatives** (thumbnails, crops) from remote originals — serving the resized
copies locally like any other derivative — and it improves **MIME‑type detection**
for external URLs, even ones with no file extension, by reading the server's
`Content-Type` header.

This is a **developer‑oriented, code‑only** module: it has **no settings form, no
permissions, and nothing to configure**. You use it from code (or from other
modules that build on it, such as a media source that accepts a URL). Because of
that, this guide has no configuration page — the section below shows the common
patterns.

This guide is written for a **human**. If you want terse, token‑cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead — they cover the services, helper functions, and image‑style routing in
full.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and note the PHP cURL requirement.

## Where it lives in the admin menu

Nowhere — Remote Stream Wrapper adds **no admin page and no settings**. It works
entirely at the code/API level once enabled. Note that the `http`/`https` schemes
it adds are intentionally *not* offered as upload destinations in field settings;
they're for reading and for URIs you set yourself.

## How to use it

### Create a managed file for a remote URL (no download)

```php
use Drupal\file\Entity\File;

$file = File::create([
  'uri' => 'https://example.com/assets/photo.png',
  'status' => 1,   // permanent
]);
$file->save();

$file->getFileUri();      // https://example.com/assets/photo.png
$file->getMimeType();     // image/png — guessed automatically on save
```

You can then reference that file from any file or image field by its ID, exactly
like a locally uploaded file.

### Read remote bytes with normal PHP calls

```php
file_exists('https://example.com/a.txt');
$body = file_get_contents('https://example.com/a.txt');
```

### Tell remote files apart from local ones

The module adds three helper functions for custom code:

```php
file_is_uri_remote('https://example.com/a.png');  // TRUE
file_is_scheme_remote('https');                   // TRUE
```

Use these to guard code that only makes sense for local files — for example,
anything that calls `realpath()`, which always returns FALSE for a remote URI.

### Image styles from remote originals

With the module enabled, image styles applied to a remote original are rerouted so
their derivatives are generated and cached locally (under `public://styles/…`),
giving you thumbnails and crops of externally hosted images with no extra setup.
