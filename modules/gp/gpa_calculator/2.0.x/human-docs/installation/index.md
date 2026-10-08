# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **JavaScript enabled** in visitors' browsers — the calculator computes the GPA
  client‑side.
- No additional contrib modules or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/gpa_calculator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gpa_calculator -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gpa_calculator -y
```

## Verify it worked

Go to **Structure → Block layout**, place the **GPA Calculator** block in a
region, and save. Visit a page in that region — you should see the calculator
table with six rows plus the cumulative GPA section. Enter a couple of courses and
confirm the GPA updates.
