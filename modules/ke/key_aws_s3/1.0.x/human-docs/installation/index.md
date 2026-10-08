# Installation

## Requirements

- **Drupal 8.9 through 10** (`core_version_requirement: >=8.9 <11`).
- The **Key** module (`key`) — Key AWS S3 is an extension of it and enables it as a
  dependency.
- Your **Amazon S3 access key ID and secret access key** to store.

## Install with Composer

From the project root:

```bash
composer require drupal/key_aws_s3 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Key module and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/key_aws_s3 -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en key_aws_s3 -y
```

Or enable **Key AWS S3** on the **Extend** page (`/admin/modules`). The Key module
is enabled automatically.

## Verify it worked

Go to **Configuration → System → Keys** (`/admin/config/system/keys`) and click
**Add key**. Under **Key type** you should now see **AWS S3**. See
[Configuration](../configuration/index.md) to create the key.
