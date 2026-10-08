# Entity Reference CRUD Display — manual setup guide

**Entity Reference CRUD Display** (`entity_reference_crud_display`) is a **field
formatter** that lets editors **create, read, update, and delete** referenced
entities **inline, via AJAX, right from the host entity's display** — the full
content page, a teaser, or any other view mode. There is no need to open the host
entity's edit form to manage its references.

It is similar in spirit to the **Inline Entity Form** module, but with a key
difference: Inline Entity Form works on the *editing form*, while Entity
Reference CRUD Display works on the *display*. So instead of visiting
`/node/{id}/edit` to add or change referenced items, an editor can do it directly
where the content is shown, through AJAX‑driven modals. It works on nodes and any
other entity type, making it a flexible alternative to Paragraphs for some
in‑place editing workflows.

The module ships a **set of permissions** so you can finely control who may
create, edit, or delete referenced entities, and when. There is **no central
settings page** — you turn it on by selecting its formatter on an entity
reference field's *Manage display*. It works on Drupal 10 and 11 with no
dependencies beyond core, and is developed by 7Links Web Solutions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form. You
enable it on your entity reference field's *Manage display*, and control access
through its permissions. Both are described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin settings page. You use it from an entity's **Manage
display** (**Structure → Content types → *(type)* → Manage display**), and manage
who can use it on **People → Permissions** (`/admin/people/permissions`).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to the **Manage display** of the bundle that has your entity reference
   field.
3. In the **Format** column for that field, choose **Entity Reference CRUD
   Display**.
4. On **People → Permissions**, grant the module's create/edit/delete permissions
   to the roles you trust to manage referenced content in place.
5. Save. When those users view the host entity, they can create, edit, and delete
   the referenced entities inline through AJAX — without opening the host entity's
   edit form.
