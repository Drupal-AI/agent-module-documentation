# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Section Library** module (`section_library`) — this is a hard dependency;
  the whole feature is an addition to Section Library's "Add to library" form.
  You will typically be using Layout Builder as well, since that is where Section
  Library operates.

There are no third-party PHP or library requirements, and there are no submodules.

## Install with Composer

From the project root:

```bash
composer require drupal/section_library_reusable -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Section Library
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/section_library_reusable -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en section_library_reusable -y
```

Enabling it will also enable Section Library if it is not already on.

## Verify it worked

Open a Layout Builder layout, and where Section Library offers **"Add to
library"** on a section, confirm the form now shows a **reusable** checkbox. That
checkbox is the entire feature — there is no separate settings page.
