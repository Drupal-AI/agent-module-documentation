# Installation

> **Before you install:** Monsido Tools is **deprecated and unsupported** — its
> maintainers recommend the **Acquia Optimize** module instead. Only install
> Monsido Tools if you are maintaining an existing site that already relies on it.

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- A **Monsido account** (the platform the module connects to).

There are no other module dependencies and no third-party PHP libraries to
install.

## Install with Composer

From the project root:

```bash
composer require drupal/monsido_tools -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/monsido_tools -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en monsido_tools -y
```

Enabling the module does not start tracking on its own — you still need to
connect your Monsido account details on the settings form. See
[Configuration](../configuration/index.md).

## Verify it worked

Confirm the module is enabled:

```bash
drush pm:list --status=enabled | grep monsido_tools
```

Once configured, load a front-end page as an anonymous visitor and check (via
your browser's developer tools) that the Monsido agent script is present on the
pages you expect it on.
