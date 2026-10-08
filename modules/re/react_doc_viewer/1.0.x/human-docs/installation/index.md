# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **REST** module (`rest`) and, with it, core **Serialization** — used by
  the file-metadata endpoint.
- A file field on some entity to attach the viewer to.

The React application is bundled with the module (`js/dist/index.js`), so there is
no separate library to install.

> **Before you install:** this project's security advisory coverage is **not
> covered** and it is seeking co-maintainers — see the note on the
> [overview page](../index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/react_doc_viewer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/react_doc_viewer -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en react_doc_viewer -y
```

Core REST and Serialization are enabled as dependencies if they are not already
on. The module's REST resource is provisioned from its `config/install` with
cookie authentication and the JSON format.

## Set the formatter and permissions

1. On a file field's **Manage display**, choose the **Rdv field formatter**.
2. At **People → Permissions**, grant **Access page file viewer** and the relevant
   **RESTful GET** permission to the roles that should use the viewer.

## Verify it worked

View content that has the file field: you should see a link to the document
viewer, and following it should open the file in the bundled React viewer at
`/rdv/{fid}`.
