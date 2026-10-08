# Configuration

Flexible descriptions has two working surfaces — a **settings form** and a
**management screen** — plus a set of **per-bundle permissions** that decide who
may edit which descriptions.

## Open the settings form

1. Log in as a user with the **administer flexible_description** permission (an
   administrator by default).
2. Go to the Flexible descriptions settings form, registered as
   `entity.flexible_description.settings` and found under **Administration**.

This form is where you administer the module and reach the central management of
field descriptions.

## The management screen

The management form (gated by the **manage flexible descriptions** permission)
lists your content entity types and their bundles, and lets you add or edit the
description shown under each field on that bundle's form. Because 2.0 adds inline
editing via HTMX, you can open a small edit form for a single description, save
it, and cancel — all without a full page reload.

Key points about how descriptions are stored:

- Each description is a **content entity** keyed to an `entity-type|bundle`
  identifier — not configuration. Editing help text therefore does **not** need a
  config export/import, and your changes will not be overwritten on the next
  deployment.
- Descriptions can be **language-specific**, so on a multilingual site you can
  provide different help text per language.

## Per-bundle permissions

Beyond the two administrative permissions above, Flexible descriptions generates a
**dynamic permission for each bundle**, named in the form:

> `manage flexible descriptions in {entity_type}|{bundle}`

for example `manage flexible descriptions in article|node`. Assign these at
**People → Permissions** to delegate description editing narrowly — you can let a
sub-editor manage the help text for just one content type without granting them
access to everything else.

Summary of the permissions you will see:

| Permission | What it allows |
|-----------|----------------|
| **administer flexible_description** | Access the settings form and administer the module. |
| **manage flexible descriptions** | Use the central management screen. |
| **manage flexible descriptions in `{entity_type}\|{bundle}`** | Edit descriptions for that one bundle only (one such permission per bundle). |

## Import / export

The module includes a **YAML import/export** mechanism for descriptions, useful
for moving help text between environments. If you need a fuller sync workflow,
enable the **Flexible descriptions sync** submodule (see
[Installation](../installation/index.md)).

## Save

Save your changes on the management form. Because descriptions are stored as
content, they take effect immediately on the relevant entity forms without a
cache rebuild or config import.
