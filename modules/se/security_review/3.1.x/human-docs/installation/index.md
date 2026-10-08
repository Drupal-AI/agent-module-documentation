# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1.0`).
- The **symfony/filesystem** library — pulled in automatically by Composer.

There are no contrib module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/security_review -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/security_review -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en security_review -y
```

There are no submodules. On enable, the module posts a reminder to configure its
permissions before use, and it automatically skips one check (*account creation*) that
needs a human decision.

## Grant permissions (do this before using it)

Security Review exposes sensitive details about your site's security, so its two
permissions default to no one. At **People → Permissions**, grant to **trusted roles
only**:

- **Access security review list** — reach the run/review page, the settings form, the
  per-check toggle, and the help pages.
- **Run security checks** — actually run the checklist.

## Next steps

With permissions granted, run the checklist and review the findings — see
[Configuration](../configuration/index.md), which also covers marking untrusted roles,
skipping checks, and the `drush secrev` command for CI pipelines.
