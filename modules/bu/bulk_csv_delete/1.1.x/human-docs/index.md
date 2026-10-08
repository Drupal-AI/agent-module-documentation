# Bulk CSV Delete — manual setup guide

**Bulk CSV Delete** (`bulk_csv_delete`) provides a **Drush command** that
bulk-deletes entities listed in a CSV file. You give it a CSV of entity ids and
it deletes them in efficient batches — a command-line tool for large-scale
clean-up, in the Administration package.

There is deliberately **no web route and no admin page**: the module is usable
only by someone with shell/Drush access, who is already a fully trusted operator.
That is also why it does not perform a per-entity delete-access check — it calls
the storage delete directly on the ids you give it. For a CLI admin tool that is
normal (command-line access already implies full privilege), but it makes the
command a **blunt instrument**: it will delete whatever ids are in the CSV, with
no undo.

Because of that, the practical advice is simple: **back up first, and
double-check the CSV and the entity type before you run it.** And do not try to
wrap this in a web-exposed form without first adding a permission and per-entity
access checks — the module has no web-facing access controls of its own. It
supports Drupal 10 and 11.

This guide is written for a **human** running the command from the CLI. If you
want a terse, token-cheap reference for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere — this module has no admin UI and no web route. It is driven entirely
through its Drush command.

## How to use it

1. Install and enable `bulk_csv_delete` (see
   [Installation](installation/index.md)).
2. Prepare a CSV file listing the ids of the entities you want to delete, and
   confirm the entity type is correct.
3. **Back up your database first** — there is no undo.
4. Run the module's Drush command, pointing it at your CSV. The listed entities
   are deleted in batches.

Because the command deletes exactly the ids you supply with no access check,
treat generating and verifying the CSV as the safety-critical step.
