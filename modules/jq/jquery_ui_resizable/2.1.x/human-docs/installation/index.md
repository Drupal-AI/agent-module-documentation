# Installation

## Requirements

jQuery UI Resizable is a small library shim. It needs:

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- The **jQuery UI** base module (`jquery_ui`, `drupal/jquery_ui ^1.7`) — this is
  the only dependency, and it supplies the underlying jQuery UI asset data.
  Composer installs it for you when you require this module, and Drupal enables it
  as a dependency when you turn this module on.

There are no PHP extension requirements and no configuration.

## Install with Composer

From the project root:

```bash
composer require drupal/jquery_ui_resizable -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the `drupal/jquery_ui`
base library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jquery_ui_resizable -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jquery_ui_resizable -y
```

That's all it takes. There is no settings page and nothing to configure — the
`jquery_ui_resizable/resizable` library is now available for other modules,
themes, and custom code to depend on. See [How to use it](../index.md#how-to-use-it)
for how to attach it.

## Verify it worked

Confirm the module and its base dependency are enabled:

```bash
drush pm:list --status=enabled | grep -E 'jquery_ui'
```

You should see both `jquery_ui` and `jquery_ui_resizable` in the list.
