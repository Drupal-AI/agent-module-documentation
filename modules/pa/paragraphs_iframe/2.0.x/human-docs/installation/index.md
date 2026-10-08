# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- The **Paragraphs** module (`paragraphs`), plus core's **Field** (`field`),
  **Language** (`language`) and **Link** (`link`) modules. Drupal enables these as
  dependencies when you turn on Paragraphs Iframe.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_iframe -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_iframe -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_iframe -y
```

This module is delivered as configuration. Enabling it installs the **iframe**
paragraph type and its **Source** link field. Some of the pieces (the field
storage, field, and form/view displays) ship as **optional** config — if the
iframe type or field is not present after enabling, import the module's optional
config so the paragraph type and field are created.

## Verify it worked

Go to **Structure → Paragraph types** and confirm an **iframe** type is listed.
Open its **Manage fields** and check that the required **Source** link field
(`field_iframe_source`) exists. Once you add a Paragraphs field to a content type
that allows the iframe type, editors can add the paragraph and store an embed
URL.
