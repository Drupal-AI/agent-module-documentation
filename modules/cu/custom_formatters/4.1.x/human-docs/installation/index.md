# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- **PHP 8.2 or newer** (`php: >=8.2`).
- Core's **Field** (`field`) and **Field UI** (`field_ui`) modules enabled —
  these are declared dependencies and provide the *Manage display* screens where
  your formatters appear.

There are no third‑party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_formatters -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/custom_formatters -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_formatters -y
```

Drupal enables Field UI (and Field) at the same time as dependencies. There are no
submodules.

## Optional companion modules

Custom Formatters works on its own, but several contrib modules enhance it if you
install them. None are required:

| Module | What it adds |
|--------|--------------|
| **CodeMirror Editor** (`codemirror_editor`) | Syntax highlighting and autocomplete for the PHP, HTML+Token, and Twig code fields. |
| **Token** (`token`) | Token replacement used by the HTML+Token engine, plus a token browser. |
| **Field Tokens** (`field_tokens`) | Field‑level tokens, handy for HTML+Token formatters. |
| **Insert** (`insert`) | Lets image/file/entity‑reference custom formatters appear as "Insert" styles in text fields. |
| **Devel** (`devel`) | Debug output for the preview feature and Devel Generate sample content. |

Install any of them the same way, for example:

```bash
composer require drupal/codemirror_editor -W
drush en codemirror_editor -y
```

## Before you grant access

Because the PHP and Twig engines execute code, decide carefully who gets the
*Administer Custom Formatters* permission — it amounts to arbitrary code execution
on the server. Grant it only to fully trusted administrators. Then head to
[Configuration](../configuration/index.md) to create your first formatter.
