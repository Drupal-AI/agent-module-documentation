# Autocreate Access — manual setup guide

**Autocreate Access** (`autocreate_access`) closes a small authorization gap in
Drupal's entity‑reference autocomplete widgets. When a reference field is
configured to let editors create a new referenced entity on the fly (the
"create new" option that appears as you type a name that doesn't exist yet), core
offers that option based on the field's settings — not on whether the current user
is actually allowed to *create* that kind of entity. Autocreate Access adds the
missing check: it makes the widget respect **entity CREATE access**, so the
"create new" option is only offered to users who genuinely have permission to
create the target entity type.

This is a **security‑positive** change with no downside for legitimate users. It
layers on top of Drupal's existing entity access system rather than replacing it,
and it has no negative effect on access — users who could already create the target
entity keep the create‑on‑the‑fly option; users who could not simply stop being
offered something they were never allowed to do.

There is nothing to configure. The module has no settings page, no permissions of
its own, and no admin menu item — its effect is behavioral. Enable it on any site
where reference autocomplete fields allow creating new entities inline, and it
applies automatically.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [How to use it](#how-to-use-it) — what happens once it's on.

## Where it lives in the admin menu

Nothing. The module adds no admin menu item and no settings form; its behavior is
automatic once enabled.

## How to use it

Just enable it. From that point on, any entity‑reference autocomplete field that
allows inline creation of new entities will only show the "create new" option to
users who hold **create** permission for that entity type. There is nothing to
switch on per field and no configuration to maintain.
