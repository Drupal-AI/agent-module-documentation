# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Taxonomy** (`taxonomy`) module — no modules or libraries outside Drupal
  core are required.

## Install with Composer

From the project root:

```bash
composer require drupal/popular_tags -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Name note:** if `drupal/popular_tags` does not resolve, try
> `drupal/popular-tags` — the project was renamed and both forms have been used.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/popular_tags -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en popular_tags -y
```

## Verify it worked

1. Edit a term-reference (tags) field on a content type at **Structure → Content
   types → *(your type)* → Manage fields**.
2. Confirm a **Popular Tags** fieldset appears in the field settings, with a **Use
   Clickable Popular Tags?** checkbox.
3. Enable it, save, then create or edit a node of that type — you should see a list
   of clickable popular tags beneath the tag field (provided some tags already
   exist).
