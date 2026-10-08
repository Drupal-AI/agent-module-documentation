<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AWS S3 Key Checker (aws_s3_key_checker) — agent index
**Admin form that HEAD-checks whether a list of keys exists in an AWS S3 bucket.**

- **Version:** 8.x-1.x  •  **Core:** >=8  •  **Lib:** aws/aws-sdk-php
- **Routes:** `aws_s3_key_checker.settings` `/admin/config/aws/s3/key-checker`; `aws_s3_key_checker.check` `/admin/config/aws/s3/key-checker/check`
- **Permission:** both routes require `administer site configuration`
- **Credentials:** `Settings::get('aws_s3_key_checker.access_key'|'.secret_key')` from settings.php, or IAM role (`use_iam_credentials`). Buckets list stored in config.
- **Security:** admin-only; credentials read from settings.php/IAM, never stored in config or hardcoded; check is a read-only S3 HEAD (`headObject`). No anonymous endpoints.

See [configure/settings.md](configure/settings.md).