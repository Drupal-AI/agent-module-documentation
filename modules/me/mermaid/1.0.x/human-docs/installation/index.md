# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- No third‑party Composer packages and no external PHP libraries — the Mermaid
  JavaScript library ships with the module.

This is an alpha release (1.0.0-alpha4), so pin your version deliberately and test
before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/mermaid -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mermaid -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module (which registers the Mermaid library):

```bash
drush en mermaid -y
```

## Submodules — enable what you need

The base module has no visible feature on its own. Enable the submodule that matches
your use case:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Mermaid Filter** | `mermaid_filter` | A text-format filter that renders `[mermaid]...[/mermaid]` blocks inside formatted fields. Enable it only on text formats used by trusted authors. |
| **Mermaid GraphAPI** | `mermaid_graphapi` | Programmatic generation of entity relationship diagrams (`erDiagram`) and flowcharts via GraphAPI, for developers. |

For example, to add the author-facing filter:

```bash
drush en mermaid_filter -y
```

Each submodule requires the base `mermaid` module, which is already present once you
have installed it above.

## Verify it worked

If you enabled **Mermaid Filter**, add it to a text format (see the base guide's
"How to use it"), then create a piece of content with a `[mermaid]` block and view
it — the text should be replaced by a rendered diagram. If the raw text still shows,
re-check that the filter is enabled on the format the field uses and clear caches
with `drush cr`.
