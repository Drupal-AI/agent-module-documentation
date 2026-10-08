<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, config object & AWS credential resolution

## Route / form

`encrypt_kms.routing.yml` defines `encrypt_kms.admin` at `admin/config/system/encrypt_kms`
(`_form: EncryptKmsConfigForm`, `_title: 'Encrypt KMS'`, `_permission: 'administer encrypt'`). Menu
link `encrypt_kms.admin` (`encrypt_kms.links.menu.yml`) sits under
`system.admin_config_system`. `info.yml` sets `configure: encrypt_kms.admin`.

`src/Form/EncryptKmsConfigForm.php` (`ConfigFormBase`, form id `encrypt_kms.config_form`) edits
config object `encrypt_kms.settings` with three text fields: `aws_key` (AWS Key), `aws_secret` (AWS
Secret), `aws_region` (required; "The region which contains the KMS key(s)").

## Config object & schema

`config/install/encrypt_kms.settings.yml`: `aws_key: ''`, `aws_secret: ''`, `aws_region: 'us-east-1'`.
Schema `encrypt_kms.settings` (`config/schema/encrypt_kms.schema.yml`): a `config_object` mapping
`aws_key`/`aws_secret`/`aws_region` (all `string`).

## KMS client service

`encrypt_kms.services.yml` declares:

- parameter `encrypt_kms.kms_client.options` = `{ version: latest }`.
- `encrypt_kms.kms_client` — class `Aws\Kms\KmsClient`, built by factory
  `encrypt_kms.kms_client_factory:createInstance` with `['%encrypt_kms.kms_client.options%', '@config.factory']`.
- `encrypt_kms.kms_client_factory` — `Drupal\encrypt_kms\KmsClientFactory` (private).
- `logger.channel.encrypt_kms`.

`src/KmsClientFactory::createInstance(array $options, ConfigFactory $configFactory)` reads
`encrypt_kms.settings` and:

- sets `$options['region'] = aws_region`, `$options['version'] = 'latest'`;
- **only if both `aws_key` and `aws_secret` are non-empty** sets
  `$options['credentials'] = ['key' => aws_key, 'secret' => aws_secret]`;
- returns `new KmsClient($options)`.

## Credential resolution (grounded in source)

If `aws_key`/`aws_secret` are left empty in config, the factory passes **no** `credentials` key, so
`Aws\Kms\KmsClient` uses the AWS SDK's **default credential provider chain**. `hook_help()`
(`encrypt_kms.module`, route `encrypt_kms.admin`) documents that fallback order:

1. IAM instance profile,
2. exported credentials in environment variables,
3. a profile in `$HOME/.aws/credentials`.

The module ships **no** custom env-variable reader or Key-entity credential selector for the AWS
credentials themselves — the only sources are (a) the `encrypt_kms.settings` config values (set via
the form or a `settings.php` config override such as
`$config['encrypt_kms.settings']['aws_key']`), or (b) the SDK default chain when those are empty.
(Separately, the Key module can back the config with its configuration-override capability, and the
`aws_kms` **key provider** stores wrapped *secrets* — that is unrelated to the AWS API credentials.)

## Requirements check

`encrypt_kms.install` `hook_requirements('runtime')`:

- `aws-sdk` — OK when `\Aws\Kms\KmsClient` exists, else ERROR "missing".
- `aws-creds` — builds an `\Aws\Sts\StsClient` (region from config, credentials from config if set)
  and calls `getCallerIdentity()`; OK showing the returned `UserId`, else ERROR. Exceptions are
  logged to the `encrypt_kms` channel.
