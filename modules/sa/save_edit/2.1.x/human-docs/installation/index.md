# Installation

## Requirements

Save & Edit is a self‑contained content‑authoring helper. It needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Node** module (part of a standard Drupal install) — the button is added to
  node forms.

There are no third‑party Composer packages, no PHP library requirements, and no other
module dependencies. If you use the **Gin** admin theme, Save & Edit integrates with
it (see Configuration), but Gin is not required.

## Install with Composer

From the project root:

```bash
composer require drupal/save_edit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/save_edit -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en save_edit -y
```

If the Gin admin theme is active at install time, the module automatically turns on
its "primary action" option so the button appears prominently.

## Grant the permissions

Save & Edit adds two permissions at **People → Permissions**
(`/admin/people/permissions`):

- **Use save and edit** — required for the button to appear on a user's node forms.
  Grant it to your authoring/editor roles.
- **Administer save and edit** — access to the settings form. Give it to
  administrators.

## Verify it worked

Enable Save & Edit on at least one content type (see
[Configuration](../configuration/index.md)), then add or edit a node of that type. The
**Save & Edit** button should appear among the form's action buttons; clicking it
saves the node and returns you to the edit form.
