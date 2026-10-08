# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** (`field`), **Editor** (`editor`), and **Filter** (`filter`)
  modules — all part of Drupal core and enabled as needed.

There are no third‑party PHP libraries to install. The ACE Editor JavaScript
library used for the in‑browser code editing is handled by the module; its source
path can be adjusted on the settings form (see
[Configuration](../configuration/index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/inline_formatter_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/inline_formatter_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en inline_formatter_field -y
```

On install the module creates a text editor profile named **IFF Ace Editor**
(`iff_ace_editor`), which becomes the default editor for the Inline Formatter
field. You can configure it like any other editor with filters, or swap it for a
different one on the settings form.

## Submodules

Two optional submodules extend the base module. Enable whichever you need with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Inline Formatter Display** | `inline_formatter_display` | Lets you override the entire display of an entity per bundle — effectively an entity display Twig template configured from the Manage display tab. This is the recommended choice for anything beyond combining a couple of fields. |
| **Inline Formatter Views Field** | `inline_formatter_views_field` | Brings the same field‑combining, template‑driven output into **Views**, so you can render a templated column in a listing. |

For example:

```bash
drush en inline_formatter_display -y
```

Each submodule requires the base Inline Formatter Field module, which is already
present once you have installed it above.

## Verify it worked

Add an **Inline Formatter** field to a content type, then open that type's
**Manage display** tab. You should see the field with an in‑browser code editor
for entering HTML or Twig. You can also confirm the global settings form loads at
**Configuration → Inline Formatter Field Settings**
(`/admin/config/inline_formatter_field/settings`) — see
[Configuration](../configuration/index.md) for what lives there.
