# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Project Browser** module (`project_browser`) — this is the only Drupal
  dependency, and it is what Sheephole helper hooks its download button into.
- The **Sheephole desktop application** running on your own computer, plus
  **Java 17** to run it. You download the app from
  [github.com/TolstoyDotCom/sheephole](https://github.com/TolstoyDotCom/sheephole).
- **SSH access** to your hosting. If your host only gives you FTP, this module
  cannot help you — the desktop app installs modules over SSH.

There are no PHP library requirements on the Drupal side.

## Install with Composer

From the project root:

```bash
composer require drupal/sheephole_helper -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sheephole_helper -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sheephole_helper -y
```

Project Browser will be enabled automatically as a dependency if it is not already
on.

## Verify it worked

Start the Sheephole desktop app on your computer. In Drupal, go to
**Extend → Browse** (`/admin/modules/browse`). Each module in the listing should
now show an extra download button. Clicking it opens the desktop app, ready to
install that module over SSH.

Once your site is set up, restrict or remove the helper routes when you no longer
need one-click installs (see the [overview](../index.md)).
