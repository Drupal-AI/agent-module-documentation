# Paragraphs Extended Modal — manual setup guide

**Paragraphs Extended Modal** (`paragraphs_em`) improves the modal dialog editors
use to add paragraphs. When a Paragraphs field widget uses the **modal** add
method, this module makes that "add paragraph" dialog more user‑friendly: it lets
you **categorize paragraph types** and gives the modal a better layout, so choosing
which type to add is quicker and clearer when a site has many paragraph types.

It is a lightweight content‑editing/UX enhancement. The maintainers note it is
heavily inspired by the
[Paragraphs Editor Enhancements](https://www.drupal.org/project/paragraphs_ee)
module and reuses some of its code as a base — the goal here being a similar but
lighter‑weight tool. It depends only on the
[Paragraphs](https://www.drupal.org/project/paragraphs) module, provides its own
permission, and affects only the add‑paragraph dialog — it has no access‑control
role beyond that permission.

Note that this module is **not covered by Drupal's security advisory policy**, and
it is described by its maintainers as minimally maintained.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central configuration page** for this module — enabling it is
essentially all the setup there is. See "How to use it" below.

## Where it lives in the admin menu

The module adds no settings page. It takes effect wherever a Paragraphs field
widget is configured to use the **modal** add method, and its permission is granted
at **People → Permissions** (`/admin/people/permissions`).

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. At **People → Permissions**, grant the module's permission to the roles that
   should get the enhanced add modal.
3. Make sure the Paragraphs field's widget is set to use the **modal** add method
   (on the entity's **Manage form display**). The extended, categorized modal then
   appears automatically when editors add a paragraph.
4. Navigate to a content entity that has such a Paragraphs field and add a
   paragraph — you should see the improved modal layout with categorized paragraph
   types.
