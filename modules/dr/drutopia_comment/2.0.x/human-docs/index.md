# Drutopia Comment — manual setup guide

**Drutopia Comment** (`drutopia_comment`) is a base *feature* module from the
[Drutopia](https://www.drupal.org/project/drutopia) distribution. It ships a
ready-made commenting setup — a comment type, comment fields, and their form and
display settings — so a Drutopia site gets consistent, ready-to-use discussion
configuration instead of building it by hand.

It is a pure *config* feature: it contains no PHP logic, routes, services,
controllers or permissions of its own. Enabling it installs the bundled comment
configuration and pulls in its dependencies — core `comment`, `field`, `node`,
`rdf` and `text`, plus **Drutopia Core** so the shared components load first.
The `rdf` dependency adds RDF metadata markup to comment output.

Because it has no independent access surface, comment visibility and posting are
governed entirely by **core Comment permissions**. There is nothing to configure
in code: you enable the module (usually it is pulled in automatically by the
Drutopia install profile) and then moderate comments through Drupal's normal
comment admin. Uninstalling removes the shipped configuration per the
distribution's config-management workflow.

See the [Drutopia Core](../../drutopia_core/2.0.x/human-docs/index.md) guide for
the shared base this feature depends on.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   feature and its dependencies.

There is **no dedicated configuration page** for this module — it ships
configuration rather than a settings form, and commenting is managed through
core's own comment admin and permissions.

## Where it lives in the admin menu

Drutopia Comment adds no settings page of its own. You work with what it installs
through core's comment tools:

- **Comment types** — **Structure → Comment types**
  (`/admin/structure/comment`).
- **Moderating comments** — **Content → Comments**
  (`/admin/content/comment`), where you approve, edit, unpublish or delete
  comments.
- **Who can comment** — **People → Permissions** (`/admin/people/permissions`),
  under the core Comment permissions.

## How to use it

Once enabled, the shipped comment configuration is applied to the content it is
wired to. Grant or restrict commenting per role through core Comment permissions,
and moderate incoming comments from **Content → Comments**. Site builders can
override the shipped comment fields and displays like any other configuration, and
re-import the defaults if a change needs undoing.
