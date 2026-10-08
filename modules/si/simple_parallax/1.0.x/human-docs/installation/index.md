# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- The **simpleParallax.js** JavaScript library (`simple-parallax-js`, version 6 or
  later) — the module's parallax effect is a wrapper around it, so it must be
  present.

There are no other module dependencies.

> **Note:** the current release is a beta (1.0.0-beta1), so test it before relying
> on it in production. This module is not covered by Drupal's security advisory
> policy.

## Install with Composer

The recommended way is to install both the library and the module with Composer.
First make sure your project is set up to install third-party libraries as
[npm-asset packages](https://www.drupal.org/docs/develop/using-composer/manage-dependencies#third-party-libraries)
(this generally means having the `asset-packagist` repository configured in your
`composer.json`).

Then require the library and the module:

```bash
composer require npm-asset/simple-parallax-js:^6.0
composer require drupal/simple_parallax -W
```

The Composer package name (`drupal/simple_parallax`) matches the module's machine
name (`simple_parallax`).

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_parallax -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_parallax -y
```

## Verify it worked

Go to the **Manage display** screen of a content type that has an image or media
field. If **Simple Parallax** appears as an available **Format** for that field,
the module is installed correctly — select it, save, and view a page to see images
animate as you scroll. If the format is available but images don't animate, confirm
the `simple-parallax-js` library was installed correctly.
