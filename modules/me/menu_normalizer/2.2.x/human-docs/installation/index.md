# Installation

## Requirements

- **Drupal 11.3+ or Drupal 12** (`core_version_requirement: ^11.3 || ^12`). The
  2.2.x branch no longer supports Drupal 9, 10, or Drupal 11 releases older than
  11.3 — for those, use the 2.1.x branch instead.
- Core's **Serialization** system available (and, in practice, whatever
  web-services or custom code is going to call the serializer on a menu — REST,
  a JSON controller, a decoupled integration, and so on). The normalizers do
  nothing unless something invokes the core `serializer` service.
- No third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_normalizer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/menu_normalizer -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_normalizer -y
```

That's the whole setup — the module registers its two normalizer services and
there is nothing to configure. It has no visible effect on its own; it simply
makes menu objects serializable for any code that asks the core serializer to
handle them.
