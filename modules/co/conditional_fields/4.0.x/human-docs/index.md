# Conditional Fields — manual setup guide

**Conditional Fields** (`conditional_fields`) creates dependencies between the
fields on an entity edit form, so one field reacts to the value of another — with
no code. You pick a **dependent** field and a **controlling** field, then declare a
rule such as *"only show field B when field A equals a certain value"* or *"make
field B required when checkbox A is ticked"*. When an editor fills in the form,
Conditional Fields hides, shows, requires, disables or auto-fills the dependent
field in response, all from within the admin UI.

Under the hood it exposes Drupal core's client-side **States API** — normally
available only to developers writing code — through point-and-click configuration.
It works on the edit forms of nodes, media, users, comments, custom blocks,
taxonomy terms, paragraphs and other entity bundles.

This guide is written for a **human** clicking through the admin UI. It walks you,
step by step and with screenshots, from installing the module to adding your first
field dependency. If you are looking for terse, token-cheap references for an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

![The Conditional fields page listing entity types to manage](images/list.png)

## Where it lives in the admin menu

Everything in this guide sits under **Structure → Conditional fields**
(`/admin/structure/conditional_fields`). That page lists every entity type on the
site — Content block, Comment, and so on — and you drill into an entity type and
then a bundle to manage its field dependencies. Each bundle also gains a **Manage
Dependencies** tab on its own configuration page, which opens the same form.

## Contents

1. [Installation](installation/index.md) — install Conditional Fields with
   Composer and enable it.
2. [Configuration](configuration/index.md) — add your first field dependency:
   choose the dependent and controlling fields, pick a state, and set the trigger
   condition.
