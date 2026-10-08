# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The contrib **Paragraphs** module (`drupal/paragraphs` `^1.15`) — the source of the
  paragraph items this module exposes as blocks.
- The **Chaos Tools (ctools)** module (`drupal/ctools` `^4.0`), used for the block
  deriver.
- Core's **Layout Builder** module enabled on the displays where you want to place
  paragraph blocks.

Composer installs Paragraphs and ctools automatically as dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraph_blocks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Paragraphs, ctools,
and any other shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/paragraph_blocks -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraph_blocks -y
```

Enabling it adds an `admin_title` base field to paragraph entities and makes the
derived **Paragraphs** blocks available in Layout Builder.

## Grant the permission

The global settings form is gated by the **Administer paragraphs settings**
permission. Grant it to your administrator role at **People → Permissions**, or:

```bash
drush role:perm:add administrator 'administer paragraphs settings'
```

## Verify it worked

Go to **Configuration → Content authoring → Paragraph Blocks**
(`/admin/config/content/paragraph_blocks`) and confirm the settings form loads. Then,
on a Layout Builder-enabled display of an entity that has a multi-value paragraph
field, click **Add block** and look for a **Paragraphs** category. See
[Configuration](../configuration/index.md) for the settings and the per-field enable
checkbox.
