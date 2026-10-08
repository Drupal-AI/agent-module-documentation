# Assignments — manual setup guide

**Assignments** (`assignments`) adds a dedicated **Assignment** content entity to
your site — a first‑class, fieldable record type for modelling things like tasks,
allocations, or coursework. Rather than bending nodes to fit, you get a purpose‑
built entity with its own **Assignment‑type bundles**, its own published /
unpublished states, and its own Views data so you can list and filter assignments.

Think of it as the foundation for an "assignments" feature. You define one or more
Assignment types (bundles), add fields to them, and create Assignment records
against those types. Because the entity exposes Views data, you can build listings,
dashboards, and reports of assignments the same way you would for any content
entity. It is also the **base module that extensions build on** — for example,
[Assignments Hootsuite](../../assignments_hootsuite/4.3.x/human-docs/index.md)
adds social‑posting on top of it.

Access is handled through a standard set of entity permissions, so you control
precisely who can work with assignments. It has no external integrations of its
own and supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

After enabling the module, set up your Assignment **types** (bundles) and add
whatever fields each type needs, then create Assignment records against them and
build Views to list them. Assignments support **published / unpublished** states,
so you can keep drafts hidden until ready.

Access is controlled by a set of entity permissions you grant under
**People → Permissions** (`/admin/people/permissions`):

- **Add / Edit / Delete assignment entities** — day‑to‑day authoring rights.
- **Administer assignment entities** — full administrative control, including
  managing assignment types. Grant this to trusted roles only.
- **View published assignment entities** and **View unpublished assignment
  entities** — these are separate, so you can let a role see published assignments
  without exposing drafts. Keep "view unpublished" restricted to trusted roles.
