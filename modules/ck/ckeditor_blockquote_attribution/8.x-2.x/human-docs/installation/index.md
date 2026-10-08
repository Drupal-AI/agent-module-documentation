# Installation

## Requirements

- **Drupal 9.3 or 10** (`core_version_requirement: ^9.3 || ^10`).
- Core's **CKEditor** module (`ckeditor`) — the **legacy CKEditor 4** editor.
  This plugin targets CKEditor 4, not CKEditor 5, so it only applies to sites
  still using CKEditor 4 text formats.

There are no third-party Composer packages or PHP library requirements. This
module is covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_blockquote_attribution -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ckeditor_blockquote_attribution -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_blockquote_attribution -y
```

## Verify it worked

On a text format that uses the legacy CKEditor 4 editor, add the **Blockquote
Attribution** button to the toolbar and save. Then edit content, select some
text, click the button, and enter a source — confirm the rendered output is a
`<figure>` with a `<blockquote>` and a `<figcaption>`. If it comes out as a bare
blockquote, check that the format's filters allow `figure`, `figcaption`, and
`blockquote[cite]`. See the [main guide](../index.md#how-to-use-it) for the steps.
