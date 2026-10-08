# Configuration

Require on Publish has no central settings page. You enable it **per field**, on
that field's configuration form. The two checkboxes it adds only appear for fields
on publishable entity types (those with a published/unpublished status, such as
nodes).

## Enable it on a field

1. Go to the field's **edit form**. From a bundle's **Manage fields** page, click
   **Edit** on the field — for example the Article body at
   `/admin/structure/types/manage/article/fields/node.article.body`.
2. Tick **Required on Publish**.
3. Optionally tick **Warning on Empty** (this second checkbox only appears once
   *Required on Publish* is checked).
4. **Save** the field settings.

The setting is stored with the field's configuration (as a third-party setting), so
it exports and deploys along with the field — no separate config to remember.

## What the two checkboxes do

- **Required on Publish** — when the entity is **published** and this field is
  empty, saving is **blocked** with the message *"&lt;label&gt; field is required
  when publishing."* While the entity is unpublished (a draft), the field can be
  left empty freely.

  For a **boolean** (checkbox) field, "filled" means checked — so a
  required-on-publish boolean effectively has to be ticked before the entity can
  be published.

- **Warning on Empty** — when the entity is **unpublished** and the field is empty,
  a non-blocking **warning message** is shown. It never stops a save; it just
  reminds the editor that a recommended field is still empty. It has no effect
  unless *Required on Publish* is also on.

## Where it applies

Because enforcement is an entity-level validation constraint rather than a form
handler, it fires on any validation of the entity — the node edit form, Paragraphs
subfields (which honour the parent's publish status), and programmatic or REST
saves alike. There is no separate per-form toggle; flag the field once and the rule
applies everywhere that entity is validated.

## Turning it off

Edit the field again and untick **Required on Publish** (and **Warning on Empty**),
then save. The requirement is removed.
