# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — Drupal enables it
  automatically as a dependency when you turn on CKEditor Templates.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_templates -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor_templates -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_templates -y
```

This also enables the CKEditor 5 dependency if it is not already on.

## Grant permissions

CKEditor Templates has two permissions. Grant them to the appropriate roles at
**People → Permissions**, or from the CLI:

```bash
# editors who should be able to USE templates:
drush role:perm:add content_editor 'insert ckeditor templates'
# site builders who should MANAGE the template library:
drush role:perm:add site_builder 'administer ckeditor templates'
```

Note that the Templates toolbar button will render for anyone editing in a format
that has it, but the template dialog itself returns a "403 access denied" without
the **Insert CKEditor Templates** permission.

## Verify it worked

Log in as a user with the *administer ckeditor templates* permission and go to
**Configuration → Content authoring → CKEditor Templates**
(`/admin/config/content/ckeditor-templates`). You should see the (initially
empty) template collection with an **Add template** button. Next, head to
[Configuration](../configuration/index.md) to create your first template and add
the Templates button to a text format.
