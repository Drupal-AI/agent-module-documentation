# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **User** module (`user`), which is always present.
- **Strongly recommended:** configure Drupal's **Trusted Host Settings** in
  `settings.php`. This module identifies the current domain from the request's
  `Host` / `X-Forwarded-Host` header, and trusted-host settings are what keep that
  value from being spoofed. See the Configuration page for why this matters.

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/disable_login_by_domain -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/disable_login_by_domain -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en disable_login_by_domain -y
```

Then manage the blocked domains at
`/admin/config/people/disable-login-by-domain` — see
[Configuration](../configuration/index.md).

## Verify it worked

After listing the domains to block, open the site on one of those hostnames and try
to reach the login page (`/user/login`). Login should be unavailable. Open the site
on a hostname you did **not** block and confirm you can still log in there.
