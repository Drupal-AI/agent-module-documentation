<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Google Cloud Storage File System (gcsfs) provides a stream wrapper so Drupal files can be stored in and served from Google Cloud Storage.

---

Google Cloud Storage File System (gcsfs) lets Drupal store files in Google Cloud Storage (GCS)
instead of (or alongside) the local filesystem, via a stream wrapper. Managed files, images and their
derivatives can live in a GCS bucket, useful for scalable/offloaded storage and multi-instance
deployments where local disk isn't shared. It is configured at `gcsfs.config` (bucket and Google
credentials), depends on core File and Image, provides Drush commands, and has its own permissions.

Use it to offload file storage to GCS. The security-relevant point is credentials: it authenticates to
GCS with a Google service-account credential — store that as a secret (never in the webroot or version
control), and scope the service account to the specific bucket with least privilege. Bucket ACLs/public
access settings also determine whether stored files are public or private, so configure those to match
your file-privacy needs (private files must not be world-readable in the bucket).

---

- Store Drupal files in Google Cloud Storage.
- Serve files from a GCS bucket.
- Offload file storage to GCS.
- Use a GCS stream wrapper.
- Support multi-instance file storage.
- Configure at gcsfs.config.
- Store the GCS service-account credential as a secret.
- Scope the service account least-privilege.
- Depend on core File and Image.
- Provide Drush commands.
- Store image derivatives in GCS.
- Match bucket ACLs to file privacy.
- Keep private files non-public in the bucket.
- Provide its own permissions.
- Use scalable cloud storage.
- Configure the target bucket.
- Authenticate to GCS securely.
- Avoid credentials in the webroot.
- Share files across instances.
- Manage GCS-backed files.
