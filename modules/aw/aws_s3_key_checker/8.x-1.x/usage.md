<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AWS S3 Key Checker offers an admin form to verify whether a series of object keys exist inside an AWS S3 bucket by issuing HEAD requests.

---

You configure one or more bucket names at `/admin/config/aws/s3/key-checker` and supply AWS credentials. Credentials are NOT stored in Drupal config: the access key and secret key must be placed in `settings.php` as `$settings['aws_s3_key_checker.access_key']` and `$settings['aws_s3_key_checker.secret_key']` (read via `Settings::get()`), or you can tick "Use IAM credentials" to rely on the instance IAM role. The check form (`/admin/config/aws/s3/key-checker/check`) takes a list of keys with optional prefix/suffix and runs a HEAD (`headObject`) against the chosen bucket for each, reporting which keys are present or missing. It uses the AWS SDK for PHP (`Aws\S3\S3Client`, `Aws\Credentials\Credentials`).

Both routes require the core `administer site configuration` permission. Credentials living in settings.php (or IAM) is the correct posture — no secrets are committed or stored in config.

---
- Confirm a batch of object keys exist in an S3 bucket
- Detect missing keys before a migration or deploy
- Register multiple buckets that may be checked
- Use IAM instance-role credentials instead of static keys
- Store AWS access/secret keys in settings.php (not config)
- Prefix each checked key with a common path
- Suffix each checked key with an extension
- Run a HEAD-only existence check (no downloads)
- Audit that uploaded assets landed in the bucket
- Verify backups were written to S3
- Check a list of expected report files exist
- Point the checker at a different bucket per run
- Grant a role `administer site configuration` to use the tool
- Validate credentials are set before submitting
- Spot-check keys reported by another system