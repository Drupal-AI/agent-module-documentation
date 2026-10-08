# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- A large set of contrib and core modules that Common configures, including:
  Acquia Purge, Config Ignore, Config Rewrite, Diff, Metatag (Open Graph,
  Twitter Cards), Moderation Dashboard, Password Policy (character types, length,
  username), Pathauto, Redirect, Scheduler Content Moderation Integration,
  Schema.org Metatag (Article, Person, Place), Simple Sitemap, Seckit, Smart
  Trim, Username Enumeration Prevention, Workbench Email, plus core Block,
  CKEditor 5, Config, Config Translation, Content Moderation, Content
  Translation, Language, Media, Menu UI, Node, and Taxonomy.

Composer resolves and installs all of these for you — you do not add them by
hand. This is the base layer of the Acquia CMS distribution, so it is normally
present whenever any other `acquia_cms_*` module is installed.

## Install with Composer

From the project root:

```bash
composer require drupal/acquia_cms_common -W
```

The `-W` (`--with-all-dependencies`) flag is important here — Common has a wide
dependency tree, and `-W` lets Composer pull in and align all of it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/acquia_cms_common -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en acquia_cms_common -y
```

Drush enables the full dependency set automatically. This can take a moment given
how many modules are involved.

## Submodules — enable only what you need

Common ships two optional submodules, enabled individually:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Acquia CMS Development** | `acquia_cms_development` | Development-oriented configuration; intended for local/dev environments, not production. |
| **Acquia CMS Support** | `acquia_cms_support` | Support and diagnostic tooling for the distribution. |

For example:

```bash
drush en acquia_cms_development -y
```

## A note on config

Because Common enables Config Ignore and Config Rewrite, some of the
distribution's configuration is managed or protected on import/export. Keep that
in mind when you run `drush config:export` / `config:import` on an Acquia CMS
site.
