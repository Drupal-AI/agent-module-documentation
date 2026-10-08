# Configuration

Entity Form Display Visibility is configured per field, on the **Manage form
display** page. There is no central settings form — you set conditions on each
field where you want them.

## Add a condition to a field

1. Go to **Structure → Content types → *(your type)* → Manage form display** (or
   the equivalent Manage form display page for any other entity bundle). If you
   want the rule to apply only in a specific form mode, switch to that form mode
   first.
2. Find the field you want to restrict and click the **cogwheel** at the end of
   its row to open the widget settings.
3. A **Visibility Conditions** section appears. Enable the condition(s) you want:

### Access by Role

Enable **Access by Role** and tick the roles that are allowed to edit the field.
A user is allowed if they have **any** of the selected roles; users without a
selected role have the field removed from their form. Use this for rules like
"only editors and administrators may edit this field."

### Access by Permission

Enable **Access by Permission** and choose a permission. Only users who hold that
permission may edit the field. Use this to tie field editing to a specific
capability — for example, gating a pricing field behind a "manage pricing"
permission.

4. Click **Update** on the widget settings, then **Save** the form display.

## How multiple conditions combine

If you enable more than one condition on the same field, they are combined with
**AND** — every enabled condition must allow access for the field to appear. A
condition that is left disabled has no effect (it stays neutral). So enabling both
Access by Role and Access by Permission means a user must satisfy *both* to edit
the field.

## What the restriction actually does

Enforcement sets the widget's form `#access`. When a user does not pass the
conditions, the field is **removed from the add/edit form entirely** — it is not
merely hidden with CSS, and its value cannot be submitted by that user. This is
edit‑form access control. It does not change who can *view* the field's value on a
rendered page, in JSON:API, REST, or Views; use a field‑view access mechanism for
that.

## Reusing conditions across bundles

Because the condition settings are stored inside the `entity_form_display`
configuration, they travel with your configuration when you export and import it.
Exporting a form display carries its visibility conditions to other environments.

## Adding your own condition (developers)

Conditions are plugins. A developer can add a project‑specific condition by
implementing `FormDisplayVisibilityConditionInterface` (see the sibling
[`agent/extend/conditions.md`](../../agent/extend/conditions.md) reference), and
it will appear alongside the built‑in ones in the Visibility Conditions section.
