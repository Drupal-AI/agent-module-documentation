# Persistent Identifiers — manual setup guide

**Persistent Identifiers** (`persistent_identifiers`) is a **framework** for
minting and persisting stable, citable identifiers — such as **DOIs**, **ARKs**,
and **Handles** — for Drupal nodes. Instead of every project reinventing the same
plumbing, this module supplies the common parts (a *Mint Identifier* button on
the node edit form, a permission that controls who may mint, and the logic that
saves an identifier onto an entity) and leaves the provider‑specific details to
small companion modules.

Those details are split into two kinds of pluggable services. A **minter**
creates the identifier by talking to a registration authority — for example
CrossRef, DataCite, or EZID — while a **persister** decides where the resulting
value is stored on the node (the bundled option writes it to a generic text
field). A site administrator picks which minter and persister to use, mixing and
matching as needed, and developers only have to write a small service to add a
new provider. Minters that ship as separate modules include a Handle minter, a
DataCite DOI minter, and an EZID ARK minter.

Because it is a framework, Persistent Identifiers has no content or access role
of its own beyond the *Mint persistent identifiers* permission — the actual
credentials and provider options are supplied by whichever minter module you
install. Its original use case was assigning persistent identifiers to Islandora
objects, but it works perfectly well without Islandora, and it is the base that
other modules (such as `pid_field_set`) build upon.

> **Heads‑up:** this project is **minimally maintained** (maintenance fixes only)
> and is **not covered by Drupal's security advisory policy**. Weigh that before
> relying on it for a production repository.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the framework with Composer,
   enable it, and add the minter module(s) you need.
2. [Configuration](configuration/index.md) — grant the mint permission and set
   the framework and minter options.

## Where it lives in the admin menu

The framework's settings form is at **Configuration → Persistent Identifiers →
Settings** (`/admin/config/persistent_identifiers/settings`). The exact options
you see there depend on which minter you have enabled — each minter adds its own
fields to that form. Minting itself happens on a node: users with the *Mint
persistent identifiers* permission get a control at the bottom of the node
add/edit form.
