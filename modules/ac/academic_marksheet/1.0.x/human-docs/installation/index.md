# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core modules **Views**, **Field**, **User**, and **Taxonomy** — these are
  dependencies and Drupal will enable them as needed.
- No third-party Composer or PHP library requirements are declared.

## Install with Composer

From the project root:

```bash
composer require drupal/academic_marksheet -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/academic_marksheet -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en academic_marksheet -y
```

## Set up permissions

Under **People → Permissions**, assign the three permissions according to who
should do what:

- **`administer marksheet`** — overall administration; keep with staff.
- **`assign marks`** — entering marks for students; keep with staff.
- **`view own results`** — lets a student see only their own results; give this to
  the student role.

Because marks are personal data, do not grant the administer or assign
permissions to ordinary user roles.
