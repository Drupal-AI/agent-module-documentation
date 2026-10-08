# Alter Entity Autocomplete — manual setup guide

**Alter Entity Autocomplete** (`alter_entity_autocomplete`) makes Drupal's
entity-reference **autocomplete fields** more flexible for editors. Normally you
have to type an entity's label and pick it from the suggestions. With this module,
an editor can instead reference an entity by typing its **ID, email address, URL,
or path alias** directly — for **Node**, **User**, and **Taxonomy Term**
references. That's a real time-saver when you already know exactly which entity you
want.

You control which entity types allow this direct input from the module's settings
form. It is a content-editing convenience and has no access-control role of its
own.

One nuance worth knowing: the standard autocomplete only suggests entities the
editor is allowed to see, so its suggestions are already access-filtered. Allowing
direct **ID** input means an editor could name an entity by ID that the
autocomplete would not have suggested. Drupal's reference field still runs its own
selection/access validation when the form is **saved** (a reference to an entity
the field shouldn't allow is rejected then), but if you work with access-sensitive
reference sets it's worth verifying that behaviour for your specific fields.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module adds an admin settings form (route
`alter_entity_autocomplete.admin_settings`), reached with the **Administer site
configuration** permission, where you choose which entity types allow direct input.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Open the module's settings form (route
   `alter_entity_autocomplete.admin_settings`; if you don't see a direct link, find
   the module on the **Extend** page and use its **Configure** link).
3. Choose which of **Node**, **User**, and **Taxonomy Term** should accept direct
   input, and save.
4. In content forms, editors can now type an **ID, email, URL, or path alias**
   straight into the enhanced autocomplete fields for those entity types, instead
   of only the label.
