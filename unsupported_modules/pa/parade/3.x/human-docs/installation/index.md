# Installation

## Requirements

Parade sits on top of a fairly large stack. It needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Paragraphs** module, which is Parade's foundation.
- A set of companion modules that Composer pulls in for you: **Geocoder**,
  **Geofield**, **Leaflet** (for the Location components), **View Mode Selector**,
  **Classy Paragraphs**, **Field Group** and **Machine Name**.

As of this version most features are still bundled into the single Parade module,
so you generally install all of the dependencies together — installing with
Composer (below) is strongly recommended, because the Location paragraph type has
known problems with non‑Composer installs.

## Install with Composer

From the project root:

```bash
composer require drupal/parade -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in and update the
Paragraphs, Geocoder/Geofield/Leaflet and other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/parade -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en parade -y
```

## Submodules — enable only what you need

Parade ships several optional submodules. Enable each with `drush en`:

| Submodule | What it adds |
|-----------|--------------|
| `parade_demo` | Demo content that bootstraps a page‑building setup so you can see the components in action. Its settings live at `/admin/config/content/parade_demo` (requires *Administer site configuration*). |
| `parade_pack` | Extra feature settings for Parade, configured at `/admin/config/content/parade_pack` (requires *Administer site configuration*). |
| `parade_conditional_field` | Adds conditional fields to Paragraph types (requires *Administer paragraph types*). |
| `marketo_form` | A Marketo form component (uses Marketo's generated form IDs). |
| `marketo_poll` | A Marketo poll component. |
| `linkedin_autofill` | A helper that autofills forms from LinkedIn. |
| `aggregated_leaflet_map` | Renders an aggregated Leaflet map from Geofield data. |

For example, to load the demo content:

```bash
drush en parade_demo -y
```

## Verify it worked

Log in as an administrator and go to **Structure → Paragraphs types**
(`/admin/structure/paragraphs_type`). You should see Parade's Paragraph types
listed. When you edit a node that has a Parade‑configured Paragraph field, adding a
section should show the inline preview widget rather than a plain nested form.

Next, if you enabled the demo or feature‑pack submodules, see
[Configuration](../configuration/index.md) for where their admin pages live.
