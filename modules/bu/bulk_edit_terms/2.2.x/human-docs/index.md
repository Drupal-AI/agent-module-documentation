# Bulk Edit Terms — manual setup guide

**Bulk Edit Terms** (`bulk_edit_terms`) adds a content action —
*"Update term references for the selected content"* — to the admin Content
overview, so editors can add, replace, clear or remove taxonomy-term
(entity-reference) field values across many nodes at once. Instead of opening each
node to fix a category or tag, you tick the nodes on `/admin/content`, apply the
action, and choose what to do with their term fields on a confirmation screen.

The action appears in the **Action** dropdown at the top of the Content list. When
you apply it, the module stashes the selected node IDs and takes you to a
confirmation form that lists every taxonomy-term reference field found on at least
one of the selected nodes. For each field you pick an **update mode** — leave
unchanged, clear, replace, append, or remove a specific value — and the term
value(s) to apply. Changes are written only to nodes that actually have the field,
and only where you already have permission to edit that node and that field, so an
editor can never change something they couldn't edit individually.

A small settings form lets you choose which widget is used to collect values for
multi-value term fields on the confirmation screen (autocomplete by default). The
action itself is gated by core's **Administer nodes** permission, and the settings
form by the module's own **Administer bulk edit terms** permission. The module has
no other dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the widget-type settings form and the
   permissions that control who can run bulk edits.

## Where it lives in the admin menu

- The action runs from **Content** (`/admin/content`) via the **Action** dropdown.
- The settings form sits at **Configuration → Content authoring → Bulk Edit Terms**
  (`/admin/config/content/bulk_edit_terms`).

## How to use it

1. Go to **Content** (`/admin/content`) and tick the nodes you want to change.
2. In the **Action** dropdown choose *"Update term references for the selected
   content."* and click **Apply**.
3. On the confirmation form (`/admin/node/select/terms`), each taxonomy-term
   reference field that exists on at least one selected node is listed. For each
   field, pick an **update mode** and, where relevant, the term value(s):
   - **None** — leave the field unchanged.
   - **Clear** — empty the field.
   - **Replace** — set the field to the chosen value.
   - **Append** — add to existing values (multi-value fields).
   - **Remove** — delete one specific value.
4. Submit. Changes apply only to nodes that have the field, and only where you have
   edit access. By default, multi-value fields append and single-value fields are
   replaced.
