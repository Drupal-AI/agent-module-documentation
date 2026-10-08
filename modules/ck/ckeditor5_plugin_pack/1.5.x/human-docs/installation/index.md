# Installation

## Requirements

CKEditor 5 Plugin Pack needs:

- **PHP 8.0+**.
- **Drupal core 10.3+ or 11** (`drupal/core: ^10.3 || ^11.0`).
- Core's **Editor** (`editor`) and **CKEditor 5** (`ckeditor5`) modules — these
  ship with Drupal and are enabled automatically as dependencies.
- The **CKEditor 5 Premium Features** module
  (`drupal/ckeditor5_premium_features: ^1.6.4 || ^1.7`) — pulled in by Composer.
  It supplies the shared plumbing for CKEditor's premium plugins.

The pack itself is an umbrella project. The base module provides common
functionality; the actual editor features come from **submodules** you enable
individually, such as `ckeditor5_plugin_pack_font`,
`ckeditor5_plugin_pack_highlight`, `ckeditor5_plugin_pack_find_and_replace`,
`ckeditor5_plugin_pack_word_count`, `ckeditor5_plugin_pack_media_embed`,
`ckeditor5_plugin_pack_emoji`, `ckeditor5_plugin_pack_fullscreen` and more (see
the [agent overview](../../agent/plugins/overview.md) for the full list).

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_plugin_pack -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update the
required dependencies — including CKEditor 5 Premium Features — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor5_plugin_pack -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module first:

```bash
drush en ckeditor5_plugin_pack -y
```

Then enable each feature submodule you want. For example, to turn on the font and
highlight tools:

```bash
drush en ckeditor5_plugin_pack_font ckeditor5_plugin_pack_highlight -y
```

You can also enable submodules from **Extend** (`/admin/modules`) by ticking them
and clicking **Install**. Only the submodules you enable add buttons to the
editor, so a site stays lean and loads JavaScript only for the features in use.

## A note on premium features

The bundled plugins listed above are free. CKEditor also offers **premium**
plugins through the CKEditor 5 Premium Features module. Those require a valid
**license key**, which you obtain from CKEditor (the settings page links to a
14-day free trial — see [Configuration](../configuration/index.md)).

A license key is a **secret**: keep it out of version-controlled configuration.
Store it in an environment variable (or a Key entity backed by one) rather than
pasting it into config that gets committed, following your project's secret-handling
conventions.

## Verify it worked

Log in as an administrator and go to
`/admin/config/ckeditor5-plugin-pack`. You should see the **CKEditor 5 Plugin
Pack settings** page:

![The CKEditor 5 Plugin Pack settings page](../images/settings.png)

If that page loads, the base module is installed correctly. Next, review the
[configuration](../configuration/index.md) and add your new buttons to a text
format's toolbar.
