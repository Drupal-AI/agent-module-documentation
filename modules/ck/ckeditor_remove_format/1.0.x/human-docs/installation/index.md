# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- A text format (this module's filter attaches to text formats). No CKEditor 5 editor
  is actually required — the filter runs on rendered output regardless of which editor
  the format uses.
- No other module dependencies, and no third-party Composer or PHP library
  requirements.

> **Heads-up:** This project is maintained for fixes only and is **not covered by
> the Drupal security advisory policy**. Weigh that for production use.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_remove_format -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor_remove_format -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_remove_format -y
```

## Turn on the Remove Format Filter

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit the text format you want.
2. In the **Filters** section, enable **Remove Format Filter**.
3. Optionally adjust the **filter processing order** — this filter strips all tags, so
   its position relative to other filters affects the result.
4. Save the text format.

There are **no filter settings** to configure.

## Verify it worked

Create or edit content that uses that text format, include some HTML markup (for
example bold text or a link), and view the rendered output. The markup should be gone,
leaving only plain text — confirming the filter is stripping tags on render. Because it
removes **all** tags, enable it only on formats whose output you want reduced to plain
text.
