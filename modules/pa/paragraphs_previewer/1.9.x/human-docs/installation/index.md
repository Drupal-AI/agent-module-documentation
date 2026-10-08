# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **[Paragraphs](https://www.drupal.org/project/paragraphs)** module
  (`paragraphs`) — this is a hard dependency, since the whole point of the module
  is to preview paragraphs. Composer installs it automatically if it isn't already
  present.

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_previewer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed — including pulling in Paragraphs if you don't have it yet.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_previewer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_previewer -y
```

## Grant the permission

The preview modal is protected by a permission. Give it to every role that edits
paragraphs, or the Preview button will return a 403 when clicked:

```bash
drush role:perm:add editor 'view any paragraphs previewer'
```

Or in the UI, go to **People → Permissions** (`/admin/people/permissions`), find
**View any paragraphs previewer**, tick it for the appropriate roles, and save.

## Next steps

There is no configuration page. To start previewing, switch a Paragraphs field to
the **Paragraphs Previewer** widget on its *Manage form display* tab — see the
[main guide](../index.md#how-to-use-it) for the steps and the optional preview
view-mode setting.
