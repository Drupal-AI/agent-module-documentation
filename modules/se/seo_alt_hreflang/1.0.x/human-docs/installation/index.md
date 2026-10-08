# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Drupal core's **Language** module (`language`) enabled, with more than one
  language configured and some content translated. The module has no purpose on a
  single-language site.

There are no third-party Composer packages or PHP libraries required — nothing
outside Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/seo_alt_hreflang -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/seo_alt_hreflang -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en seo_alt_hreflang -y
```

Drupal enables core's Language module as a dependency if it is not already on.

## Verify it worked

Go to **Configuration → Regional and language → Languages → Alternative Hreflang
settings** (`/admin/config/regional/language/seo-alt-hreflang`) and confirm the
form lists each of your installed languages with a field for an alternative code.
Once you have entered and saved some values (see
[Configuration](../configuration/index.md)), view the source of a translated page
and check the alternate `<link rel="alternate" hreflang="…">` tags in the head.
