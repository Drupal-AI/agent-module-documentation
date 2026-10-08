# Configuration

Flysystem GCS CORS has a small admin form whose job is to write a **CORS rule to
your Google Cloud Storage bucket** so browsers on your site are allowed to upload
directly to it.

## Before you open the form

Make sure the prerequisites from [Installation](../installation/index.md) are in
place:

- The Flysystem GCS stream wrapper is configured in `settings.php`.
- The service account has `roles/storage.admin` on the bucket and
  `roles/iam.serviceAccountTokenCreator` on itself.

Without those, the module cannot apply the CORS setting or sign uploads.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Media → GCS CORS**, or navigate directly to
   `/admin/config/media/gcs-cors`.

## The website URL

The form asks for your **website URL** — the origin that browsers will be
uploading from (for example `https://www.example.com`). When you save, the module
adds a CORS rule to the configured GCS bucket permitting cross-origin upload
requests from that origin.

- **Scope it tightly.** Enter only the origin(s) your site actually serves from.
  A too-permissive CORS policy can let uploads come from unintended origins, so
  avoid wildcards and keep the list to your real site URL(s).
- If your site is reachable at more than one hostname (for example with and
  without `www`, or a separate staging domain), be deliberate about which origins
  you allow.

## Save

Click **Save configuration**. The module applies the CORS setting to your bucket
immediately. From then on, any file field using the Flysystem GCS stream wrapper
uploads directly from the browser to the bucket, for users who hold the module's
upload permission.

## A note on permissions

This module provides its own permission that gates who can perform direct
uploads. Review it at **People → Permissions**
(`/admin/people/permissions`) and grant it only to the roles that should be able
to upload directly to the bucket.
