<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Key AWS S3 adds a multivalue Key type and input for storing Amazon S3 access credentials.

---

The module defines an `amazon_s3_key` key type (extending core Key's AuthenticationMultivalueKeyType) with two required fields - `aws_access_key_id` and `aws_secret_access_key` - and an `aws_s3` key input plugin that renders those fields as autocomplete-off text fields on the Key edit form. Credentials are stored and read exclusively through the Key module's storage; the module adds no routes and makes no AWS calls of its own. It is the credential backing for S3 filesystem/DAM integrations.

---

- Store Amazon S3 access key and secret as a Key entity.
- Provide an `amazon_s3_key` multivalue key type.
- Provide an `aws_s3` key input with two fields.
- Require both access key and secret at validation.
- Back S3 filesystem or storage modules with credentials.
- Gate credential access behind `administer keys`.
- Keep S3 secrets out of code and settings.php.
- Render credential fields with autocomplete disabled.
- Retrieve S3 credentials through the Key repository.
- Centralize S3 secret management.
- Reuse S3 credentials across multiple integrations.
- Support Drupal 8.9 through 10.
- Validate that required credential fields are non-empty.
- Manage S3 credentials via the Key admin collection.
- Rotate S3 credentials centrally.
- Avoid storing S3 secrets in plain configuration files.
