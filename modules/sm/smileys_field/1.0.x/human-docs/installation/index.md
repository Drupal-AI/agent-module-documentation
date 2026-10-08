# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1||^11`).
- Core's **Field** module (`field`), which is part of the standard Drupal
  install and is enabled automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/smileys_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/smileys_field -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en smileys_field -y
```

## Verify it worked

Go to **Structure → Content types →** *(any type)* **→ Manage fields → Add
field**. In the field‑type list you should now see a **Smileys** option. Add it,
save, and edit a piece of content — you should get a smiley/emoji picker on the
form.
