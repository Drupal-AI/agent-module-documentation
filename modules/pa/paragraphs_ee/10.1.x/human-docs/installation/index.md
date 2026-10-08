# Installation

## Requirements

- **Drupal core 11.3** (`core_version_requirement: ^11.3`).
- The **Paragraphs Features** module (`drupal/paragraphs_features` `^2.0`) — Composer
  installs it. It in turn requires the **Paragraphs** module, so Paragraphs comes along
  too.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_ee -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Paragraphs Features and
Paragraphs along with any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/paragraphs_ee -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_ee -y
```

Drupal enables Paragraphs Features and Paragraphs automatically as dependencies.
Remember that the enhanced dialog only appears once a Paragraphs field widget's **Add
mode** is set to **Modal form** — see the [overview](../index.md#how-to-use-it) for the
full setup.

## Submodule — enable only if you need it

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Paragraphs EE Sets** | `paragraphs_ee_sets` | Integrates the Paragraphs Sets feature so predefined sets of paragraphs appear in the same enhanced add dialog. |

```bash
drush en paragraphs_ee_sets -y
```

It requires the base Paragraphs Editor Enhancements module, which is already present
once you've installed it above.
