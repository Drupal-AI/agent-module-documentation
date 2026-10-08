# Linky — manual setup guide

**Linky** (`linky`) is a link-management module. It provides a content **entity**
for managing links, so that instead of hard-coding the same external URL in dozens
of places, you create it once as a Linky entity and reference it. When the URL
later changes, you update the single Linky entity and every piece of content that
references it is updated too.

The mechanics: links are inserted into content as **references** to the link
entity, and an input filter resolves each reference to the actual external URL
when the page is rendered. That indirection is the whole point — the reference is
stable, the destination is editable in one place, and it becomes easy to audit
every outbound link your site uses. Linky integrates with **Linkit** for
autocomplete, and it provides a **Dynamic Entity Reference (DER)** widget with
Inline-Entity-Form behaviour: create a DER field, choose the Linky widget and
formatter, and you get a reference field that can point at both internal content
and external links. In that widget, if an editor doesn't pick an existing link
from autocomplete, they can just type a title — creating a new link entity inline.

There's no unusual security surface here; managing external links centrally can
actually *help* you audit outbound links. If some of your links are internal-only,
just confirm the link entities respect the access model you expect.

This 2.x branch is for **Drupal 10.1 and above** and requires **PHP 8.1** — it
includes the revision UI (formerly the separate `linky_revision_ui`), which needs
10.1. It provides its own permissions to control who may administer link entities.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable, and set
   permissions.

There is **no single settings form** — Linky's work happens in the link-entity
management screens and in the fields/filter you configure, described below.

## Where it lives in the admin menu

Linky adds a management area for its **Managed Links** entities (list, add, edit,
with revisions) plus permissions under **People → Permissions**. Links are then
consumed either through the input filter (references resolved on output) or
through a Dynamic Entity Reference field using the Linky widget/formatter.

## How to use it

1. **Create link entities.** Add your external links as Linky (Managed Link)
   entities, each with a title and URL, so they can be referenced and updated
   centrally. Linkit autocomplete helps when inserting them.
2. **Reference them in content.** Links are inserted as references to the link
   entity; the module's input filter resolves each reference to the real URL when
   content is rendered. Change a link entity's URL once and every reference
   follows.
3. **Or use a Dynamic Entity Reference field.** Create a DER field and choose the
   **Linky** widget and formatter to get a reference field that can point at both
   internal content and external links. Selecting nothing from autocomplete but
   typing a title creates a new link entity inline.
4. **Control access.** Grant Linky's administration permissions to the roles that
   should manage link entities, and confirm the access model fits any
   internal-only links.

> **Upgrading from 1.x?** If you are on a 1.x version prior to alpha10, first
> update to the latest 1.x and run database updates (so Linky entities become
> revisionable) *before* moving to 2.x.
