# Installation

## Requirements

Coffee needs **Drupal 10.2+ or 11** (`^10.2 || ^11.0`). It has **no other module
dependencies** — nothing extra to install alongside it. Its front end is a small
JavaScript/CSS library built on the jQuery, autocomplete, and `once` libraries that
ship with Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/coffee -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any packages it needs
along the way.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/coffee -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en coffee -y
```

Once enabled, Coffee's settings appear under **Configuration → User interface →
Coffee** (`/admin/config/user-interface/coffee`).

## Grant the "Access Coffee" permission

Enabling the module is not quite enough — a user can only open the search box if
their role has the **Access Coffee** permission. Grant it to the roles that should
be able to use Coffee:

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Find the **Coffee** section.
3. Tick **Access Coffee** for each role that should be able to use the search box
   (for example your editor and administrator roles).
4. Click **Save permissions**.

A second permission, **Administer Coffee**, controls who may open the configuration
form covered in the next section. Grant that one to trusted administrators only.

## Verify it worked

Log in as a user who has the **Access Coffee** permission and press the keyboard
shortcut (by default **Alt + D**). A search overlay should appear in the middle of
the page. If it does, Coffee is installed and working. Next, review the
[configuration and usage](../configuration/index.md) page to choose which menus it
searches.
