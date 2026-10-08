# Organic Groups — manual setup guide

**Organic Groups** (`og`) turns any content type (or other entity bundle) into a
**group**, and any other bundle into **group content** that belongs to groups.
Each group gets its own **members**, its own **roles**, and its own
**permissions** — layered on top of Drupal's normal global role system. It's the
foundation for team spaces, multi‑tenant intranets, clubs, courses, projects, or
any "this content belongs to that group, and only its members can do X here"
scenario.

The key ideas are three. A **group** is a bundle you've marked as a group (say a
*Team* content type). **Group content** is a bundle that carries an *OG audience
field* pointing at a group (say *Pages* that belong to a team). And a
**membership** is not a plain reference but a full entity — `og_membership` —
linking a *user* to a group, with a **state** (active, pending, or blocked) and a
set of **OG roles**. Because membership is its own entity, one user can hold
different roles in different groups (an admin of one team, an ordinary member of
another), and you can even add custom fields to memberships (join date, expiry,
notes).

Organic Groups is primarily an **API module** — its point‑and‑click admin UI lives
in the bundled **og_ui** submodule, which you'll almost always want enabled.
Marking a bundle as a group, or attaching an audience field, is otherwise done in
code or config. On its own the base module provides no settings page (its
`configure` route is null); the settings form is supplied by og_ui. OG depends only
on core's Options, Text, Field and User modules, and it is deeply extensible via
three plugin types and several events.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable OG and
   the og_ui submodule.
2. [Configuration](configuration/index.md) — mark a bundle as a group, make another
   bundle group content, manage roles/permissions and memberships, and tune the
   site‑wide OG settings.

## Where it lives in the admin menu

With **og_ui** enabled, the main pages are under **Configuration → Group**:

- **Settings** — `/admin/config/group/settings` (site‑wide OG behaviour).
- **Permissions** — `/admin/config/group/permissions` (group‑level permissions per
  role).
- **Roles** — `/admin/config/group/roles`.
- **Membership types** — `/admin/structure/membership-types`.

Each individual group also gets its own admin tabs at
`/group/{entity_type}/{group}/admin/…` for managing that group's members. The one
global permission, **Administer Organic groups**, is on **People → Permissions**.

## How to use it

The core flow is: mark a content type as a *group*, mark another as *group content*
by adding a group audience field, then let users join groups (subscribe) and assign
them roles within each group. Members' abilities inside a group are governed by
**group‑level permissions** attached to their **OG roles**, entirely separate from
their site‑wide role. See [Configuration](configuration/index.md) for the
walkthrough.
