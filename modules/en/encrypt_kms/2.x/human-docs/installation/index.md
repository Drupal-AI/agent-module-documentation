# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The **Encrypt** module (`drupal/encrypt`) — provides the pluggable encryption
  framework this module adds a method to.
- The **Key** module (`drupal/key`) — used to register the KMS key and (for
  PII/PHI) the KMS data key.
- The **AWS SDK for PHP** (`aws/aws-sdk-php`), pulled in through Composer.
- An **AWS account** with a KMS key provisioned and an IAM user allowed to
  encrypt and decrypt with that key.

## Install with Composer

From the project root:

```bash
composer require drupal/encrypt_kms -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the Encrypt,
Key, and AWS SDK dependencies. Installing with Composer (rather than downloading
a tarball) is important here so that the AWS SDK is available.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/encrypt_kms -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en encrypt_kms -y
```

This also enables Encrypt and Key if they are not already on.

## Verify it worked

Confirm `encrypt_kms`, `encrypt`, and `key` are enabled on the **Extend** page
(`/admin/modules`). Then check that **Amazon KMS** appears as an available
encryption method when you create an Encryption Profile, and that **KMS Key**
appears as a key type when you add a Key. From there, follow the setup flow in
the [main guide](../index.md#how-to-use-it).
