# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 ||
  ^11`).
- The **Domain Access** project — specifically its **Domain** (`domain`) and
  **Domain Configuration** (`domain_config`) modules.
- Core's **Language** (`language`) module, and a working multilingual setup (more
  than one language configured).

Domain Language has no third-party PHP library requirements.

> **Heads-up on the 2.0.0-alpha2 release.** As shipped, this version has a
> services definition bug that makes every request fatal on recent Drupal 11
> (verified on 11.4.4) the moment the module is enabled. Test on a throwaway
> environment first, and be ready to apply the upstream fix to
> `domain_language.services.yml` before using it on a live site. See the
> [`agent/`](../agent/start.md) docs for the exact error and how to recover if a
> site gets stuck.

## Install with Composer

From the project root:

```bash
composer require drupal/domain_language -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed. Domain Access (`drupal/domain`) provides the `domain` and
`domain_config` modules Domain Language depends on; install it too if it is not
already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/domain_language -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en domain_language -y
```

This requires `domain`, `domain_config`, and `language` to be enabled; Drush
enables the missing dependencies for you.

## After enabling

Go to **Configuration → Domains** and confirm each domain now has a **Languages**
operation in its row. If it does, continue to
[Configuration](../configuration/index.md) to set a domain's default and allowed
languages.
