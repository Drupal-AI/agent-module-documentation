# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Media** (`media`) and the **Entity Browser** module (`entity_browser`)
  — required dependencies.
- The **Social Auth Nextcloud** module
  ([`social_auth_nextcloud`](https://www.drupal.org/project/social_auth_nextcloud))
  — used to authenticate each user to Nextcloud over OAuth2. It is central to how
  the module connects, so install and configure it too.
- On the **Nextcloud** side: the **Webapppassword** app installed and enabled, so
  the browser‑based file picker can talk to Nextcloud's API.

There are no third‑party PHP library requirements. Communication with Nextcloud
happens client‑side (in the browser) via Vue.js.

## Install with Composer

From the project root:

```bash
composer require drupal/nextcloud_dam -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Entity Browser and
any shared dependencies. Install Social Auth Nextcloud as well:

```bash
composer require drupal/social_auth_nextcloud -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/nextcloud_dam -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nextcloud_dam social_auth_nextcloud -y
```

Drupal will enable Media and Entity Browser as dependencies. Enabling the module
creates a `nextcloud` media type and a `nextcloud filepicker` entity browser.

## Verify it worked

Go to **Structure → Media types** (`/admin/structure/media`) and confirm a
**nextcloud** media type exists, and to **Configuration → Content authoring →
Entity browsers** and confirm the **nextcloud filepicker** browser is present.
Then continue with [Configuration](../configuration/index.md) to connect Nextcloud
and wire the picker onto a field.
