# Installation

## Requirements

Override Node Options needs **Drupal 9, 10, or 11** and core's **Node** module
(`node`), which is enabled on any standard Drupal site. It has no contrib
dependencies and pulls in no additional libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/override_node_options -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/override_node_options -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the
> prefix.

## Enable the module

```bash
drush en override_node_options -y
```

Once enabled, the module's settings page appears under **Configuration →
Content authoring → Override Node Options**
(`/admin/config/content/override-node-options`), and a new block of
permissions appears on the **Permissions** page.

## Verify it worked

Log in as an administrator and go to
`/admin/config/content/override-node-options`. You should see the **Override
Node Options settings** page with its two checkboxes and a **Save
configuration** button:

![The Override Node Options settings page](../images/settings.png)

If the page loads, the module is installed correctly. Next, head to
[Configuration](../configuration/index.md) to grant the permissions that make
the extra node-form controls appear.
