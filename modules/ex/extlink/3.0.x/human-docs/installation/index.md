# Installation

## Requirements

External Links needs **Drupal 11.3+ or 12** (`drupal/core: ^11.3 || ^12`). It has
**no other module dependencies** — it works on its own out of the box.

Optional but recommended:

- **UI Icons** (`drupal/ui_icons`) — when installed, you can pick the
  external/mailto/tel icons from UI Icons icon packs instead of using the bundled
  images or Font Awesome classes. Install it only if you want that choice.

## Install with Composer

From the project root:

```bash
composer require drupal/extlink -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/extlink -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en extlink -y
```

Once enabled, the settings form appears under **Configuration → User interface →
External Links** (`/admin/config/user-interface/extlink`).

## Verify it worked

Log in as an administrator and go to `/admin/config/user-interface/extlink`. You
should see the **External Links** page with its **Settings** form:

![The External Links settings page](../images/settings.png)

If the page loads and shows the settings form (starting with *Disable on admin
routes* and *Place an icon next to external links*), the module is installed
correctly. Next, review the [configuration](../configuration/index.md) to choose
how external links are decorated.
