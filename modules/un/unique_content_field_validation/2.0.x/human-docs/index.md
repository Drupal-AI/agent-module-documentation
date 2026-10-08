# Unique content field validation — manual setup guide

**Unique content field validation** (`unique_content_field_validation`) lets you
mark a field, a content type's node **title**, or a taxonomy vocabulary's term
**name** as **unique**, so Drupal rejects a second entity in the same bundle that
has a duplicate value — with an optional custom error message. It's the simple way
to enforce "no two Articles with the same title", "every SKU must be unique", or
"term names in this vocabulary can't repeat", without writing a custom validation
constraint.

The module works by adding **"Unique"** options to forms you already use: the field
settings form, the content‑type form, and the vocabulary form. You tick a box (and
optionally type a friendly message), save, and from then on the entity form shows an
error if someone tries to save a duplicate. Uniqueness is scoped **per bundle and
per language**, and re‑saving an unchanged entity is always allowed because the
current entity is excluded from the check.

There is **no central admin settings page** — you enable uniqueness inline on each
field, content type, or vocabulary. The choices are stored as *third‑party settings*
on the relevant config, so they export cleanly with your configuration. The module
adds no permissions and no Drush commands, depends on core's **Node** and
**Taxonomy** modules, and ships no submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — turn uniqueness on for a field, a node
   title, or a term name, and set custom messages.

## Where it lives in the admin menu

There's no page of its own. The "Unique" options appear inline on:

- **Field settings** — *Structure → Content types → &lt;type&gt; → Manage fields →
  &lt;field&gt; → Edit*.
- **Content type** (for the title) — *Structure → Content types → &lt;type&gt; →
  Edit*.
- **Vocabulary** (for the term name) — *Structure → Taxonomy → &lt;vocabulary&gt; →
  Edit*.

## How to use it

Decide what needs to be unique, open the matching form, tick **Unique**, optionally
write a message, and save. See [Configuration](configuration/index.md) for the
details of each of the three places and the message tokens.
