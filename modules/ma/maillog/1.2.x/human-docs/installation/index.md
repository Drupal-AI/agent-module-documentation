# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Views** module (`views`) enabled — Maillog uses a bundled View to list
  captured messages. Drupal enables it automatically as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/maillog -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/maillog -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en maillog -y
```

Enabling Maillog has an important side effect: it sets **itself as the site's
default mail backend** (`system.mail` `interface.default = maillog`). That's what
lets it capture and optionally suppress outgoing mail. With the shipped defaults it
logs every mail *and still delivers it*, so nothing breaks until you deliberately
turn delivery off (see [Configuration](../configuration/index.md)).

No submodules ship with this project.

## Uninstalling

When you uninstall Maillog, it restores the default mail interface to core's
`php_mail` (as long as Maillog was still the active backend), so normal delivery
resumes automatically.

## Verify it worked

Trigger any email (for example request a password reset), then visit **Reports →
Maillog** (`/admin/reports/maillog`). The message should appear in the list, and
you can open it to read the full headers and body.
