# Installation

## Requirements

Static Content Iframe is self-contained:

- **Drupal 9.3 or 10** (`core_version_requirement: ^9.3 || ^10`).
- No other module dependencies, and no extra PHP or third-party library
  requirements.

The module ships permissions — *add / edit / delete / view static content
entities* and *administer static content entities* (which is flagged as
restrict-access). Decide which trusted roles should hold these before you let
anyone upload archives, because uploaded HTML and JavaScript are served from your
site (see the note in the [main guide](../index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/sci -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sci -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sci -y
```

## Verify it worked

Go to **Structure → Static content** (`/admin/structure/static_content`). You
should see the collection where Static content entities are listed and where you
can add a new one by uploading a `.zip` archive. Then, under **People →
Permissions**, grant the static-content permissions only to the trusted roles that
should be allowed to upload and view this content.
