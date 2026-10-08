# Configuration

Entity Copy with Reference needs configuration before it does anything — you decide
which content types can be copied and, for each one, what happens to its reference
fields when a node is cloned.

## Open the settings form

1. Log in as a user with permission to administer site configuration.
2. Go to the module's configuration form (route `entity_copy_reference.form`).

## Step 1 — Choose which content types are copyable

The first page lists all existing **content types** on your site. Tick the ones for
which you want to make one‑click copying available. Only the types you select here
will get a copy action, and only they appear in the next step.

## Step 2 — Decide how each reference field is handled

After selecting content types, a second page lists **all reference fields** on each
of the selected types. For every reference field you choose how a copy should treat
it, from three options:

- **Clear all references** — the new copy starts with this reference field empty.
  Use it when the reference shouldn't carry over at all.
- **Keep the reference to the same entity as the original** — the copy points at the
  exact same referenced entity as the original node. Both the original and the copy
  now share that referenced entity, so editing it affects both.
- **Duplicate the referenced entity as well** — the referenced entity is itself
  cloned, and the copy points at its own fresh duplicate. This is the option you
  usually want for **Paragraphs** embedded in a node, so that editing the new
  node's paragraphs never touches the original.

Set each reference field independently — you can clear some, share others, and
duplicate the rest on the same content type.

## Save

Save the form. Copying is now available on nodes of the selected content types
(subject to the module's permission — see
[Installation](../installation/index.md)). Cloning a node creates a brand‑new node
using the reference behavior you configured here.
