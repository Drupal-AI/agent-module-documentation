# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11**
  (`core_version_requirement: ^8.8.0 || ^9 || ^10 || ^11`).
- An **Amazon S3** bucket holding your images, plus **AWS credentials** with
  access to it. Store those credentials securely (env-backed) — do not put them
  in exported configuration or commit them to version control.

There are no other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/amazon_image_id_scan -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/amazon_image_id_scan -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en amazon_image_id_scan -y
```

After enabling, supply your AWS credentials through environment variables and
grant the `amazon_image_id_scan load_s3` permission to the roles that need to
load images from S3.
