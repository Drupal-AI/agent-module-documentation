# Installation

## Requirements

Webform Group is an integration module, so it needs both sides of the integration
present:

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- **PHP 8.0 or newer**.
- **Webform** (`drupal/webform` `^6.2@dev`) and its **Webform Node**
  (`webform_node`) submodule — the webform must be attachable to a node.
- **Group** (`drupal/group` `^3.0`) and its **Group Node** (`gnode`) submodule — so
  a node can belong to a group.

All four modules — `webform`, `webform_node`, `group`, and `gnode` — must be
enabled; Webform Group only takes effect when a webform's source entity is a
group‑related node.

## Install with Composer

From the project root:

```bash
composer require drupal/webform_group -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the
Webform and Group packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/webform_group -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable Webform Group along with the required submodules (Drupal will pull in the
base Webform and Group modules automatically):

```bash
drush en webform_group webform_node gnode -y
```

## Optional: the demo submodule

Webform Group ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Webform Demo Group** | `webform_demo_group` | Example group types and a demo webform that show the integration working, useful for trying it out or learning the setup. Enable it only on a development or trial site. |

```bash
drush en webform_demo_group -y
```

## Verify it worked

Open a webform that is attached to a group node and go to its **Settings → Access**
page. Each permission row (view/update/delete submissions, and so on) should now
show an extra **Group (node) roles** selector. If you see those selectors, the
integration is active. Next, see [Configuration](../configuration/index.md).
