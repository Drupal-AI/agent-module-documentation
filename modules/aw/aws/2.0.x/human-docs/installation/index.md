# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- The **AWS SDK for PHP** library, `aws/aws-sdk-php` (version `^3.54`), which
  Composer installs as a declared requirement.
- No Drupal module dependencies.

One optional integration is suggested:

- **Encrypt** (`drupal/encrypt`) — lets you encrypt a stored secret access key at
  rest instead of saving it as plaintext in configuration. Recommended if you must
  store static keys.

## Install with Composer

From the project root:

```bash
composer require drupal/aws -W
```

This pulls in the `aws/aws-sdk-php` library automatically. The `-W`
(`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed. To also get the encryption option:

```bash
composer require drupal/encrypt -W
drush en encrypt -y
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/aws -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en aws -y
```

The module has no effect until you create at least one AWS profile. Continue to
[Configuration](../configuration/index.md).
