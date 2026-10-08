# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No third‑party Composer packages and no separate PHP library requirements.
- **Mammoth.js is already bundled** with the module — you do not need to install
  it separately.

## Install with Composer

From the project root:

```bash
composer require drupal/docx_to_html -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/docx_to_html -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en docx_to_html -y
```

## Grant the access permission

The converter page is gated by the **Access DOCX to HTML Converter**
(`access docx to html converter`) permission. Go to **People → Permissions**
(`/admin/people/permissions`) and grant it to the roles whose content authors
should be able to use the tool.

## Verify it worked

Log in as a user with the permission and visit `/docx-to-html` (or
**Configuration → Content authoring → DOCX to HTML Converter**). Pick a `.docx`
file — an HTML preview should appear immediately below the file input, along with
a **Copy the HTML** button. Because conversion is done entirely in the browser,
nothing is uploaded to the server.
