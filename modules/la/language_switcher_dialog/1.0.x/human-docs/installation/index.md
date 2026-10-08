# Installation

## Requirements

- **Drupal 11.3 or newer** — the module relies on core's HTMX integration
  (`core/drupal.htmx`), which arrives in Drupal 11.3.
- **PHP 8.3 or newer.**
- Core's **Language** module (`language`) enabled, with **two or more languages**
  configured.

There are no third‑party Composer or PHP library requirements for the base
module. Some submodules have their own dependencies (see below).

## Install with Composer

From the project root:

```bash
composer require drupal/language_switcher_dialog -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/language_switcher_dialog -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en language_switcher_dialog -y
```

Then place the block (see the "How to use it" section of the
[overview](../index.md)).

## Submodules — enable only what you need

The project ships several optional submodules that extend the base switcher:

| Submodule | What it adds | Extra requirements |
|-----------|--------------|--------------------|
| **Countries** | Maps languages to countries and world regions (adds country code, base language code, and region fields to each language). Ships two dialog content providers — *Enhanced links* (a flat list enriched with country names and optional flag icons) and *Grouped by region* (languages under region headings). Adds country‑aware trigger formats (e.g. "BE - NL", "Belgium - Dutch"). | The **Country** module; optionally the **Flags** module for flag icons. |
| **GeoIP** | Shows a one‑time language‑suggestion popup for first‑time visitors based on their IP‑detected country, loaded via HTMX, with a server‑side cookie check and configurable bot detection to skip crawlers. | The **Countries** submodule above, plus **Smart IP**. |
| **disable_language support** | Integrates with the **disable_language** module so disabled languages can be hidden from dialog‑based switching where appropriate. | The **disable_language** module. |

Enable a submodule the usual way once its requirements are present, for example:

```bash
drush en language_switcher_dialog_countries -y
```

(Confirm the exact machine name on the **Extend** page; each submodule requires
the base module, which you have already installed.)

## Verify it worked

Place the **Language Switcher Dialog** block under **Structure → Block layout**,
then view the site as a visitor. You should see the trigger button showing the
current language; clicking it opens the modal dialog with the language links, and
pressing **Escape** closes it.
