# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Core's **Node**, **Taxonomy**, and **Block** modules — all standard in Drupal
  and enabled automatically as dependencies.
- Your content needs taxonomy tagging for the matching to have anything to work
  with: nodes must reference terms via a taxonomy field for relevance to be
  calculated.
- No third‑party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/relevant_content -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/relevant_content -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en relevant_content -y
```

## Verify it worked

Grant the **administer relevant content** permission to your administrator role,
then go to **Configuration → Search → Relevant Content** and confirm you can add a
preset. Create one, place its block on a node page (see "How to use it" in the
[overview](../index.md)), and view a tagged node — you should see a list of related
nodes that share its terms.
