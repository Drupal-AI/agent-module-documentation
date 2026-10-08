<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Applies the stage_file_proxy pattern to S3-backed sites: when a staging site requests a public file it lacks, the file is fetched from the production S3 bucket and uploaded into the staging S3 bucket.

---

The stock stage_file_proxy module downloads missing production files to the local filesystem, which is wrong when both production and staging use S3 for the public files scheme. This module rewires stage_file_proxy so the origin fetch and the destination write both go through S3. It activates only when `Settings::get('s3fs.use_s3_for_public')` is true; a `ServiceProvider` then swaps three services — the public stream wrapper becomes `PublicS3fsFileProxyToS3Stream`, the fetch manager becomes `S3fsFileProxyToS3FetchManager`, and the stage_file_proxy request subscriber becomes `S3fsFileProxyToS3Subscriber`. A route subscriber also repaths the s3fs image-styles route to `/s3fs_to_s3/files/styles/{image_style}/{scheme}`.

Operationally: the fetch origin is the production server URL configured in stage_file_proxy (not a request-supplied URL), and requested paths are confined to the `public://` scheme; the subscriber redirects to an already-present file rather than re-downloading it. S3 credentials are supplied through the s3fs module (typically in `settings.php`), not by this module, and are never logged. This is a staging/pre-production convenience — it is not intended for production, where files already live in the production bucket.

---
- Serve missing public files on staging by pulling them from the production S3 bucket
- Populate a fresh staging S3 bucket lazily, on first request, instead of copying everything up front
- Reuse an existing stage_file_proxy origin configuration for an S3-backed site
- Keep image-style derivatives working on staging by fetching the original from production S3
- Avoid downloading production files to the staging local filesystem
- Point a pre-production environment at production media without a full bucket sync
- Activate the behaviour only when `s3fs.use_s3_for_public` is set in settings.php
- Rewrite the s3fs image-styles route to the module's `/s3fs_to_s3/files/styles/...` path
- Redirect directly to a public file that already exists locally/in S3
- Fetch the original image for a requested style derivative and regenerate it
- Save fetched files into the staging bucket via the s3fs public stream wrapper
- Set up a demo/QA environment that mirrors production media on demand
- Combine with s3fs credentials stored in settings.php for both buckets
- Reduce storage/setup cost of staging environments that mimic S3 production
- Let editors preview production-referenced media on staging without manual uploads
- Keep the production bucket read-as-origin while writing only to the staging bucket