# LocalGov Replicate — manual setup guide

**LocalGov Replicate** (`localgov_replicate`) lets editors **clone** content on a
**LocalGov Drupal** site. It is a thin integration layer that wires the contrib
**Replicate** and **Replicate UI** modules into the LocalGov way of doing things: it
relabels the clone action to **Clone** (instead of "Replicate") for a consistent
editor experience, and it grants the clone permission to the appropriate LocalGov
roles out of the box.

The module adds no routes, entities or screens of its own — the actual cloning
comes from Replicate UI, which provides a **Clone** tab on content and a confirm
step. What LocalGov Replicate adds is the sensible defaults: it makes all content
types replicatable, grants the `replicate entities` permission to the **LocalGov
Editor** role, and (via an optional microsites submodule) extends that grant to the
microsites roles. Access is entirely Replicate UI's: only users holding
`replicate entities` see the Clone tab; everyone else gets no tab and a 403.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside Replicate
   and Replicate UI, and enable it (plus the microsites submodule if needed).

This module has **no settings form**. Its only "configuration" is *which roles* may
clone — managed on the standard permissions page (below) — and *which content types*
are replicatable, managed through Replicate's own configuration.

## Where it lives in the admin menu

- Editors clone content from the **Clone** tab that appears on a node.
- Who can clone is set at **People → Permissions**
  (`/admin/people/permissions`), under the **Replicate** section — look for the
  **Replicate entities** permission. By default only **LocalGov Editor** holds it;
  grant it to other roles here, or remove it from a role to instantly revoke clone
  access.

## How to use it

1. Install and enable the module alongside Replicate and Replicate UI (see
   [Installation](installation/index.md)). For microsites, also enable the
   **LocalGov Replicate Microsites** submodule, which grants clone access to the
   **Microsites Controller** and **Microsites Editor** roles.
2. Log in as a user with the **LocalGov Editor** role (or any role you have granted
   **Replicate entities**).
3. Open a piece of content and click its **Clone** tab, then confirm — you get a
   duplicate as a starting point for a similar new page.

> **Note on access:** cloning requires only the **Replicate entities** permission,
> and a user with it can clone content they do not own — including unpublished
> content. Treat the permission as a content‑creation grant and give it only to
> trusted editorial roles.
