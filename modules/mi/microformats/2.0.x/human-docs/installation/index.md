# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- Core's **Block** module (`block`) — required; core provides it.
- The **`mf2`** PHP library, pulled in automatically via Composer (see below).

## Install with Composer

From the project root:

```bash
composer require drupal/microformats -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and Composer installs the `mf2` library the module relies
on. Installing via Composer (rather than downloading the module manually) is
important here so that the required PHP library is present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/microformats -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en microformats -y
```

## Verify it worked

Place the Microformats **contact information** block from **Structure → Block
layout**, or set the Microformats e-mail formatter on an e-mail field's Manage
display. View the rendered page and inspect the HTML source to confirm the
microformats classes (for example `h-card`) are present. Note this is a beta
release.
