# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — this is the only
  dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_bold_italic -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor5_bold_italic -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_bold_italic -y
```

That is all it takes. The module immediately alters the existing Bold and Italic
buttons across every CKEditor 5 toolbar — there is no button to add and no
settings to configure.

## Verify it worked

Open a content edit form that uses a CKEditor 5 text format, type some text, and
make it bold, then switch to **Source** (or view the saved markup). You should see
`<b>…</b>` rather than `<strong>…</strong>`, and `<i>…</i>` rather than
`<em>…</em>`. If the tags disappear on save, add `<b>` and `<i>` to the format's
allowed HTML tags.
