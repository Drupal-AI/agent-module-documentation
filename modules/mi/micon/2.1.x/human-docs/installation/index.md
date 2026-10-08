# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No hard module dependencies for the base module.

Some submodules need extra contrib modules (all optional, only if you enable that
submodule):

- **Paragraphs** (`drupal/paragraphs`) — for `micon_paragraphs`.
- **Linkit** (`drupal/linkit`) — for `micon_linkit` and `micon_linkit_attributes`.
- **Link Attributes** (`drupal/link_attributes`) — for `micon_linkit_attributes`.

There are no third-party Composer library requirements for the base module.

## Install with Composer

From the project root:

```bash
composer require drupal/micon -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/micon -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en micon -y
```

The shipped **Font Awesome** package (prefix `fa`) is active immediately, so icons
like `fa-user` work right away. To upload your own packages, see
[Configuration](../configuration/index.md).

## Submodules — enable only what you need

Micon ships nine optional submodules that add icons in specific places. Enable
them individually with `drush en`:

| Submodule | What it adds |
|---|---|
| `micon_menu` | Icons on menu links. |
| `micon_local_task` | Icons on admin local-task tabs. |
| `micon_content_type` | A content type's icon shown in its admin list. |
| `micon_vocabulary` | A vocabulary's icon shown in its admin list. |
| `micon_paragraphs` | Icons on paragraph bundles (needs Paragraphs). |
| `micon_link` | Icons on link-field values. |
| `micon_linkit` | Icons on Linkit autocomplete links (needs Linkit). |
| `micon_linkit_attributes` | Linkit + Link Attributes integration (needs both). |
| `micon_ckeditor` | Insert icons in CKEditor. |

For example:

```bash
drush en micon_menu -y
```

Each submodule requires the base Micon module, which is already present once you
have installed it above.
