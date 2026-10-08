# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Flag** module (`flag`) — Flag Lists extends it.
- Core's **Views** module (`views`) — used to render and list the collections.

Both are installed/enabled as dependencies. There are no third‑party PHP library
requirements.

## Install with Composer

> **Pin to 4.0.3.** Release **4.0.4** has a malformed dependency manifest (the
> require key concatenates the package name with its version constraint), which
> breaks Composer installation — you'll typically see a "Malformed input to a URL"
> curl error. Release **4.0.3** installs cleanly, so pin to it until upstream
> fixes the typo.

From the project root:

```bash
composer require drupal/flag_lists:4.0.3 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Flag and Views
modules and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flag_lists:4.0.3 -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flag_lists -y
```

This also enables the Flag and Views modules if they aren't already on.

## Submodules

- **Flag Lists Actions** (`flag_lists_actions`) adds actions around the lists.
  Enable it only if you need those actions:

  ```bash
  drush en flag_lists_actions -y
  ```

## Verify it worked

Go to **Configuration → Flag Lists** (`/admin/config/flag_lists`) to confirm the
settings page loads, and **Structure → Flag Lists**
(`/admin/structure/flag_lists/flag_for_list`) to designate a flag as a list
template. Then, as a regular user with the right permission, confirm you can
create a named list and flag content into it. See
[Configuration](../configuration/index.md) for the full setup.
