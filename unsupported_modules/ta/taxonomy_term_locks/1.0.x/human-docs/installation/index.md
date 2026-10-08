# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Taxonomy** module (any site with vocabularies already has it). There are no
  other module or PHP library dependencies.

Note this project is **not covered by Drupal's security advisory policy**, and its
protection is a UI-level guardrail rather than a true access boundary (see the
[main guide](../index.md) for what that means) — factor both in before relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_term_locks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taxonomy_term_locks -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_term_locks -y
```

## Set the two permissions

Go to **People → Permissions** (`/admin/people/permissions`) and assign the module's
two permissions:

| Permission | What it allows |
|------------|----------------|
| `set taxonomy term lock` | Add or remove the lock on a term (see the **Locked** checkbox on the term form). |
| `bypass taxonomy term lock` | Still edit or delete locked terms, and see their operations links. Reserve this for trusted roles. |

## Verify it worked

Edit a taxonomy term as a user with **set taxonomy term lock** — you should see a
**Locked** checkbox on the form. Lock a term, then view the taxonomy overview as a user
*without* **bypass taxonomy term lock**: that term's edit/delete operations should no
longer appear.
