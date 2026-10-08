# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Node** and **Block** modules (standard on most sites) — the feedback
  prompt is a block shown on node pages.
- No other contrib dependencies and no extra PHP libraries. In particular, unlike
  heavier voting modules, it does **not** require Voting API.

Note: this project is **not covered by Drupal's security advisory policy**. Take
that into account when deciding whether to run it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_feedback -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_feedback -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_feedback -y
```

Enabling the module creates its `simple_feedback` database table, where votes are
stored. There is no settings form.

## Place the block

Go to **Structure → Block layout** (`/admin/structure/block`), click **Place
block** in your chosen region, and add the **Simple Feedback** block. Use the
block's visibility settings to limit it to the content types where a "was this
helpful?" prompt belongs.

## A note before you rely on the data

Both the voting and the tally endpoints use the core **Access content**
permission, so anonymous visitors can vote. Deduplication is per node and client
IP, which curbs casual repeat voting. Treat the results as a soft signal of
content usefulness rather than authoritative analytics.

## Verify it worked

Visit a node where you placed the block. You should see "Was this article helpful?
Yes | No". Click one — you should get a short acknowledgement, and a row should
appear in the `simple_feedback` table.
