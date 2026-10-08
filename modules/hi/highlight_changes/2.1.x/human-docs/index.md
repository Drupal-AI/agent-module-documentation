# Highlight Changes — manual setup guide

**Highlight Changes** (`highlight_changes`) gives content editors visual feedback
about what they have changed on an entity form before they save. When the page
loads, the module records the starting value of each input. The moment an editor
changes one, a small notice appears next to that field — and from there they can
open a view of the change and **revert** the field back to its original value.

It's an editorial‑UX aid: a way to see at a glance which fields are "dirty" on a
long, complex form, and to undo an accidental edit without reloading the whole
page and losing other work. It works with core field widgets and also plays
nicely with CKEditor, Chosen, and other field‑enhancing modules.

The module has no external dependencies and runs on Drupal 10, 11, and 12. It
works the moment you enable it — there is no settings form to fill in. Access to
the feature is governed by a permission (see below).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form. The
only thing to review after enabling it is the permission described below.

## Where it lives in the admin menu

Highlight Changes adds no admin settings page. It activates automatically on
entity edit forms for users who have its permission.

## How to use it

1. After enabling the module, go to **People → Permissions**
   (`/admin/people/permissions`) and grant the Highlight Changes permission to the
   roles whose editors should see change highlighting.
2. Those users then simply edit content as usual. As they modify a field, a notice
   appears beside it; clicking through lets them review and revert that field's
   change back to the value it had when the page loaded.
