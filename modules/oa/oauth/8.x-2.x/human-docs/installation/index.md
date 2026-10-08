# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **System** module (`system`) — always present.
- The **OAuth PECL extension** installed and enabled in PHP. This module leverages
  that extension to implement the OAuth 1.0a protocol, so it must be available in
  your PHP environment. Confirm it is loaded (for example, `php -m | grep -i oauth`
  should list `OAuth`, or check `phpinfo()`).

There are no additional Composer library requirements beyond the module itself.

## Install with Composer

From the project root:

```bash
composer require drupal/oauth -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/oauth -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix. If the OAuth PECL extension is
> not present in the container, install it there (for example via a DDEV
> `webimage_extra_packages` / PECL setup) before enabling the module.

## Enable the module

```bash
drush en oauth -y
```

If enabling fails with a missing‑extension error, the OAuth PECL extension is not
loaded — install it in your PHP environment (see Requirements) and try again.

## Verify it worked

Confirm the module is enabled and that its admin form (route `oauth.admin_form`)
loads. Then review the **access own consumers** and **oauth register any consumers**
permissions on **People → Permissions** and assign them deliberately — see
[Configuration](../configuration/index.md).
