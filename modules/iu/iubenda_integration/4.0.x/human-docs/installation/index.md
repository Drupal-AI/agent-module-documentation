# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Block** module (`block`), which Drupal enables automatically as a
  dependency.
- The **`iubenda/iubenda-cookie-class`** PHP library (version `4.1.15`), used to
  parse the page and lock tagged scripts until consent. Composer installs it
  automatically.
- An **Iubenda account** with the codes/IDs you want to use (privacy-policy code,
  cookie-solution site ID, consent-solution API key), generated in the Iubenda
  dashboard.

## Install with Composer

From the project root:

```bash
composer require drupal/iubenda_integration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the bundled
`iubenda/iubenda-cookie-class` library and update any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/iubenda_integration -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en iubenda_integration -y
```

## Grant the permission

A single permission, **Administer iubenda_integration**, gates all three settings
forms. Grant it to your administrator role at **People → Permissions**, or:

```bash
drush role:perm:add administrator 'administer iubenda_integration'
```

## Verify it worked

Go to **Configuration → Services → Iubenda Integration**
(`/admin/config/services/iubenda-integration`). If the settings form loads with its
General / Privacy, Cookie solution, and Consent solution tabs, the module is
installed. Enter your privacy-policy code and, once saved, Iubenda's JavaScript will
begin loading on non-admin pages. See [Configuration](../configuration/index.md) for
each setting.
