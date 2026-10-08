# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **SendEthic account** and an **API key**.
- **Recommended:** the **Key** module, for storing the SendEthic credentials
  securely (env‑backed) rather than in plain configuration.
- Using the webform handler assumes the **Webform** module is present on your site.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/sendethic -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sendethic -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sendethic -y
```

If you plan to store the credentials with the Key module, enable that too:

```bash
drush en key -y
```

## After enabling

1. Set your SendEthic credentials — see [Configuration](../configuration/index.md).
2. Add the **SendEthic** handler to the webforms you want to feed.

## Verify it worked

Open the SendEthic settings form, enter your credentials, and confirm the module
reports a successful connection. Then add the handler to a test webform and submit
it to confirm the data reaches SendEthic.
