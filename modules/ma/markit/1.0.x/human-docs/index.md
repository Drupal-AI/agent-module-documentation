# MarkIt — manual setup guide

**MarkIt** (`markit`) is a flagging system for Drupal — a lighter alternative to the
[Flag](https://www.drupal.org/project/flag) module for cases where you want a simple
way to let users **mark and unmark** entities. Think "viewed", "started", "read",
"ranked", "completed", "bookmarked", "favorited", or "followed": you define the kinds
of marking you need, choose which entity bundles can be marked with each, and MarkIt
records who marked what. Each mark is stored as an entity.

Beyond the marks themselves, MarkIt exposes a small set of HTTP endpoints so a theme
or front‑end can mark and unmark entities and read totals — for example how many
times a node has been marked "viewed", or which users marked it. These endpoints do
not require the core REST module to be enabled (though enabling REST can change some
responses).

Access is controlled by permissions: an administration permission, a marking
permission, an unmarking permission, and per‑type permission callbacks — so you can,
say, allow users to mark a node as "viewed" but not to unmark it. MarkIt supports
Drupal 10.2 and later, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create your mark types, enable them per
   entity bundle, choose the allowed actions, and set permissions.

## Where it lives in the admin menu

- **Mark types:** **Structure → MarkIt** — create and manage the kinds of marking.
- **Enable per bundle & actions:** **User Interface → MarkIt** — choose which entity
  bundles can be marked and which actions are allowed for each.
- **Permissions:** **People → Permissions** (`/admin/people/permissions`).

## How to use the endpoints

Once mark types are configured, a front‑end can call MarkIt's endpoints. A few
examples (mark/unmark are `POST` and need a CSRF token, which you fetch with a `GET`
to `/session/token`):

- **Mark** an entity: `POST /markit/mark/{markit_type}/{entity_type}/{id}` — returns
  the new count for that type.
- **Mark with a score:** `POST /markit/mark/{markit_type}/{entity_type}/{id}/{score}`.
- **Unmark:** `POST /markit/unmark/{markit_type}/{entity_type}/{id}`.
- **All totals for an entity:** `GET /markit/marks/count/{entity_type}/{id}`.
- **Totals for one type:** `GET /markit/marks/count/{entity_type}/{id}/{markit_type}`.
- **Users who marked an entity:**
  `GET /markit/users/mark/{entity_type}/{id}/{markit_type}/{user_load}`.

If a bundle is not configured to support the requested mark type, the endpoint
returns **403 Access Denied**.
