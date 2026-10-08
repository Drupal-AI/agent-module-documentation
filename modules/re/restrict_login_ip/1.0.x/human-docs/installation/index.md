# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **User** module (`user`) — always present on a Drupal site.
- If your site is behind a proxy or CDN, correct `reverse_proxy` and
  `trusted_host_patterns` settings in `settings.php` are effectively a prerequisite,
  so the module reads the real client IP rather than a spoofable header.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/restrict_login_ip -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/restrict_login_ip -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en restrict_login_ip -y
```

Enabling the module **does not restrict anything yet** — the login page stays open to
all IPs until you configure at least one allowed range. This is deliberate, and it
gives you a safe moment to add your own network before the restriction takes effect.

## Verify it worked

1. Enable the module, then go to [Configuration](../configuration/index.md) and add a
   range that **includes your own IP** (test from your current network first).
2. From an allowed network, confirm `/user/login` loads normally.
3. From a non-allowed IP (or by temporarily narrowing the range on a test site),
   confirm the login page returns a `403`.

If you ever lock yourself out, you can clear the restriction from the command line —
see the recovery note in [Configuration](../configuration/index.md).
