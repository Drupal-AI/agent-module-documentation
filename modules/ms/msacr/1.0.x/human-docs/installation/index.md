# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no other module dependencies and no third-party PHP libraries to
install.

> **Note:** this module is itself **not covered** by Drupal's security advisory
> policy. Consider using it as an audit tool rather than a permanent production
> dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/msacr -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/msacr -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en msacr -y
```

There is nothing to configure — the report is available immediately.

## Grant access to the report

MSACR provides a permission that controls who can view the coverage report. Under
**People → Permissions**, grant it to the roles who should audit module security
coverage (typically administrators).

## Verify it worked

Confirm the module is enabled:

```bash
drush pm:list --status=enabled | grep msacr
```

Then go to **Administration → Reports** and open the security-advisory coverage
report — you should see a table listing your installed contrib modules and
whether each is covered.
