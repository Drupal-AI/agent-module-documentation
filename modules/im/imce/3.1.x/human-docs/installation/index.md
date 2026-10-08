# Installation

## Requirements

IMCE 3.1.x needs **Drupal core 9.3, 10, or 11** (`^9.3 || ^10 || ^11`). It has no
other contrib-module dependencies — everything it relies on ships with Drupal core.

Optional integration:

- **BUEditor** (`drupal/bueditor`) — if you use BUEditor, IMCE ships a BUEditor
  plugin so it can act as that editor's file/image browser. It is only needed if
  you run BUEditor; it is not required for CKEditor 5, which IMCE supports out of
  the box.

## Install with Composer

From the project root:

```bash
composer require drupal/imce -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/imce -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en imce -y
```

Once enabled, the file-manager settings appear under **Configuration → Media → IMCE
File Manager** (`/admin/config/media/imce`).

## Verify it worked

Log in as an administrator and go to `/admin/config/media/imce`. You should see the
**IMCE File Manager** page with an **IMCE Settings** tab, a **+ Add configuration
profile** button, and a **Configuration Profiles** list. If that page loads, the
module is installed correctly. Next, head to
[Configuration](../configuration/index.md) to create a profile and assign it to your
roles.
