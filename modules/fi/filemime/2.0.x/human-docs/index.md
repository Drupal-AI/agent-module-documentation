# File MIME — manual setup guide

**File MIME** (`filemime`) lets site administrators change the **MIME type** Drupal
records for uploaded files. Drupal normally guesses a file's MIME type from its
filename extension, using a hard‑coded mapping in core — and that guess is wrong
often enough to matter. Modern formats tend to arrive faster than the mapping is
updated, so a `.webp`, `.avif`, `.woff2`, or `.geojson` file can be recorded as the
generic `application/octet-stream`; office documents have famously long, easily
mistyped types; and a bespoke extension gets nothing useful at all.

The recorded type is not cosmetic. It becomes the **`Content-Type` header** when the
file is downloaded, which decides whether a browser displays a PDF or downloads it,
whether a font loads, and whether a video plays. A wrong type is a file that
"doesn't work" for reasons nobody can see from inside Drupal. File MIME lets you
correct that: extend or override the built‑in mapping, optionally seed it from the
server's own `mime.types` file, and apply your changes retroactively to files that
were already uploaded. Disabling the module restores Drupal's built‑in mapping.

One point is worth stating plainly, because it runs *opposite* to what the module is
for: **a MIME type is a claim, not a fact.** Forcing a type onto a file asserts
something about content nobody has inspected — a file recorded as `image/png` is not
necessarily a PNG. Anything downstream that trusts the recorded type instead of the
actual bytes (an image processor, a viewer, a client app) is trusting whoever
uploaded the file. **Extension‑based validation remains your real upload control**;
this module changes the label, not the contents, so avoid mapping an unexpected
extension to a permissive type.

File MIME **2.0.2** has a tight core requirement: **Drupal 11.2 or later (or 12)**
only. It depends on core's **File** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the MIME‑type mapping settings, field
   by field, including the retroactive‑apply option.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Media → File MIME**
(`/admin/config/media/filemime`), the module's `filemime.settings` route.
