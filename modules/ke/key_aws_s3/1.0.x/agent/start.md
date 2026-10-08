<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Key AWS S3 - agent index

Key-module **multivalue key type/input for Amazon S3 credentials** (version **1.0.1**, core `>=8.9 <11`, depends on `key`).

- Key type `amazon_s3_key` + key input `aws_s3` with required `aws_access_key_id` / `aws_secret_access_key`.
- No module routes; storage/retrieval via core Key, gated by `administer keys`. No AWS/STS calls, so no TLS surface in the module itself.
- Category: Security / Secrets & key management.
