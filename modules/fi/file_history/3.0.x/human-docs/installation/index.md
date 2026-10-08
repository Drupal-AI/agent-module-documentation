# Installation

## Requirements

File History needs:

- **Drupal 10** (`core_version_requirement: ^10`).
- Core's **File** module (`file`), which Drupal enables automatically as a
  dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/file_history -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_history -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_history -y
```

If you want the bundled example forms to learn from, also enable the test
submodule (development sites only):

```bash
drush en test_file_history -y
```

It ships a preconfigured node type and an example form at
`/admin/file_history/exemple_form`.

## Verify it worked

After enabling, the `file_history` form element and its field widget are available
for use. Grant the "download file histoy files" permission on **People →
Permissions** to the trusted roles that should be able to download retained files,
and confirm the download route `/file_history/download/{file}` serves a file for
an authorised user.
