# Installation

## Requirements

- **Drupal 10.6 or 11** (`core_version_requirement: ^10.6 || ^11`). (The module's
  info file also declares an old `php: 7.1` requirement, which is stale — run a
  current, supported PHP version.)
- The underlying `esolitos/pwnedpasswords` PHP library is pulled in automatically
  when you install with Composer.
- Your server must be able to make **outbound HTTPS requests** to
  `api.pwnedpasswords.com` (egress). Note the request bypasses Drupal's proxy
  settings, so if your site reaches the internet through a proxy, plan for that.

## Install with Composer

From the project root:

```bash
composer require drupal/pwned_passwords -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies and brings in the `esolitos/pwnedpasswords` library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pwned_passwords -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pwned_passwords -y
```

## Verify it worked

1. Confirm the module is enabled: `drush pm:list --status=enabled | grep pwned_passwords`.
2. **Important:** enabling alone enforces nothing — the shipped defaults only warn.
   Go straight to [Configuration](../configuration/index.md) and set a threshold
   and choose which forms to check.
3. To sanity-check the connection, configure it to check a form, then try setting a
   well-known breached password such as `password`; the module should recognise it
   as compromised.
