# Entity Association — manual setup guide

**Entity Association** (`association`) gives you a structured way to relate
entities to one another — beyond a plain entity‑reference field. You define
*associations* with configurable behaviors, and from those associations the
module can drive landing pages and contextual navigation. The idea is to express
relationships (grouping, linking, "see also" contexts) as first‑class,
manageable things rather than scattering reference fields across content types.

Because it is a content‑building tool, what it does on a given site depends on
the associations and behaviors you define. On its own it adds the configuration
and an overview page for managing associations; the value comes from the
relationships you set up. It depends on core's **Node** module plus the contrib
**Token** and **Toolshed** modules, and runs on Drupal 10.2+ and 11.

This module is at an early (alpha) stage, so treat it as evolving infrastructure
rather than a finished, polished feature.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   pull in its dependencies, and enable it.

## Where it lives in the admin menu

Entity Association is administered through an **association overview page** and a
set of association configurations. Two permissions gate this:

- **Administer entity association configurations** — lets a user define and
  change associations and their behaviors.
- **Access entity association overview page** — lets a user reach the overview
  where existing associations are listed and managed.

Grant those permissions at **People → Permissions** only to trusted roles.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. As a user with **Administer entity association configurations**, define the
   associations you need — each with its behavior and the entities it relates.
3. Use the overview page to manage those associations, and let the module surface
   the resulting landing pages and contextual navigation on your site.

The exact fields and behaviors available depend on the alpha release you install;
the sibling [`agent/`](../agent/start.md) docs track the machine‑level detail.
