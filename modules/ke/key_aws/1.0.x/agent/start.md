<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Key AWS - agent index

Key-module **providers/type for AWS credentials** (version **1.0.1**, core `>=8.9 <11`, depends on `key`).

- Providers: `aws_file` (INI file) and `aws_config` (config); key type `aws`; service `key_aws.repository` (`AWSKeyRepository`) exposes access/secret getters.
- No module routes; credential access is gated by core Key (`administer keys`). Secrets are stored/retrieved through core Key, not logged or exposed to non-admins.
- Bundled submodule `key_aws_s3` (multivalue S3 key type/input).
- Category: Security / Secrets & key management.
