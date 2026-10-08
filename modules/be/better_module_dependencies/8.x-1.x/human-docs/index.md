# Better Module Dependencies — manual setup guide

**Better Module Dependencies** (`better_module_dependencies`) makes the
**Extend** (module list) page a little easier to navigate. On that page each
module lists the other modules it depends on, but those dependency names are plain
text. This module turns them into **clickable links** that jump straight to the
dependency in the list.

If you have ever scrolled a long Extend page trying to find the module that a
dependency name refers to, this saves that hunt — click the name and you land on
it. It is handy for untangling dependency chains on complex site builds and for
onboarding people to an unfamiliar module list.

It is a minimal admin‑UI enhancement: a small JavaScript behaviour that rewrites
the dependency labels into links on the Extend page. There is no configuration
form, no permission, and no route to set up, and it changes nothing about your
module data — it only affects how the page looks. It supports Drupal 8, 9, and 10.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is nothing to configure. Once the module is enabled, go to **Extend**
(`/admin/modules`). The dependency names listed under each module are now links —
click one to jump to that dependency.
