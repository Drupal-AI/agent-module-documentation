<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure AWS S3 Key Checker

## Credentials (settings.php — required unless using IAM)
```php
$settings['aws_s3_key_checker.access_key'] = 'AKIA...';
$settings['aws_s3_key_checker.secret_key'] = '...';
```
Or enable **Use IAM credentials** on the settings form to use the instance role.

## Settings form — `/admin/config/aws/s3/key-checker`
- `use_iam_credentials` (bool)
- `buckets` — newline-separated bucket names (stored as an array in `aws_s3_key_checker.settings`).
The submit handler errors out if neither IAM nor settings.php credentials are present.

## Check form — `/admin/config/aws/s3/key-checker/check`
Choose a configured bucket, paste keys (optional prefix/suffix), and run; each key is
verified with an S3 `headObject` call and reported present/missing.