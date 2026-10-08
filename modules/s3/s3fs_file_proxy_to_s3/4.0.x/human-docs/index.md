# S3FS File Proxy to S3 — manual setup guide

**S3FS File Proxy to S3** (`s3fs_file_proxy_to_s3`) is a small helper for
**staging and pre-production** environments that use S3 for their public files,
just like production does. When such a staging site is asked for a public file it
does not have, this module fetches that file from the **production** S3 bucket and
uploads it into the **staging** bucket — so you get production media on demand,
without copying the whole bucket up front and without downloading anything to the
staging server's local disk.

It applies the well-known Stage File Proxy pattern, but rewired for S3. The stock
`stage_file_proxy` module downloads missing production files to the local
filesystem, which is the wrong behaviour when both production and staging store
their public files in S3. This module swaps in S3-aware versions of the public
stream wrapper, the fetch manager and the request subscriber so both the origin
fetch and the destination write go through S3 instead.

The behaviour only activates when the s3fs public-file takeover is switched on
(`$settings['s3fs.use_s3_for_public'] = TRUE`). It depends on both the **S3 File
System** (`s3fs`) and **Stage File Proxy** (`stage_file_proxy`) modules, has no
admin UI of its own, no settings form, and no submodules — it is driven entirely
by those two modules' configuration plus that one settings flag. It is intended
for staging only, not production, where the files already live in the production
bucket.

This guide is written for a **human**. If you are an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — enable the module and its two
   dependencies, turn on S3-for-public, and point Stage File Proxy at production.

## How it works

There is nothing to visit in the admin menu. Once enabled and activated, a
staging request for a public file the bucket lacks is intercepted: if the file
already exists it redirects to it, otherwise the fetch manager downloads it from
the production origin (the URL you configured in Stage File Proxy) and writes it
into the staging bucket through the s3fs public stream wrapper. Image-style
requests are served from the module's own `/s3fs_to_s3/files/styles/...` path — the
original is fetched and the derivative regenerated.

A note on safety, drawn from the module's own docs: the fetch origin is always the
production URL you configured in Stage File Proxy, built from that origin plus the
requested public path — it never fetches a URL taken from the incoming request, so
there is no arbitrary-URL fetch (SSRF) surface. Requested paths are confined to the
`public://` scheme. S3 credentials come from the s3fs module (in `settings.php`),
never from this module, and are not logged.
