# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- The **Token** module (`token`) — a hard dependency, used for the filename
  pattern.
- The **`phpoffice/phpword`** library, installed via Composer — it generates the
  Word document.

## Install with Composer

Installing with Composer is required so the PhpWord library is fetched. From the
project root:

```bash
composer require drupal/entity_word -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the PhpWord and
Token dependencies and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_word -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_word -y
```

Drupal enables the Token dependency automatically.

## Grant the download permission

At **People → Permissions** (`/admin/people/permissions`), grant **Access the
download the node content as a word document** (`access download word document`)
to the roles that may download.

## Verify it worked

Grant yourself the download permission, then visit
`/entity-word/{node_id}/word` for a node you can access (for example
`/entity-word/1/word`), or click the **Download Word Document** tab on a node. A
`.docx` file containing the node's title and body should download. Then tune the
output in [Configuration](../configuration/index.md).
