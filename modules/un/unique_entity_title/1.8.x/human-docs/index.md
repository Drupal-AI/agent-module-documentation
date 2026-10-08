# Unique Entity Title — manual setup guide

**Unique Entity Title** (`unique_entity_title`) makes sure the **title of a node**
(or the **name of a taxonomy term**) is unique within its bundle, rejecting
duplicates when the entity is validated. Turn it on for a content type and you can
no longer create two Articles with exactly the same headline; turn it on for a
vocabulary and you can no longer create two terms with the same name. Titles can
still repeat *across* different bundles — the check is scoped to one bundle at a
time.

The enforcement is opt‑in per bundle. When you enable it on a content type or
vocabulary, the module attaches a validation constraint to that bundle's title/name
field. Because it works at the validation layer, the rule fires everywhere entities
are validated: the node/term edit forms, content created programmatically through
the entity API, and imports via JSON:API or the REST resource. Editors get a clear
"already in use, must be unique" error, and re‑saving an existing entity never trips
a false duplicate against itself.

The check is sensible about edge cases: it trims leading and trailing whitespace
(so "Foo " and "Foo" count as duplicates), ignores empty titles, and excludes the
entity being edited from its own comparison. Only **node** and **taxonomy term**
entity types are supported. There is **no central settings form, no permission, and
no Drush command** — you enable it with a single checkbox on each content type or
vocabulary.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — turning on unique titles per content
   type or vocabulary.

## Where it lives in the admin menu

There is no dedicated settings page. The opt‑in checkbox appears on each content
type's edit form (**Structure → Content types → *(type)* → Edit**) and on each
vocabulary's edit form (**Structure → Taxonomy → *(vocabulary)* → Edit**), inside
the additional‑settings vertical tabs.

## How to use it

Enable the module, then edit the content type or vocabulary where you want unique
titles and tick the relevant checkbox (see Configuration). From then on, saving an
entity in that bundle with a duplicate title is blocked with a validation error.
