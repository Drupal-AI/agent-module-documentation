# Installation

## Requirements

- **PHP 8.1 or later.**
- **Drupal core ^11.0** (`core_version_requirement: ^11.3`).
- The **External Authentication** module (`externalauth`, `^2.0`).
- The **SimpleSAMLphp 2.5 library**, available either via Composer
  (`simplesamlphp/simplesamlphp:dev-simplesamlphp-2.5`) or an on-disk installation
  referenced by configuration.
- A **standalone SimpleSAMLphp service provider** instance installed and configured
  (auth sources, identity-provider metadata, certificates) that this module can
  bootstrap.

## Install with Composer

From the project root:

```bash
composer require drupal/simplesamlphp_sp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Make sure the SimpleSAMLphp library is installed too; if it is
not managed by Composer, set the `SIMPLESAMLPHP_INSTALL_DIR` environment variable or
note the full path to the installation directory.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simplesamlphp_sp -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the module together with its External Authentication dependency, then clear
caches so the dynamic SAML login route is registered:

```bash
drush en externalauth simplesamlphp_sp -y
drush cr
```

## Point the module at the SimpleSAMLphp library

The module locates the SimpleSAMLphp install in one of two ways:

- If the **`SIMPLESAMLPHP_INSTALL_DIR`** environment variable is set, it takes
  precedence and must point to the SimpleSAMLphp root directory (the one containing
  `config/`, `modules/` and `www/`).
- Otherwise, the module uses the **`simplesamlphp_base_dir`** setting from your site's
  `settings.php`, for example:

  ```php
  $settings['simplesamlphp_base_dir'] = '/var/simplesamlphp';
  ```

The path must contain `lib/_autoload.php`; a runtime exception is thrown if that file
cannot be located.

## Next

Once enabled and pointed at the library, configure the service-provider name, login
path and attribute mapping — see [Configuration](../configuration/index.md).
