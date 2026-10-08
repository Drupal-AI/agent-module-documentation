# Installation

## Requirements

Seeds Editor needs **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
The defining fact about installing it is its **seventeen dependencies**, which
Composer will pull in for you:

- **Core modules:** CKEditor 5 (`ckeditor5`), Text Editor (`editor`), Filter
  (`filter`), Image (`image`), Media (`media`), and Media Library
  (`media_library`).
- **Contrib modules:** Ace Editor (`ace_editor`), Allowed Formats
  (`allowed_formats`), Smart Trim (`smart_trim`), Blazy (`blazy`), Editor
  Advanced Link (`editor_advanced_link`), Entity Embed (`entity_embed`), Linkit
  (`linkit`), CKEditor Bidi (`ckeditor_bidi`, the RTL support), CKEditor 5 Plugin
  Pack (`ckeditor5_plugin_pack`), Media Embeddable (`media_embeddable`), CKEditor
  Responsive Table (`ckeditor_responsive_table`), and CKEditor Media Resize
  (`ckeditor_media_resize`).

There are no additional PHP or third-party library requirements. Because the
footprint is so large, it is worth installing this on a fresh or Seeds-based site;
on an existing site, plan to reconcile the shipped text formats with any you
already have.

## Install with Composer

From the project root:

```bash
composer require drupal/seeds_editor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the
seventeen dependencies as needed — you will want it here.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/seeds_editor -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en seeds_editor -y
```

Enabling Seeds Editor also enables all of its dependencies and applies the Seeds
text-format and CKEditor configuration.

## Verify it worked

Edit any content with a rich-text field (for example the body of a page). You
should see the assembled CKEditor 5 toolbar with the extra buttons for links,
media embedding, and tables. To review or adjust the module's own settings, head
to **Configuration → Content authoring → Seeds Editor** — see
[Configuration](../configuration/index.md).
