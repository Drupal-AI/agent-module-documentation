# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **LLMs.txt** module (`drupal/llms_txt`) — provides `/llms.txt` and the section
  entities this module populates.
- The **Markdownify** module (`drupal/markdownify`, the `markdownify_path` component)
  — provides the `.md` markdown rendering of each node that the links point to.
- Working **cron** if you want the sections to refresh automatically.

Composer resolves the module dependencies for you. There are no PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/llms_txt_gen -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in LLMs.txt and
Markdownify and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/llms_txt_gen -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en llms_txt_gen -y
```

Enabling the module runs an initial generation automatically and creates an
"LLMs.txt Raw" text format used for the section content.

## Verify it worked

Log in as an administrator and open **Configuration → Search and metadata →
LLMs.txt Gen** (`/admin/config/search/llms-txt-gen`). You should see the content‑type
selection form. Then visit `/llms.txt` and confirm it now contains a section per
content type with markdown links to each node's `.md` URL. You can force a rebuild
with `drush llms-gen`.
