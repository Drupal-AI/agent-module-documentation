# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Options** module (`options`) — enabled automatically as a dependency.
- An existing **consent mechanism** that defines your consent groups — an
  external banner such as OneTrust, or a Drupal module like EU Cookie Compliance.
  Iframe Consent integrates with these; it does not provide a banner of its own.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/iframe_consent -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/iframe_consent -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en iframe_consent -y
```

## Verify it worked

After configuring the module (see [Configuration](../configuration/index.md)),
visit a page with a gated iframe as a fresh visitor who has **not** yet consented
— you should see the placeholder instead of the embed. Grant the matching consent
group in your cookie banner, and the iframe should then load.
