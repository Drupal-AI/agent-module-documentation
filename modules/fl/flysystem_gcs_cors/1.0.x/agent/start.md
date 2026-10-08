<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Flysystem GCS CORS — agent index

Enables **direct browser uploads to Google Cloud Storage via CORS** (files go browser→GCS bucket — offload
large uploads). Depends on `flysystem_gcs`, `token`. Provides permissions. Version **1.0.0-beta1**. Core
`^10.2||^11`.

Media/file-storage — **CORS + bucket config are security-sensitive** (too-permissive = uploads from unintended
origins / bucket exposure): scope CORS to your origins, store GCS **credentials/signing key** as secrets, use
short-lived scoped signed URLs. Permission gates upload.
