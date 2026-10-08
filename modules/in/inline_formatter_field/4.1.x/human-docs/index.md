# Inline Formatter Field — manual setup guide

**Inline Formatter Field** (`inline_formatter_field`) lets site builders combine
several fields into one nicely templated output, using HTML or Twig, right from
the **Manage display** tab — no theme override, no computed field, no field group
fighting with CSS. A great deal of front‑end work is really just joining fields
that belong together but are stored separately: a street, city and postcode that
should read as one address; an amount and a currency that should read as
"£24.99"; an author and a date that should read as a byline. This module turns
that joining into a display setting.

At its core it adds a new field type called **Inline Formatter**, which is simply a
boolean (an on/off switch). When you turn the boolean on for a display, the field
renders whatever HTML or Twig you entered in its **HTML or Twig Format** setting on
the **Manage display** tab — placed wherever you position the field in the entity's
display. To make the templating comfortable, the module ships an in‑browser code
editor (the ACE Editor) and installs a dedicated text editor profile called **IFF
Ace Editor** for it.

Inside your Twig you get two handy variables: the entity itself, referenced by its
type name (`node`, `media`, `block_content`, and so on) for pulling in any field or
property, and `current_user` for showing personalized content or checking roles.
Two things are worth deciding up front. First, **plan your empty‑value handling** —
a template that joins three fields with commas will leave stray punctuation when
one is blank, which is the most common visible bug in this pattern. Second, this is
**presentation, not data** — the underlying fields stay separate for search
indexing, JSON:API, and Views filtering, which is usually exactly what you want.

For richer, per‑bundle control there are two submodules, described in
[Installation](installation/index.md#submodules): **Inline Formatter Display** lets
you template an entire entity display, and **Inline Formatter Views Field** brings
the same combining power to Views.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and pick the submodules you need.
2. [Configuration](configuration/index.md) — the global settings form that
   controls the ACE Editor (theme, mode, source, and the default editor profile).

## Where it lives in the admin menu

The module's global settings form is at **Configuration → Inline Formatter Field
Settings** (`/admin/config/inline_formatter_field/settings`). The everyday work,
however, happens on **Structure → Content types → *(bundle)* → Manage display**,
where you add the Inline Formatter field, switch it on, and write its HTML/Twig.

## How to use it

1. Add an **Inline Formatter** field to the content type (or other fieldable
   entity) you want to template.
2. Go to that entity's **Manage display** tab, find the field, and turn its
   boolean on.
3. In the field's format settings, enter the **HTML or Twig Format** — the markup
   that should render when the field is switched on. Use the entity variable
   (e.g. `{{ node.field_price.value }}`) and `current_user` to pull in dynamic
   content, and decide how empty values should behave before you finish.
4. Position the field where you want the combined output to appear, and save.

Each editor can pick their own ACE Editor theme and mode on the Manage display
form; those personal preferences are stored in a browser cookie, and the
site‑wide defaults come from the settings form covered in
[Configuration](configuration/index.md).
