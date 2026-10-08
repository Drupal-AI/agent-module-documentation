<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Google Cloud Storage File System (gcsfs) — agent index

Stream wrapper to **store/serve Drupal files in Google Cloud Storage**. Config at `gcsfs.config`;
depends on core `file`, `image`; provides **Drush commands** + permissions. Version **1.0.0**. Core
`^9||^10||^11`.

**Security:** store the GCS service-account credential as a secret (not in webroot/VCS), scope
least-privilege to the bucket; set bucket ACLs to match file privacy (private files must not be
world-readable).
