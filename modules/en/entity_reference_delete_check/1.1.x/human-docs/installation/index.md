# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- No third‑party Composer packages or PHP libraries.
- The optional **Delete Check Paragraph URL** submodule additionally requires
  the [Paragraphs](https://www.drupal.org/project/paragraphs) module.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_delete_check -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_reference_delete_check -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_delete_check -y
```

That's all it takes. From now on, the reference check runs automatically on the
delete confirmation form of any content entity.

## Submodules

**Delete Check Paragraph URL** (`entity_reference_delete_check_paragraph_url`)
is optional. When an entity is referenced from inside a paragraph, this
submodule adds the URL of the page where that paragraph is used, so you can jump
straight to the referencing content. Enable it only if your site uses
Paragraphs:

```bash
drush en entity_reference_delete_check_paragraph_url -y
```

It requires the Paragraphs module, which Drupal will flag if it is not present.

## Verify it worked

Find an entity you know is referenced somewhere — for example a taxonomy term
used on several nodes — and go to delete it. On the "Are you sure?"
confirmation form you should now see a list of the references that still point
at it. Cancel out; the check is informational and does not force any action.
