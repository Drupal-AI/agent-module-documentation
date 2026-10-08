<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Flysystem GCS CORS allows directly uploading files to GCS from the web browser.

---

Flysystem GCS CORS enables **direct browser-to-Google-Cloud-Storage uploads** — configuring CORS and
signed-upload handling so files go straight from the user's browser to a GCS bucket (offloading large uploads
from the Drupal server). It depends on Flysystem GCS and Token, provides its own permissions, in the Flysystem
package.

Use it to upload directly to GCS. It is a media/file-storage integration. Security notes: **CORS and bucket
configuration are security-sensitive** — a too-permissive CORS/bucket policy can allow uploads from unintended
origins or expose the bucket, so scope CORS to your origin(s) and keep the bucket's access appropriate; the
**GCS credentials/signing key** must be stored as secrets; and signed upload URLs should be short-lived and
scoped. It gates upload capability via its permission. Configure the GCS bucket, CORS and credentials
carefully.

---

- Upload directly from browser to GCS.
- Configure CORS + signed uploads.
- Offload large uploads from Drupal.
- Depend on Flysystem GCS and Token.
- Provide its own permissions.
- Send files browser-to-bucket.
- SCOPE CORS to your origins.
- Keep the bucket access appropriate.
- Store GCS credentials/signing key as secrets.
- Use short-lived, scoped signed URLs.
- Gate upload via its permission.
- Configure bucket/CORS/credentials carefully.
- Handle direct GCS upload.
- Upload to GCS.
- Configure CORS.
- Secure the bucket.
- Handle the integration.
- Upload files.
- Secure credentials.
- Provide direct GCS uploads.
