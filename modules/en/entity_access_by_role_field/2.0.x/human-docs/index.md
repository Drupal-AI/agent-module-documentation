# Entity Access by Role Field — manual setup guide

**Entity Access by Role Field** (`entity_access_by_role_field`) adds a field type
that lets editors allow or deny access to *each individual entity* for chosen user
roles. Instead of writing a custom node‑access module, you attach an **"Entity
Access by Role"** field to a content type (or any fieldable entity — taxonomy term,
media, user, and so on), and each entity then carries its own list of roles plus a
choice of whether those roles are **allowed** or **forbidden**.

At runtime the module enforces the decision through Drupal's entity access system:
it compares the roles selected on the entity with the current user's roles. An
"allowed" field grants access to matching roles and blocks everyone else; a
"forbidden" field does the reverse. Per field instance you decide which operations
it governs — **view**, **edit**, **delete** — and what happens when no role is
chosen. Unpublished entities are handled specially: a view request on an unpublished
entity is checked as a "view unpublished" operation.

A single restricted permission, **bypass entity_access_by_role_field permissions**,
lets trusted roles skip all of this logic. The module has no third‑party
dependencies and is a maintained, field‑based successor to the older Entity Access
by Role module.

**Important limitation:** the module enforces access only on the canonical entity
operations. It deliberately does **not** filter Views or other listing queries, so
titles or labels of restricted entities can still appear in listings. Plan your
Views and menus accordingly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — add the field to a bundle, set its
   per‑instance options, and understand how access is decided.

## Where it lives in the admin menu

There is no central settings page. You work with it on each entity type's **Manage
fields** screen (where you add and configure the field) and on individual entities
when you edit them. The one permission is under **People → Permissions**.

## How to use it

Add an "Entity Access by Role" field to the bundle you want to protect, configure
which operations it governs and its empty‑field fallback, then — when editing an
entity — pick the roles and whether they are allowed or restricted. The step‑by‑step
is in [Configuration](configuration/index.md).
