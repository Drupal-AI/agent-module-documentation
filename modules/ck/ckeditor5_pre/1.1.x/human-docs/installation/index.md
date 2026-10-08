# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Drupal core's **CKEditor 5** module (`ckeditor5`) — a direct dependency,
  enabled with the module.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_pre -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor5_pre -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_pre -y
```

## After enabling — re-save restricted formats

The preformatted option is added to CKEditor 5's Heading dropdown automatically.
However, if a text format uses **"Limit allowed HTML tags and correct faulty
HTML"** (such as *Basic HTML*), open that format at **Configuration → Content
authoring → Text formats and editors** and click **Save configuration** once so
`<pre>` is added to its allowed-tags list.

## Verify it worked

Edit content with a CKEditor 5 format, open the **Heading** dropdown, and confirm
a preformatted option is listed. Apply it to some text — it should display in a
monospace font with a background in the editor.
