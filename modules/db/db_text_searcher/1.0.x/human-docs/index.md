# Database Text Searcher — manual setup guide

**Database Text Searcher** (`db_text_searcher`) is a developer/CLI tool that lets
you search for a piece of text across your entire Drupal database from the command
line. Normally, finding *where* a particular string lives — which table, which
column, which record references a value — means writing a throwaway module or
hand-crafting SQL. This module turns that into a single Drush command.

It performs partial (substring) matches across most database tables,
automatically skipping system and cache-related tables so the search stays fast
and relevant. Each result tells you the table name, the column name, the row's
primary key, and the matched value, and for some tables it can resolve the
matching row back to a Drupal entity URL so you can jump straight to it. Results
can be printed to the console for immediate review or saved to a timestamped CSV
file for later. It handles different character sets and encodings so matches stay
accurate across varied textual data.

Because it reads across the whole database, this is a **developer/advanced tool**
— reach for it when debugging, auditing content, or hunting down where a stray
value came from, not as an end-user search feature. It depends on the **Embed**
module and provides its own permission, so keep it in the hands of trusted
developers. It has no configuration form: you use it entirely from Drush.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, pull in the
   Embed dependency, and enable the module.

There is **no configuration page** for this module — it has no settings form. You
run it from the command line, as described below.

## How to use it

Once the module is enabled, run its Drush command from your project root, passing
the text you want to find. The command scans the eligible tables and reports each
match with its table, column, primary key, and value, and can write the results to
a timestamped CSV file. Run `drush list` (or the command's `--help`) to see the
exact command name and options available in your installed version.

Because the search touches most tables, run it deliberately and mind the output on
large databases. It is a CLI utility for developers, so it lives with your other
Drush workflows rather than in the admin UI.
