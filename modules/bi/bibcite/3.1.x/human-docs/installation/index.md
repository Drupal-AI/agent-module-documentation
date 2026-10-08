# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- Core's **Serialization** module (`serialization`) enabled — Drupal treats it as
  a dependency.
- The contributed **Entity API** (`drupal/entity`) and **Token** (`drupal/token`)
  modules, pulled in by Composer.
- Several third‑party PHP libraries, all installed by Composer when you require the
  module:
  - `seboettg/citeproc-php` — renders citations from CSL styles (the heart of the
    module).
  - `adci/full-name-parser` — splits author names into parts.
  - `renanbr/bibtex-parser`, `caseyamcl/php-marc21`, `researchgate/libris` — used
    by the import/export format submodules.

Because of those library dependencies, install the suite **with Composer** rather
than downloading it manually.

## Install with Composer

From the project root:

```bash
composer require drupal/bibcite -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install all of the required
libraries and contrib dependencies and update shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bibcite -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the core module

```bash
drush en bibcite -y
```

## Enable the submodules you need

The core module is just the citation engine — enable submodules for real
functionality. Turn on only what you need:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Bibcite Entity** | `bibcite_entity` | The Reference and Contributor entities and their listing/display pages — enable this to actually store publications. |
| **Bibcite Import** | `bibcite_import` | Bulk import of references from files. |
| **Bibcite Export** | `bibcite_export` | Bulk export of references to files. |
| **Bibcite BibTeX** | `bibcite_bibtex` | The BibTeX (`.bib`) import/export format. |
| **Bibcite EndNote** | `bibcite_endnote` | The EndNote (tagged/XML) formats. |
| **Bibcite MARC** | `bibcite_marc` | The MARC format. |
| **Bibcite RIS** | `bibcite_ris` | The RIS format. |

For example, a typical bibliography site that imports BibTeX would enable:

```bash
drush en bibcite_entity bibcite_import bibcite_export bibcite_bibtex -y
```

## Optional companion projects

Beyond the bundled submodules, these separate projects are commonly paired with
Bibcite: **Bibcite CrossRef** (DOI lookup), **Bibcite PubMed** (PubMed import),
**Bibcite Altmetric** (Altmetric badges), and **Bibcite Migrate** (import from the
old Biblio module). Require them with Composer the same way if you need them.

## Next steps

Head to [Configuration](../configuration/index.md) to choose your default citation
style and manage CSL styles.
