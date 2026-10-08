# Entity Form Mode — manual setup guide

**Entity Form Mode** (`entity_form_mode`) makes Drupal's **form modes** actually
reachable. Drupal lets you build several form displays per entity type — a
simplified "Quick edit," an "Editor" form, and so on — but out of the box almost
nothing *routes* to them, so the feature exists and goes unused, and every role
ends up staring at the same enormous form. This module closes that gap by
automatically selecting a form mode based on the form's route.

The trick is a naming convention. Drupal's entity form routes look like
`entity.node.edit_form` or `entity.taxonomy_term.add`. If you create a form mode
whose machine name matches the last part of the route — `edit_form` — this module
automatically uses it to render that form. The result is that you can give authors
a simplified edit form and editors the full one, purely through configuration,
with a module that is only about ten lines of code and no dependencies.

It works as soon as you enable it — there's no settings screen. The "configuration"
is just building a form mode in Drupal's core Display Modes UI and enabling it on a
bundle, described under "How to use it" below. It supports Drupal 10 and 11.

**A few limits to know.** It works for entity types whose forms follow the
`entity.{entity_type_id}.{form_id}` route convention — nodes, taxonomy terms,
comments, and custom entity types. For **adding nodes** use the `default` form mode
(the add route is `node.add`, not `entity.node.add`); other node forms behave as
expected. It does **not** work for User entities. And a crucial point that's easy
to get wrong: **a form mode is not access control.** A field left off a form
display simply isn't saved *from that form* — it's still readable and writable via
JSON:API, REST, migrations, another form mode, a webform, or `drush`. If a role
must be prevented from *changing* a value, use field-level access
(`hook_entity_field_access` or the Field Permissions module), not a form mode. Used
for its real purpose — reducing what a person has to look at — it's a genuine
improvement to the editing experience.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no settings form** of its own — you set things up with Drupal's core
Display Modes and Manage form display screens. See "How to use it" below.

## How to use it

Here's the full workflow, using Article's edit form as the example:

1. Go to **Structure → Display modes → Form modes → Add form mode**
   (`/admin/structure/display-modes/form/add`) and choose the entity type
   (e.g. **Content**).
2. Give it a label like *Edit form* — and set the **machine name to
   `node.edit_form`** (this must match the route's form id, `edit_form`). Save.
3. Go to **Structure → Content types → Article → Manage form display**
   (`/admin/structure/types/manage/article/form-display`), open the **Custom
   display settings** section, tick your new **Edit form** mode, and save.
4. Click the **Edit form** tab that now appears and arrange the fields for the
   edit experience you want.
5. That's it — editing an existing Article now uses your custom form mode
   automatically.
