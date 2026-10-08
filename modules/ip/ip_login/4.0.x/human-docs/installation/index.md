# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- Core's **User** module (`user`), always enabled.
- The **[Field IP address](https://www.drupal.org/project/field_ipaddress)**
  module (`field_ipaddress`) — required. Per‑user IP ranges are stored through a
  field it provides.
- Currently IPv4 only (single IPs, ranges, and wildcards). IPv6 and CIDR/subnet
  matching are noted as future work.

## Install with Composer

Requiring the module with the `-W` flag pulls in Field IP address as a dependency:

```bash
composer require drupal/ip_login -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ip_login -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ip_login -y
```

Drupal enables Field IP address automatically as a dependency.

## Before you configure — check your proxy settings

Because IP Login authenticates by client IP, its safety depends on Drupal
computing the *real* visitor IP. **If your site sits behind a reverse proxy or
CDN, configure `reverse_proxy` and `trusted_hosts` correctly in `settings.php`
first.** A proxy configuration that trusts forwarded headers from untrusted
sources would let an attacker spoof `X-Forwarded-For` and impersonate a mapped
user. Do this before mapping any IPs.

## Verify it worked

Map a test IP (your own) to a **non‑privileged** test account (see
[Configuration](../configuration/index.md)), then visit the site from that IP in a
fresh browser session — you should be logged in automatically as that account.
Remove the test mapping when you're done, and never test with an admin account on
a shared network.
