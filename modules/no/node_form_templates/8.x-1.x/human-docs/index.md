# Node Form Templates — manual setup guide

**Node Form Templates** (`node_form_templates`) lets you define reusable
**templates that pre‑fill fields on a node form**. When an editor starts a new
node, a dropdown appears at the top of the form; choosing a template populates the
form's fields with the template's boilerplate values, ready to be tweaked and
saved. It is a time‑saver for content that is created over and over in a similar
shape — recurring event announcements, standard product descriptions, structured
"how‑to" articles — where starting from a blank form each time means repeating the
same setup.

It is purely a content‑creation convenience. A template only *prefills* the form;
the node the editor ultimately saves still goes through Drupal's normal validation
and access checks, so the module adds no back door around your existing content
rules. It defines its own permissions so you can decide which roles may create and
use templates.

The module has no dependencies beyond core and works across Drupal 8 through 11.
It becomes useful as soon as you create your first template, so the setup below is
about installing it and then defining the templates your editors will pick from.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

The module ships an admin settings form for creating and managing templates, and
its own permissions — the "How to use it" section below covers the workflow.

## How to use it

1. After enabling the module, grant the relevant roles the Node Form Templates
   permissions at **People → Permissions** (`/admin/people/permissions`) — this
   controls who may create templates and who may use them.
2. On the module's settings form, create one or more **templates**, giving each a
   set of prefilled field values for the content type it applies to.
3. Now, when an editor visits a node **add** form, a **template dropdown** appears
   at the top of the form. Selecting a template fills in the fields with that
   template's values; the editor adjusts what they need and saves the node as
   normal.
