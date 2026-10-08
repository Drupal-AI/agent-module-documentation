# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Textfield Counter** module (`textfield_counter`) — the character‑count
  submodule wraps it. Composer and Drupal pull it in as a dependency.
- A **LocalGov Drupal** site — the module targets the distribution's content types.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_utilities -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Textfield Counter and
shared dependencies alongside it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_utilities -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

The base module is a hidden support module and does little on its own — enable the
character‑count submodule to get the useful feature:

```bash
drush en localgov_char_count -y
```

(Enabling the submodule enables the base `localgov_utilities` module and Textfield
Counter as dependencies.)

## Submodules

| Submodule | What it adds |
|-----------|--------------|
| `localgov_char_count` | **LocalGov Character Counter** — a single settings form that configures Textfield Counter for LocalGov title and summary fields, giving editors live character‑count feedback. |

## Verify it worked

Go to **Configuration → Content authoring → LocalGov Character Count**
(`/admin/config/content/localgov-char-count`). You should see the character‑count
settings form. After configuring it (see [Configuration](../configuration/index.md)),
edit a piece of content and confirm the live character count appears under the title
or summary field.
