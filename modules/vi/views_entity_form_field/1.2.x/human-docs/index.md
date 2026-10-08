# Views Entity Form Field — manual setup guide

**Views Entity Form Field** (`views_entity_form_field`) turns a view into a
**bulk-edit table**. It adds every editable entity field to Views' "Add field"
list as a real, working form widget, so instead of just *displaying* a field's
value, a column can show an editable widget on every row — and a single **Save**
button at the bottom writes all your changes at once.

This is a lightweight way to build editorial dashboards and mass-update screens
without writing a custom form: make a whole list's titles editable inline,
bulk-toggle a "Featured" checkbox across dozens of nodes, retype prices or stock
levels for many commerce entities, fix a batch of publication dates, or correct
imported data right after a migration. You choose the widget per column (an
autocomplete, a select list, a plain textfield, a datetime widget, and so on),
and you can mix editable columns with ordinary read-only ones in the same view.

It is careful about access and efficiency: each row is checked individually, so
rows the current user may not edit are hidden (or shown read-only in a fallback
view mode), the Save button disappears when nothing is editable, widget
validation errors appear next to the offending row, and only rows you actually
changed are re-saved. The whole editable view is still configuration, so you can
export and deploy it like any other view.

The module has **no settings page, no permissions and no Drush commands** of its
own — everything is configured through the Views UI, one field at a time.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module adds no page of its own. You use it inside the **Views** UI
(`/admin/structure/views`) when adding fields to a view.

## How to use it

1. Edit (or create) a view of the entity type you want to bulk-edit. A **Table**
   display format works best, because the editable widgets need a view that
   renders as a form.
2. Click **Add** in the *Fields* section and search for **"Form field: "** — every
   editable field of the view's entity type is listed (with help text showing
   which bundles it appears in).
3. Pick a field and configure it:
   - **Widget type** — choose the form widget to use for that field (for example a
     textfield, a select, or an autocomplete).
   - **Hide widget title / Hide widget description** — both on by default, so the
     view still reads like a clean table.
   - **Fallback view mode** — for rows the user cannot edit, either hide the field
     entirely or render it read-only using a chosen view mode.
   - **Widget settings** — the widget's own settings (size, placeholder, etc.).
4. Save the field, and repeat for any other columns you want to make editable.
5. Save the view. Rows now render editable widgets and the view grows a **Save**
   button that commits all changed rows in one submit.

A few things to keep in mind:

- Use a display style that renders a form (such as **Table**) — the widgets need
  it to appear.
- Do **not** combine this with a Views Bulk Operations bulk-operations form on the
  same display; the two fight over the submit button.
- Access is checked per row, but some entity types do not implement thorough
  access checks, so also protect the view's page with an appropriate permission.
