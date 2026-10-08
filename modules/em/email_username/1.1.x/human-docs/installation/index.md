# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **User** module (always present).
- The **`egulias/email-validator`** library (`^4.0`), which Composer installs
  automatically with the command below — this is what powers the stricter e-mail
  validation.
- **Optional but recommended:** PHP's **`intl`** extension. When it is loaded, the
  module additionally runs DNS (MX) and spoof/confusable‑character checks on e-mail
  addresses. Without `intl`, those two extra checks are silently skipped and only the
  RFC check runs.

## Install with Composer

From the project root:

```bash
composer require drupal/email_username -W
```

This installs the module together with the `egulias/email-validator` library. The
`-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/email_username -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en email_username -y
```

Or enable **E-Mail Username** from *Extend* (`/admin/modules`).

There are no submodules and no permissions. **Note that enabling the module runs a
one‑time back‑fill** that sets every existing user's username to their e-mail
address, so users can immediately sign in with their e-mail. Because of that change,
enable it on a staging environment first if you have an existing user base.

The only configuration is a pair of optional validation toggles in `settings.php` —
see [Configuration](../configuration/index.md).
