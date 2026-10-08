# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- The contributed **Checklist API** module (`drupal/checklistapi` `^2.1`), which
  powers the compliance checklist — Drupal treats it as a dependency.
- Several other contrib modules and PHP libraries, installed by Composer when you
  require the module:
  - `drupal/entity`, `drupal/entity_reference_revisions`, `drupal/message`,
    `drupal/token` — used by the submodules.
  - `fakerphp/faker` — generates fake values for anonymization.
- Optional, depending on which submodules you use:
  - **Drush** — required by the **GDPR Dump** submodule's command.
  - The PHP **zip** extension (`ext-zip`) — required by **GDPR Tasks**.

Because of these dependencies, install the suite **with Composer** rather than
downloading it by hand.

## Install with Composer

From the project root:

```bash
composer require drupal/gdpr -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Checklist API, the
other contrib dependencies, and the required PHP libraries, updating shared packages
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/gdpr -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the base module

```bash
drush en gdpr -y
```

Checklist API is enabled automatically as a dependency.

## Enable the submodules you need

The base module is a checklist and glue — the working features are in the
submodules. Enable the ones that match your compliance needs:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **GDPR Fields** | `gdpr_fields` | Mark entity fields as personal data and set their Right‑to‑Access / Right‑to‑be‑Forgotten handling. |
| **Anonymizer** | `anonymizer` | The plugin system that anonymizes personal values (used by fields/tasks). |
| **GDPR Consent** | `gdpr_consent` | Versioned consent agreements and a consent field. |
| **GDPR Tasks** | `gdpr_tasks` | The Subject Access Request and Right‑to‑be‑Forgotten task workflow (needs the PHP zip extension). |
| **GDPR Dump** | `gdpr_dump` | A Drush command producing anonymized SQL dumps (needs Drush). |

For example, to set up consent tracking plus the subject‑request workflow:

```bash
drush en gdpr_fields anonymizer gdpr_consent gdpr_tasks -y
```

Each submodule requires the base GDPR module, which is already present once you've
installed it above.

## Next steps

Head to [Configuration](../configuration/index.md) to work through the checklist and
record your policy page URLs, then configure the submodules you enabled.
