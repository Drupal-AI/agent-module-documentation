# Installation

## Requirements

- **Drupal 8.9 through 10** (`core_version_requirement: >=8.9 <11`).
- The **Key** module (`key`) — Key AWS is an extension of it and enables it as a
  dependency.
- If you'll use the **AWS Credentials (file)** provider, an AWS credentials INI
  file (the format documented for the AWS CLI), ideally stored **outside the web
  root**.

## Install with Composer

From the project root:

```bash
composer require drupal/key_aws -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Key module and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/key_aws -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en key_aws -y
```

Or enable **Key AWS** on the **Extend** page (`/admin/modules`). The Key module is
enabled automatically.

## Submodule

- **Key AWS S3** (`key_aws_s3`) — adds an S3‑specific multivalue key type that
  captures the access key and secret in one key. Enable it if you need S3
  credentials specifically:

  ```bash
  drush en key_aws_s3 -y
  ```

## Verify it worked

Go to **Configuration → System → Keys** (`/admin/config/system/keys`) and click
**Add key**. Under **Key type** you should now see **AWS**, and under **Key
provider** you should see **AWS Credentials** (and, if the submodule is enabled,
the AWS S3 options). See [Configuration](../configuration/index.md) to create the
key.
