# Configuration

Unique Field has no page of its own. Its **"Unique Field restrictions"** fieldset
is added to three existing forms, and you set the rules there. Editing the node and
term settings requires the restricted **Administer unique field settings**
permission.

## Where the settings appear

| To make fields unique on… | Edit this form |
|---|---|
| **Nodes** of a content type | *Structure → Content types → (edit the type)* |
| **Taxonomy terms** in a vocabulary | *Structure → Taxonomy → (edit the vocabulary)* |
| **User accounts** | *Configuration → People → Account settings* |

Open the relevant form, expand the **Unique Field restrictions** section, and
configure the options below.

## The options

### Fields

Tick the fields whose values must be unique. On the node and term forms you can
also pick pseudo-fields like **title** / **name**, **description** and
**language** in addition to your custom fields.

### Scope (nodes and terms only)

This decides *across what set* a value must be unique. Users don't have a scope
(their fields are checked account-wide).

For **nodes**:

- **Content type** *(default)* — unique among nodes of the same type.
- **Language** — unique within the same language, so translations may reuse a
  value.
- **All** — unique across every node regardless of type.
- **Node** — the values within a single node's own multi-value field must be
  unique (no internal duplicates).

For **taxonomy terms** the equivalents are **Vocabulary** *(default)*,
**Language**, **All**, and **Term**.

### Comparison — each vs. combination

- **Each** *(default)* — every field you selected must independently be unique.
- **All (combination)** — the *combination* of the selected field values must be
  unique, while each on its own may repeat (e.g. street + city + zip together must
  be unique, but the same city can appear many times).

> The **combination** option is incompatible with the single-node ("Node") and
> single-term ("Term") scopes — saving with that mix is rejected, because those
> scopes require **each**.

## What happens on save

When an editor submits a node, term or user form, Unique Field runs a database
check for each configured field (excluding the entity being edited itself) and, if
it finds a duplicate, sets a form error so the entity can't be saved. A couple of
things are worth knowing:

- **Only fields present in the submitted form are checked.** If a field is hidden
  on the *Manage form display*, it isn't in the submission, so its uniqueness is
  not enforced.
- **Partial (AJAX) submissions are skipped** — the check runs on the real save.

## The override / bypass flow

A user who holds the restricted **Bypass unique field validation** permission
doesn't get a hard block on a duplicate. Instead they see a **warning** with a
one-click link; clicking it re-submits the form with the check skipped for that
submission. This is the escape hatch for a genuine false-positive. Both this
permission and the admin permission are marked restricted — grant them only to
trusted roles.
