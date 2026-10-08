# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Taxonomy** (`taxonomy`) and **Text** (`text`) modules.
- The **jQuery UI Dialog** module (`jquery_ui_dialog`, version `^2`), used for the
  default modal‑dialog presentation. Composer pulls this in automatically.

There are no other third‑party PHP library requirements. If you plan to use the
Tippy.js tooltip submodule, that presentation is handled by the
`term_glossary_tippy` submodule below.

## Install with Composer

From the project root:

```bash
composer require drupal/term_glossary -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — this is what brings in the jQuery UI Dialog module. The
Composer package name (`drupal/term_glossary`) matches the module's machine name
(`term_glossary`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/term_glossary -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en term_glossary -y
```

## Submodules — enable only the presentation you want

The base module gives you the default jQuery UI dialog. Three optional submodules
offer alternatives — enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Abbreviations** | `term_glossary_abbr` | Renders matched terms as HTML `<abbr>` elements with the definition as the expansion — good for accessible acronym handling. |
| **Tippy tooltips** | `term_glossary_tippy` | Shows the definition in a Tippy.js tooltip instead of a modal dialog. |
| **Per‑node control** | `term_glossary_per_node` | Adds a per‑node option so editors can turn glossary processing on or off for individual pieces of content. |

For example, to use Tippy.js tooltips:

```bash
drush en term_glossary_tippy -y
```

Each submodule requires the base Term Glossary module, which is already present
once you have installed it above.

## Next step

Enabling the module does not highlight anything yet. Continue to
[Configuration](../configuration/index.md) to choose your glossary vocabularies
and enable scanning on the fields you want. Also review the security note in the
[main guide](../index.md) before enabling this on a site with non‑public
taxonomy.
