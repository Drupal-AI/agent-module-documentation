# Installation

## Requirements

- **Drupal 10 or 11**, **PHP 8.1+**.
- Core's **Taxonomy** module (`taxonomy`).
- **Term Merge 2.x** (`term_merge`) — this performs the actual merge and defines
  the **merge taxonomy terms** permission that Fuzzy Term Merge relies on.
- **Drush** (optional) — only needed for the `ftm-tfd` command‑line audit.

This release is a `1.0.0-alpha3` and is not covered by security advisories — test
it on a non‑production copy before using it on a live site.

## Install with Composer

From the project root:

```bash
composer require drupal/fuzzy_term_merge -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Term Merge and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/fuzzy_term_merge -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it alongside Term Merge:

```bash
drush en term_merge fuzzy_term_merge -y
```

Then grant the **merge taxonomy terms** permission to the roles that should be
allowed to merge terms, at **People → Permissions**. Keep this limited — merging
is permanent and rewrites content references.

## Verify it worked

Go to **Structure → Taxonomy** and open any vocabulary. You should see a **Fuzzy
merge** tab on the vocabulary's admin page. Open it, run an analysis, and confirm
that candidate duplicate pairs are listed with their similarity scores.

> **Before your first real merge, back up the database.** Merges cannot be undone.
