# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.1** or newer, with the **JSON** extension (`ext-json`) — this ships
  with virtually every PHP build.
- To manage extra fields through the admin UI you also need the bundled
  **entity_extra_field_ui** submodule, which in turn requires core's **Field
  UI** module (`field_ui`).

There are no other third-party Composer or library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_extra_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_extra_field -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_extra_field -y
```

That installs the engine. On its own it has no admin screen — it simply makes
the extra-field machinery available.

## Enable the UI submodule

To actually create and place extra fields through the interface, enable the
bundled UI submodule (it pulls in core's Field UI automatically):

```bash
drush en entity_extra_field_ui -y
```

You now get a **Manage extra fields** operation on every bundle, plus the
add/edit/delete forms and the **Reports → Extra fields**
(`/admin/reports/extra-fields`) audit page.

Once your extra fields are configured, you can safely disable
`entity_extra_field_ui` again on production — the fields you created continue to
render because they live in the base module's configuration.
