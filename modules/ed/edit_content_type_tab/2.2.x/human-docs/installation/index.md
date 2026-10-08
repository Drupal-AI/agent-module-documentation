# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No third‑party module or PHP library dependencies beyond Drupal core.
- Users need the core **Administer content types** permission to see and use the
  tab.

## Install with Composer

From the project root:

```bash
composer require drupal/edit_content_type_tab -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/edit_content_type_tab -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en edit_content_type_tab -y
```

## Verify it worked

Confirm it's enabled:

```bash
drush pm:list --status=enabled | grep edit_content_type_tab
```

Then log in as a user with **Administer content types**, open any node, and look
for the **Edit '&lt;Type Name&gt;' type** tab among the node's local tasks. The tab
appears automatically — there is nothing to configure. Clicking it takes you to
that content type's edit form and back again; it never changes the node itself.
