# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Several **contributed modules**, which Composer pulls in for you:
  - [Paragraphs](https://www.drupal.org/project/paragraphs) (`paragraphs`)
  - [Entity Reference Revisions](https://www.drupal.org/project/entity_reference_revisions)
    (`entity_reference_revisions`)
  - [Views Reference Field](https://www.drupal.org/project/viewsreference)
    (`viewsreference`) — powers the "View" bundle.
  - [Field Group](https://www.drupal.org/project/field_group) (`field_group`) —
    powers the collapsible "Styles" group on the edit form.
- A number of **core modules** (Block, Field, File, Filter, Image, Link, Options,
  System, Text, User, Views), all enabled automatically as dependencies.
- **Bootstrap 5 CSS/JS from your theme.** The module supplies only its own
  component styles; the Bootstrap framework itself must come from your front‑end
  theme or a CDN include.

Because the module's configuration ships as *optional* config, each bundle only
installs when its dependencies are present — so getting the modules above in place
first matters.

## Install with Composer

From the project root:

```bash
composer require drupal/bootstrap_paragraphs -W
```

The `-W` (`--with-all-dependencies`) flag is important here: it lets Composer pull
in Paragraphs, Entity Reference Revisions, Views Reference Field, and Field Group
along with the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bootstrap_paragraphs -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bootstrap_paragraphs -y
```

Or enable **Bootstrap Paragraphs** on the **Extend** page (`/admin/modules`), which
will prompt you to enable its dependencies too.

After enabling, confirm the paragraph types installed at **Structure → Paragraphs
types** (`/admin/structure/paragraphs_type`), then wire a Paragraphs field into a
content type — see [How to use it](../index.md#how-to-use-it).

## Optional submodules

Bootstrap Paragraphs ships seven submodules, each adding more bundles on the same
pattern. Enable only the ones you need:

| Submodule | Machine name | Adds |
|-----------|--------------|------|
| **BP Callout** | `bp_callout` | A callout/highlight block. |
| **BP Card** | `bp_card` | A Bootstrap card block. |
| **BP Contact** | `bp_contact` | A contact block. |
| **BP Media** | `bp_media` | A media‑based block (needs core Media). |
| **BP Quicklinks** | `bp_quicklinks` | A quick‑links block. |
| **BP Statistics** | `bp_statistics` | A statistics/counters block. |
| **BP Webform** | `bp_webform` | Embeds a Webform (needs the Webform module). |

For example:

```bash
drush en bp_card bp_media -y
```

Each submodule follows the same config‑and‑Twig approach as the base module.
