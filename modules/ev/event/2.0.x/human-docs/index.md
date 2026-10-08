# Event — manual setup guide

**Event** (`event`) provides a dedicated **Event entity type** for managing events on
your Drupal site. Instead of repurposing nodes for events, you get a first-class
content entity built for the job, with dates handled by core's **Datetime Range**
module. It is part of the ecosystem around the Conference Organizing Distribution and
gives other modules a common data format to share.

Events created with this module are ordinary content entities: who can create, edit,
or delete them is governed by the entity's own access system and the permissions the
module provides. There is nothing exotic to learn — if you are comfortable with
Drupal content entities and fields, you already know how to work with events here.

Version 2 of this project split the old Group-related pieces into their own projects
— **Event Group** (managing group attendees) and **Group Events** (managing
ownership/access via group membership) — so the base Event module stays focused on
the entity itself.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (Datetime Range comes along automatically).

There is **no dedicated settings form** for this module. You manage it the way you
manage any content entity type — see "How to use it" below.

## Where it lives in the admin menu

Event does not add a single settings page. Once enabled you work with it through the
standard content and structure areas: create and manage events under **Content**, and
adjust the entity's fields, form display, and display through the Field UI. Access is
controlled by the permissions the module provides, on the **People → Permissions**
page (`/admin/people/permissions`).

## How to use it

1. After enabling the module, review the **event** permissions at **People →
   Permissions** and grant create/edit/delete rights to the appropriate roles — this
   is how you gate who can manage events.
2. Add or adjust fields on the Event entity through the Field UI if you need more than
   the built-in date and management fields. Dates are provided by core's Datetime
   Range.
3. Create events from the **Content** area and manage them like any other content.
4. The module also ships example Views you can adapt to list and display your events.

> **Composer tip:** always install and update this module with the
> `--with-all-dependencies` (`-W`) flag. The module relies on a core machine-name
> patch being applied during the Composer run; without `-W` that patch may not be
> applied.
