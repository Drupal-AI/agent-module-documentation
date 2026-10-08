<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Varnish File Purge sends a PURGE or BAN request straight to your Varnish server for a file's URL whenever that file is created, changed, or deleted in Drupal — so a replaced file that keeps the same URL stops being served stale from the cache.

---

Drupal's cache invalidation works on tags, and files sit outside that model. When an editor replaces a PDF, an image, or a document while keeping the same filename — which is what "replace this file" means to everyone who is not a developer — the URL is identical, so Varnish keeps serving the old bytes until the object expires. This module closes that gap by hooking the file entity's insert, update, and delete, and on each of those firing an HTTP request (the configured verb, `PURGE` or `BAN`) directly at a configured Varnish host for the file's absolute URL. Two mechanics matter for reasoning about it. First, **it does not use the Purge framework** despite its package name and the modules it is compared against: there is no `purge` dependency, no queue, and no processor — the requests go out synchronously from within the request that saved the file, via Guzzle, once per configured domain using a spoofed `Host` header so a multi-domain / separate-back-office setup is covered. Second, on **update** it purges only when the content genuinely changed — it compares the old and new file size, then the URI, then a `sha256` of the two files on disk — which is what makes it work with the `file_replace` module where the URI is deliberately kept stable. Optionally it also walks every image style, and for PNG/JPEG files purges the derivative URLs that already exist on disk. Two things are worth attaching. **Establish that the site actually keeps file URLs stable** — image-style derivatives carry an `itok` and many file fields rename on replacement, in which case this solves a problem the site does not have. And **name every cache between the file and the reader**: a CDN in front of Varnish caches the same object under the same URL, so purging Varnish alone leaves the stale copy at the edge.

---

- Purge a replaced PDF from Varnish when the filename is unchanged.
- Invalidate a file whose URL stays the same across a replacement.
- Make the `file_replace` module actually flush Varnish (its main design target).
- Update a logo for all visitors immediately after re-upload.
- Fire a `PURGE` request per file save without running the Purge framework.
- Use the `BAN` method instead, for VCL configured around bans.
- Purge a file across several domains (front-end host plus a separate back-office host).
- Purge the image-style derivatives (thumbnails, responsive sizes) of a replaced PNG/JPEG.
- Fix "the old version is still showing" for downloadable documents.
- Invalidate a replaced attachment on a document-heavy site.
- Purge a stale price list or compliance document after an editor replaces it.
- Support an editorial file-replacement workflow where URLs must not change.
- Skip purging when a file save did not actually change the bytes (size/URI/hash unchanged).
- Purge a file on delete so Varnish stops serving a removed asset.
- Send purges to a Varnish server on a non-standard host/port/scheme.
- Log every purged URL while debugging a stale-cache problem (Debug toggle).
- Point purges at an HTTPS Varnish endpoint.
- Cover a reverse-proxy tier that Drupal's tag-based invalidation cannot reach for files.
- Reason about why a Purge + Purge File setup failed to purge replaced files across domains.
- Decide whether the site even has the stable-URL problem this module solves before installing it.
