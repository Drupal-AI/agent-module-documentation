# Installation

## Requirements

- **Drupal 10.3+ or 11** for this 2.1 release (use easydb 2.0 for Drupal 9).
- Core **Media** module (`media`) — enable it first.
- The **Entity Browser** contrib module (`entity_browser:entity_browser`).
- Core modules pulled in as dependencies: `system`, `field`, `file`, `image`,
  `node`, `path`, and `views`.
- **Recommended:** **Chaos Tools (ctools)** if you want to edit the entity
  browsers through a graphical UI, and core **Content Translation** if you import
  multilingual metadata into a multilingual site.
- Network access from your Drupal server **out to your fylr/easydb instance** —
  see the egress note in [Configuration](../configuration/index.md).

## Install with Composer

Enable Media first, then install fylr File Picker and Entity Browser. From the
project root:

```bash
composer require drupal/easydb -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Entity Browser
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/easydb -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Add the required `services.yml` lines

fylr File Picker needs a few lines added to `sites/default/services.yml` for the
cross-origin (CORS) handling that lets the fylr server post files back to Drupal.
The module's `README` file gives the exact block to paste — add it before you
configure the module. After editing `services.yml`, rebuild the cache:

```bash
drush cr
```

## Enable the module

```bash
drush en media entity_browser easydb -y
```

Then grant the **Administer easydb** (`administer easydb`) permission to
administrators and **Access easydb** (`access easydb`) to the editor roles that
will use the picker.

## Verify it worked

Go to **Configuration → Media → fylr File Picker** (`/admin/config/media/easydb`).
If the settings form loads, the module is installed. You are not done yet — head
to [Configuration](../configuration/index.md) to enter your fylr server URL and
credentials and to add the picker to a field.
