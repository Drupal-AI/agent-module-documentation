# Installation

## Requirements

- **Drupal 8.7, 9, 10, or 11** (`core_version_requirement: ^8.7 || ^9 || ^10 || ^11`).
- **Contrib module:** SpamSpan (`spamspan`), which Composer installs for you.

There are no PHP or third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/sel -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in SpamSpan and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/sel -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sel -y
```

## Finish the setup

Enabling the module is not quite the whole job — Simple External Links only
processes the link sources you point at it:

- **Link fields** — on the display where the field appears, choose the Simple
  External Links (`sel_link`) formatter.
- **Text formats** — at **Configuration → Content authoring → Text formats and
  editors** (`/admin/config/content/formats`), edit each text format you use and
  enable the Simple External Links (`filter_sel`) filter.

Menu links are handled automatically once the module is on.

## Verify it worked

View a page that contains an external link handled by one of the sources above and
inspect the link in your browser: it should carry `target="_blank"` together with
a `rel` attribute of `noopener` / `noreferrer`, and clicking it should open a new
tab.
