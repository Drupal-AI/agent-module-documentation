# Installation

## Requirements

- **Drupal 10 or 11.3+** (`core_version_requirement: ^10 || ^11.3`).
- Core's **User** module (`user`).
- The contributed **External Authentication** module (`externalauth`, `^1.1 ||
  ^2.0`).
- The **SimpleSAMLphp library** (`simplesamlphp/simplesamlphp`, `^1.19 || ^2.3.5`),
  which Composer installs alongside the module — or a standalone SimpleSAMLphp install
  referenced from your site's `settings.php` via `$settings['simplesamlphp_dir']`.
- **A working SimpleSAMLphp service provider (SP).** This is the essential
  prerequisite — the SP's metadata, identity-provider metadata and certificates must
  be configured before the Drupal side is useful.
- Your SP's session store must be **something other than** the default `phpsession`
  (use `sql` or `memcache`) — the module's login controller refuses to run if the
  store is `phpsession`.

## Install with Composer

From the project root:

```bash
composer require drupal/simplesamlphp_auth -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — this module's dependency chain is specific (Symfony, Guzzle,
the SimpleSAMLphp library), so let Composer resolve it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simplesamlphp_auth -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simplesamlphp_auth -y
```

## What enabling changes

Be aware that enabling this module changes two core account settings (and restores
them on uninstall): it sets **who can register accounts** to *administrators only*,
and it revokes the "change own password" permission from authenticated users — both
appropriate for a SAML-managed site. If you rely on open registration or local
password changes, review these afterwards.

## Order of operations

Configure the SimpleSAMLphp service provider first, then install and enable this
module, configure it (see [Configuration](../configuration/index.md)), and only then
turn on the **activate** switch. While `activate` is off the module does nothing and
Drupal shows an informational notice on the status report.
