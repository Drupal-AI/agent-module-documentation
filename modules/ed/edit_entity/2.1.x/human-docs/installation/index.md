# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Core's **Toolbar** module enabled, and a user role that can see the admin
  toolbar. The Edit/Translate buttons render into the toolbar, so without it there
  is nowhere for them to appear.
- No third‑party Composer or PHP library requirements.

Note that this project's security advisory coverage is *not* covered by the Drupal
Security Team — weigh that for production use.

## Install with Composer

From the project root:

```bash
composer require drupal/edit_entity -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/edit_entity -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en edit_entity -y
```

## Verify it worked

Confirm it's enabled:

```bash
drush pm:list --status=enabled | grep edit_entity
```

Then, logged in as a user with update access to some content, visit a node (or any
entity) and look in the admin toolbar for the **Edit {entity}** button. There is
nothing to configure — if the button doesn't appear, check that the Toolbar module
is on and that your user actually has update access to that entity.
