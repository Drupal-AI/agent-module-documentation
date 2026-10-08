# Installation

## Requirements

N1ED works with core's CKEditor and needs two common PHP extensions:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- A CKEditor-based text format — CKEditor 5 (core) or the legacy CKEditor 4.
- The PHP **`json`** extension (`ext-json`) and the PHP **`gd`** extension
  (`ext-gd`, used for image handling by the Flmngr file manager). Both are standard
  on most Drupal hosting, including DDEV.
- Outbound network access to `cloud.n1ed.com` / the N1ED CDN, since the editor
  front-end loads from there.

There are no contrib module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/n1ed -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/n1ed -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en n1ed -y
```

On enable, the module:

- creates the Flmngr working directories `public://flmngr`, `public://flmngr-tmp`,
  and `public://flmngr-cache`;
- sets the shipped **demo** API key; and
- **auto-attaches N1ED to Full-HTML-style text formats** — any format whose editor
  is CKEditor and which is not restricted by the *Limit allowed HTML tags*
  (`filter_html`) filter. For `full` / `full_html` it will even disable those
  filters in order to attach, and it moves N1ED-enabled formats to the top of the
  format selector.

Because of that auto-attach behaviour, review your text formats after enabling so
N1ED is only active on formats meant for trusted editors. Then set your real API key
and adjust settings — see [Configuration](../configuration/index.md).

There are no submodules.
