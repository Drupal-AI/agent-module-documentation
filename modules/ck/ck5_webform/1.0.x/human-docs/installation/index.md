# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`), which ships with Drupal 10 and 11.
- The **[Webform](https://www.drupal.org/project/webform)** contributed module —
  provides the forms you embed.

There are no PHP library requirements.

> **Note:** this module is not covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/ck5_webform -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Webform
dependency alongside the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ck5_webform -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ck5_webform -y
```

Drupal will enable the Webform dependency automatically if it isn't already on.

## Turn on the widget

Enabling the module does not change any text format by itself. Per format you must add
the **Embed Webform** toolbar button and enable the **CKEditor 5 Webform Embed**
filter (and allow the embed tag if you use *Limit allowed HTML tags*). Those steps are
in the [guide](../index.md#how-to-enable-the-widget-in-a-text-format).

## Verify it worked

Make sure you have at least one active webform (**Structure → Webforms**). Then edit
content using the configured format: the **Embed Webform** icon should appear in the
toolbar, and inserting a form should show a placeholder in the editor. Save and view
the content as a visitor — the actual webform should render and be submittable.
