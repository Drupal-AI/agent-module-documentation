# Embera — manual setup guide

**Embera** (`embera`) is a thin Drupal wrapper around the excellent
[Embera](https://github.com/mpratt/Embera) PHP oEmbed library by Michael Pratt.
Embera takes a URL — a YouTube, Vimeo, Twitter, or other supported link — and
returns the rich HTML needed to embed it, with extras like offline support,
responsive embeds, and caching.

Installing this module does two things: it pulls the Embera PHP library into your
project's `/vendor/` folder, and it exposes a Drupal service, **`embera.manager`**,
that other code can use. That service wraps Embera's file cache for storing
provider responses (with a configurable duration) and offers convenience methods —
`getThumbnailUrl()`, `getTitle()`, `getEmbedCode()`, and `getEmbedInformation()` —
each of which also uses static in‑request caching for performance.

This is a **developer‑facing** module. It has no content types, no fields, no
blocks, and no settings form of its own — you shouldn't install it unless you
intend to use its service directly, or another module requires it as a dependency.
Note that the embeds it produces come from third‑party oEmbed providers.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (which brings in
   the Embera PHP library) and enable the module.

There is **no configuration UI** for this module. Its behaviour is tuned through
configuration settings that developers set in code/config rather than through an
admin form (see "Settings for developers" below).

## How to use it

Other modules use Embera by calling its service:

```php
$manager = \Drupal::service('embera.manager');
$code = $manager->getEmbedCode('https://www.youtube.com/watch?v=…');
```

The manager returns the embed code (or a thumbnail URL, title, or the full oEmbed
response) for a supported URL, caching the provider's response so repeated calls
are fast.

## Settings for developers

Embera exposes a few configuration values you can override (in code or exported
config) rather than through a form:

- **`embera.class.configuration`** — options passed to the underlying Embera class
  (see the library's "Passing configuration options" documentation for what is
  supported).
- **`embera.file_cache.duration`** — how long, in seconds, provider responses are
  kept in the file cache (default `3600`).
- **`embera.file.cache.disabled`** — set to `TRUE` to turn the file cache off
  entirely.
