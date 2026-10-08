# Team Setup — manual setup guide

**Team Setup** (`team_setup`) is a lightweight team‑management system for Drupal.
It lets administrators create teams, give each one a name and description, assign
existing Drupal users as members, and manage that membership from a dedicated
admin screen — all without building a custom system or reaching for a large
framework. It is aimed at organisations that just need to group people into
internal teams, departments or working groups.

Everything happens through an administrative interface: a team listing page where
you add, edit and delete teams, autocomplete for finding and selecting users to
add as members, and AJAX‑powered modal dialogs for the add / edit / delete
workflows so you stay on the same page. Team records and their member
relationships are stored in the module's own database tables, kept separate from
Drupal's user accounts and roles — so Team Setup sits alongside Drupal's own
permission system rather than replacing it.

The module depends only on Drupal core (it uses the Form, Database, routing,
permissions, AJAX and library APIs) and supports Drupal 10, 11 and 12. It provides
its own permissions for controlling who can view and who can administer teams.
There is no separate settings form — after enabling, the one thing you must do is
assign those permissions, then you manage teams from the listing page.

This guide is written for a **human** working through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and assign permissions.

## How to use it

**First, set permissions.** After enabling the module, go to **People →
Permissions** and grant the Team Setup permissions to the right roles — the module
distinguishes between *accessing* team setup and *administering* it, so give full
management access only to trusted administrative roles.

**Then manage teams.** Open the team setup listing page to see existing teams.
From there you can:

- **Add a team** — enter a team name and description, and assign users as members
  using the autocomplete search.
- **Edit a team** — update its name, description, or membership at any time.
- **Remove members** — take members off a team with the AJAX‑based actions, and
  view the current members dynamically.
- **Delete a team** — remove a team record entirely.

The add, edit and delete actions open in modal dialogs so you can manage everything
from the listing without navigating away. No content type or text‑format setup is
required, though you can control how team descriptions are entered and displayed if
you want to.
