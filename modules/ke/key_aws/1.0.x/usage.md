<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Key AWS adds Key-module providers and a key type for storing AWS authentication credentials.

---

The module defines an `aws` key type plus two key providers: `aws_file` (reads an AWS credentials INI file, ideally outside the web root, extending core Key's FileKeyProvider) and `aws_config` (stores the credentials in Drupal configuration, extending ConfigKeyProvider). An `AWSKeyRepository` service exposes helper methods (`getClientCredentials`, `getAccessKey`, `getSecretKey`) so AWS SDK code can retrieve the access key id and secret through the standard Key repository. Credential access is governed entirely by the Key module (`administer keys`); the module adds no routes of its own. A bundled `key_aws_s3` submodule adds an S3-specific multivalue key type/input.

---

- Store AWS access key id and secret as a Key entity.
- Read AWS credentials from an INI file outside the web root.
- Store AWS credentials in Drupal configuration.
- Provide an `aws` key type for other AWS modules.
- Retrieve client credentials for the AWS SDK.
- Fetch the AWS access key via a service helper.
- Fetch the AWS secret key via a service helper.
- Centralize AWS secret management with the Key module.
- Gate credential access behind `administer keys`.
- Keep AWS secrets out of code and settings.php.
- Validate that credentials files contain required keys.
- Integrate with S3, STS, or other AWS services.
- Reuse one credential store across AWS integrations.
- Support Drupal 8.9 through 10.
- Add an S3 multivalue key type via the submodule.
- Rotate AWS credentials centrally via Key.
