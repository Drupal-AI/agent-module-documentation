# Annotations — manual setup guide

**Annotations** (`annotations`) is the base module of the Annotations suite. It provides
the shared foundation the rest of the suite builds on: annotation **entities**, annotation
**targets**, and annotation **types**, plus a permission model for administering and
collecting them. In practice it lets a site attach structured notes — annotations — to
content and manage those notes as first-class entities.

Because it is the suite's base module, its job is mostly to define the building blocks and
the permissions that govern them, rather than to present a single settings screen. It
depends on core's **Views** module (so annotations can be listed) and requires Drupal
11.2 or newer.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable
   it.

## How to use it

Enable the module (and the other Annotations suite modules you need), then grant the
appropriate permissions on **People → Permissions**. The suite separates administration
from day-to-day use:

- **Administration** — `administer annotations`, plus `administer annotation targets` and
  `administer annotation types` for managing the target and type definitions.
- **Collection and editing** — `access annotation collection` lets a role work with the
  annotation collection, while `edit any annotation` and `delete any annotation` grant
  broad editing rights.

> **Grant the broad permissions carefully.** `edit any annotation` and
> `delete any annotation` let a user change or remove *anyone's* annotations — give them
> only to trusted roles.

With the entities and permissions in place, annotations can be listed and worked with
through Views, supporting editorial-notes and content-annotation workflows across the
suite.
