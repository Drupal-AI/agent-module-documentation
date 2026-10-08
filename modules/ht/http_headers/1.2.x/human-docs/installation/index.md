# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).

There are no other Drupal module or third-party library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/http_headers -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/http_headers -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en http_headers -y
```

## Grant the permission

Configuring response headers is a privileged action gated by the module's own
permission. On **People → Permissions** (`/admin/people/permissions`), grant it
**only to trusted administrator roles**.

## Verify it worked

Open the module's **Configure** link from the **Extend** page (`/admin/modules`) to
confirm the settings form loads. After you configure a header, use the module's
"current request headers" report — or your browser's developer tools (Network tab →
Response Headers) — to confirm the header is actually being sent.
