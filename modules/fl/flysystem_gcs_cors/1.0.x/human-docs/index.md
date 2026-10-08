# Flysystem GCS CORS — manual setup guide

**Flysystem GCS CORS** (`flysystem_gcs_cors`) lets a user's browser upload files
**directly to a Google Cloud Storage bucket**, instead of routing every upload
through the Drupal server first. It adds a file-field widget that hands the file
straight from the browser to GCS over a signed, CORS-enabled request — which
takes the load of large uploads off your web server entirely.

It builds on [Flysystem GCS](../../../fl/flysystem_gcs/8.x-1.x/human-docs/index.md),
so you configure your GCS bucket and credentials there first; this module then
makes any file field that uses the Flysystem GCS stream wrapper upload directly to
that bucket. It is a fork of the *S3 File System CORS Upload* module, adapted for
Google Cloud Storage. It depends on Flysystem GCS and the
[Token](https://www.drupal.org/project/token) module, and it provides its own
permission gating who may perform direct uploads.

Because the module configures **CORS on your bucket**, the settings here are
security-sensitive: a too-permissive CORS policy can allow uploads from
unintended origins. Scope CORS to your own site's origin, keep the GCS
credentials and signing key stored as secrets, and rely on short-lived, scoped
signed URLs.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, configure the
   Flysystem GCS stream wrapper, and grant the service account the required roles.
2. [Configuration](configuration/index.md) — the admin form where you enter your
   site URL to apply the CORS setting to the bucket.

## Where it lives in the admin menu

The module's settings form is at **Configuration → Media → GCS CORS**
(`/admin/config/media/gcs-cors`). Once you save it with your website URL, the
module writes a CORS rule to the configured GCS bucket, and any file field using
the Flysystem GCS stream wrapper will then upload directly to the bucket.

## How to use it

1. Set up the Flysystem GCS stream wrapper in `settings.php` (see
   [Flysystem GCS](../../../fl/flysystem_gcs/8.x-1.x/human-docs/index.md)).
2. Make sure the service account has the right roles (see Installation).
3. Open **Configuration → Media → GCS CORS**, enter your site URL, and save. This
   applies the CORS setting to your bucket for that origin.
4. Any file field whose upload destination is the Flysystem GCS stream wrapper
   will now upload directly from the browser to the bucket, for users who hold the
   module's upload permission.
