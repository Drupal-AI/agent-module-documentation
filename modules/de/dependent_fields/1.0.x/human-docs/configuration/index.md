# Configuration

Dependent fields has no admin settings page. You set it up per **child** field by
choosing a special reference method that filters the field's options through a
View. There are three ingredients: a **parent** field, a **child**
entity-reference field, and a **View** that filters the child's options by the
parent's value.

## Prerequisites

Before configuring the field:

1. **Views** is enabled.
2. Both the parent and child fields exist on the same bundle.
3. You have a **View** with an **Entity Reference** display that lists the child's
   target entities, and whose **first contextual filter (argument)** matches the
   parent value. For example, to filter child taxonomy terms by their parent term,
   the View's first argument filters on the parent term id. If the parent can hold
   multiple values, set that argument to *"Allow multiple values"*.
4. The child field's form widget is a **Select list** or **Check boxes / radio
   buttons**. The **autocomplete widget is not supported** and will not get
   filtered options.

## Configure the child field

1. Edit the **child** entity-reference field's settings — from the bundle's
   **Manage fields** page, e.g.
   `/admin/structure/types/manage/<bundle>/fields/...`.
2. Under **Reference method**, choose **"Make field dependent using views"**.
3. Fill in the settings that appear:
   - **View used to select the entities** — pick the `view : display` that lists
     the options (only Entity Reference displays are offered).
   - **Parent field** — the field this one depends on.
   - **Reference parent by UUID instead of entity ID?** — tick this only if your
     View's argument expects UUIDs. This is mainly useful for configuration
     portability between environments; leave it off otherwise.
   - **View arguments** — optional extra, comma-separated arguments appended
     *after* the parent value, if you want to filter further.
4. Save the field.
5. On **Manage form display**, confirm the child field's widget is **Select list**
   or **radios / checkboxes** (not autocomplete).

## What happens on the form

When an editor changes the parent field, the module re-runs your View with the new
parent value as its argument and replaces the child field's options — no page
reload. Multi-value child fields stay multi-value even if they start out empty, and
the whole thing works inside Paragraphs subforms as well.

## Troubleshooting

- **The child options never filter.** Check that the View actually accepts the
  parent value as its **first** contextual filter, and that the child widget is a
  select or radios/checkboxes rather than autocomplete.
- **UUID mismatch.** If you ticked *reference parent by UUID*, your View's argument
  must be set up to receive a UUID; otherwise leave that option off and pass entity
  ids.
