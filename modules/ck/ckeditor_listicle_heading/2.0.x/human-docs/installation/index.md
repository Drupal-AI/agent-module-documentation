# Installation

## Requirements

- **Drupal 9.3 or 10** (`core_version_requirement: ^9.3 || ^10`).
- The **CKEditor 4** editor (`ckeditor`) — this is a CKEditor 4 editor plugin.
  Note that CKEditor 4 was removed from Drupal core in favour of CKEditor 5, so
  you need CKEditor 4 present (for example through the CKEditor 4 LTS module) for
  this plugin to have an editor to attach to.
- No third‑party Composer or PHP library requirements.

> **Heads‑up:** This project is *minimally maintained* and is **not covered by
> the Drupal security advisory policy**. Treat it accordingly on production sites.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_listicle_heading -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor_listicle_heading -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_listicle_heading -y
```

## Add the button and allow the markup

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit a format that uses **CKEditor 4**.
2. In the CKEditor 4 toolbar configuration, add the **Listicle Heading** button
   (it lives in the *insert* group).
3. Make sure the format's **allowed HTML tags** include `div`, the heading tags
   you plan to use (`h2`, `h3`, …), and `span[class]`, so the generated structure
   survives filtering on output.
4. Save the text format.

## Verify it worked

Open a content field that uses that text format, click the **Listicle Heading**
button, and confirm the dialog appears. Insert a heading, save the content, and
check the rendered page shows the numbered heading with its `listicle-heading`
wrapper intact (styling comes from your theme).
