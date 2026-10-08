# Unique Field — manual setup guide

**Unique Field** (`unique_field`) enforces that chosen fields hold values not
already used elsewhere. When an editor tries to save a node, taxonomy term or user
whose designated field duplicates an existing one, the form is blocked with a
clear *"has to be unique"* message. It's the quick way to guarantee data integrity
— unique product SKUs, ISBNs, membership numbers, marketing codes, term names —
without writing a custom validation constraint.

Rather than adding its own admin page, Unique Field slots a small **"Unique Field
restrictions"** section into the forms you already use: the *content type* edit
form, the *taxonomy vocabulary* form, and the global *Account settings* form. There
you pick which fields must be unique, choose the **scope** the uniqueness applies
across (for example the same content type, the same language, or all nodes), and
decide whether **each** chosen field must be unique on its own or whether the
**combination** of them must be unique. On submit, an added validation step queries
the database and stops the save if a duplicate exists.

The module has no dependencies and works the moment you enable it — but it does
nothing until you configure a rule on at least one content type, vocabulary or the
account settings. It ships two permissions, both marked restricted: one to
configure the rules, and one that lets trusted editors override a duplicate error
with a single click. Note it targets nodes, taxonomy terms and users specifically
(not arbitrary entity types), and only checks fields that are actually present in
the submitted form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — where the uniqueness settings appear,
   the scope and comparison options, and the override/bypass flow.

## Where it lives in the admin menu

There is no page of its own. The **Unique Field restrictions** fieldset is added
to existing forms:

- **Nodes:** *Structure → Content types → (edit a type)*.
- **Taxonomy terms:** *Structure → Taxonomy → (edit a vocabulary)*.
- **Users:** *Configuration → People → Account settings*.

Editing the node and term settings requires the **Administer unique field
settings** permission.
