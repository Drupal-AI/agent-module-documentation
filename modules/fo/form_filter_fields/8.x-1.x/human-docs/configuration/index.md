# Configuration

Setting up a dependency has two halves: first you build a **View** that produces
the filtered option list, then you **register the dependency** on the Form
Filter Fields admin form. This page walks through both.

## Step 1 — Build the filtering View

The View is the engine that decides which options the target field shows for a
given control value.

1. Create a new View (**Structure → Views → Add view**) of the entity that holds
   your target options — commonly **Taxonomy terms**.
2. Add a **contextual filter** for the value that comes from the *control*
   field. For a taxonomy relationship this is typically the term ID of the
   controlling vocabulary. The contextual filter is how the control field's
   current selection is passed into the View.
3. Configure the View so that, for a given control value, it returns only the
   rows that should appear in the target field.
4. Set the View's output to an **HTML list of fields**, and **rewrite the
   results** so each row is in the form `tid|Option Name` — for example
   `45|Ball`. This `id|label` format is what Form Filter Fields reads back to
   build the target field's options.
5. Save the View.

## Step 2 — Register the dependency

Go to **Configuration → Content authoring → Form Filter Fields**
(`/admin/config/content/form_filter_fields`); you need the **Administer site
configuration** permission. Add a dependency by filling in these settings:

- **Node or Media Type** — the entity type and bundle whose edit form carries
  the two fields (a content type or a media type).
- **Control Field** — the field whose value drives the filtering. When an editor
  changes this field, the target field's options are recalculated.
- **Target Field** — the field whose available options change based on the
  control field. This is the select/radios/checkboxes field that gets rewired.
- **View** — the View you built in Step 1. Its contextual filter receives the
  control field's value and its `tid|Name` output becomes the target field's
  option list.

Save the dependency. You can add **multiple dependencies** to the same content
type — the module is built to filter several target fields from one or more
control fields on the same form.

## Removing a dependency

Each configured dependency has a **delete** action on the admin listing. Use it
to remove a relationship you no longer need; this only removes the Form Filter
Fields mapping, not the underlying View or fields.

## Try it out

Open an add/edit form for the bundle you configured. Change the **control**
field and confirm the **target** field's options update to match. If nothing
changes, re‑check that the View's contextual filter is receiving the control
value and that its rewritten output uses the exact `id|label` format.

> **Good to know:** Form Filter Fields does not work inside **Inline Entity
> Form (IEF)** subforms — those are built through a different form‑construction
> path. And because the filtering only shapes the options shown in the form,
> treat it as a convenience for editors rather than as validation of what is
> ultimately submitted.
