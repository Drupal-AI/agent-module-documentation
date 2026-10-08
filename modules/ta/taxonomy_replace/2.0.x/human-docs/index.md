# Taxonomy Replace — manual setup guide

**Taxonomy Replace** (`taxonomy_replace`) lets you replace every node reference to one
taxonomy term with references to one or more other terms in the same vocabulary — and
then deletes the original term. It is the tool you reach for when cleaning up a
vocabulary: merging a duplicate, fixing a misspelled term, or consolidating several
near-identical tags into one canonical term without orphaning the content that used
the old one.

It works by adding a **Replace** tab (and a **Replace** operation link) to each
taxonomy term, at `/taxonomy/term/{taxonomy_term}/replace`. Opening it shows a
confirm-and-delete form that lists exactly which nodes will be updated and offers an
autocomplete — restricted to the same vocabulary — where you pick the replacement
term or terms (you may enter more than one). On submit, the module finds every
affected node, adds the new term reference(s) to the right field (skipping any the
node already has), removes the old term, saves each node, logs the change, deletes the
old term, and redirects you to the first replacement term.

The action is properly gated: you need the **replace taxonomy terms** permission *and*
**delete** access to that specific term, and the operation link only appears when both
hold. Its database queries use bound parameters (no raw SQL), so it is safe in that
respect. But it is **destructive by design** — it edits and re-saves every affected
node and deletes the source term — so run it deliberately, ideally after a backup or
on a copy first. It depends only on core Taxonomy.

There is no settings page to configure — the tool lives on the term forms themselves.
This module is minimally maintained; a Drush command exists for scripted replacements
but has a known argument bug in this branch (see below), so prefer the UI.

This guide is written for a **human** using the admin UI. If you are an AI coding
agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

1. Make sure your user has the **replace taxonomy terms** permission and permission to
   **delete** the term you want to replace.
2. Open the term you want to get rid of — via **Structure → Taxonomy →** your
   vocabulary, then the term's **Replace** tab or its **Replace** operation, or go
   straight to `/taxonomy/term/{tid}/replace`.
3. The form lists the nodes that will be updated and offers an autocomplete limited to
   the same vocabulary. Choose the replacement term (or several — comma-separated).
   You cannot pick the term as its own replacement.
4. Confirm. The module updates each affected node, reports how many references
   changed, **deletes the old term**, and redirects you to the first replacement.

### Scripting with Drush (use with care)

A Drush command is registered for scripted replacements:

```bash
drush taxonomy:replace <oldTid> <newTid>
drush taxonomy:replace <oldTid> <newTid> --delete
```

It reports the affected node count and asks for confirmation; `--delete` removes the
old term after updating nodes. **Caveat:** in this branch the command has a known
argument bug and can error, so prefer the UI, or verify on a copy of your site before
scripting bulk replacements.
