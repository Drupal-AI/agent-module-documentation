# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no other Drupal module dependencies to enable. The
`ProfessionalWiki/EDTF` PHP library that validates and parses the values is pulled
in automatically by Composer when you require the module.

## Install with Composer

From the project root:

```bash
composer require drupal/edtf -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the EDTF library
and update any shared dependencies as needed. Installing via Composer is important
here, since it is what brings in the underlying EDTF library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/edtf -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en edtf -y
```

## Verify it worked

Go to **Structure → Content types → (any type) → Manage fields** and add a field.
If **EDTF** appears in the list of field types, installation succeeded. Add an EDTF
field, enter a value such as `2023-12~` on a piece of content, and confirm it saves
— then set the display formatter to **EDTF Humanizer** to see it rendered in
readable form.
