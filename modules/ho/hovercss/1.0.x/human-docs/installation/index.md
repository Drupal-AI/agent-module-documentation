# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- The **Hover.css library** downloaded from its GitHub project (see below). The
  module integrates the library but does not bundle it.

There are no other Drupal module dependencies and no third‑party Composer or PHP
library requirements beyond the Hover.css asset files themselves.

## Install with Composer

From the project root:

```bash
composer require drupal/hovercss -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/hovercss -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Download the Hover.css library

Download the latest version of the **Hover.css** library from its GitHub project
and place it in the location the module expects. The module's own **`README.md`**
lists the exact directory and file path — follow it precisely, because the effect
classes won't work until the library is where Drupal can load it.

## Enable the module

```bash
drush en hovercss -y
```

## Enable the UI submodule (optional)

If you'd rather apply effects through an interface than by adding classes to markup,
enable the bundled UI submodule:

```bash
drush en hovercss_ui -y
```

## Verify it worked

Add a Hover.css effect class (for example `hvr-grow`) to an element — a button or a
link — and load the page. Hovering over that element should trigger the animation.
If nothing happens, the most common cause is that the Hover.css library files aren't
in the path the module expects; recheck the location against the module's
`README.md`.
