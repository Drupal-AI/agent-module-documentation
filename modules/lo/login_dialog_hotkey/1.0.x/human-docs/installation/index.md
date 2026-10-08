# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No third‑party libraries and no other module dependencies — it builds on core's
  dialog/off‑canvas system and the standard login form.

## Install with Composer

From the project root:

```bash
composer require drupal/login_dialog_hotkey -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/login_dialog_hotkey -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en login_dialog_hotkey -y
```

The default shortcut (**Ctrl + Meta + L**) is active immediately. You'll usually
want to review the settings and grant the permission — see below and
[Configuration](../configuration/index.md).

## Permissions

The module defines a **Configure login dialog hotkey** permission that controls
access to the settings form. Grant it at **People → Permissions**
(`/admin/people/permissions`) to any role that should be able to change the hotkey
(administrators hold the necessary access by default).

## Verify it worked

Log out, or open the site in a private/incognito window, and press the configured
key combination (Ctrl + Meta + L by default). The login form should open in a
dialog. If it doesn't appear while you're logged in, that's expected — the shortcut
is attached for anonymous visitors only.
