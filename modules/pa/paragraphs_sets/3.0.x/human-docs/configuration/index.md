# Configuration

There are two parts to setting up Paragraphs Sets: **defining the sets** themselves
(centrally, at *Structure → Paragraphs sets*) and **enabling them on a field** (on
that field's *Manage form display*).

## 1. Define a set

Go to **Structure → Paragraphs sets** (`/admin/structure/paragraphs_set`) and click
**Add** to create a set. A set has:

- **Label** — the name editors see in the set selector.
- **Description** — an optional line explaining what the set is for.
- **Icon** — an optional image to help editors recognize the pattern visually.
- **Paragraphs** — the ordered list of paragraphs the set inserts. Each entry names a
  paragraph type (bundle) and can carry default values for that paragraph's fields.

For example, a "Landing section" set might contain a callout paragraph followed by
two text-column paragraphs, with the first column pre-filled with placeholder body
text. Simple (primitive) field defaults — plain text, numbers — work directly in the
set definition. For complex defaults (entity references, multi-value fields, or
values computed at runtime), a developer can supply them with the module's alter
hooks; see the sibling
[`agent/hooks/data-alter.md`](../agent/hooks/data-alter.md) doc.

This page is gated by the **Administer Paragraphs sets** permission. Because sets are
configuration entities, they are included in your exported site config and deploy
between environments.

## 2. Enable sets on a Paragraphs field

Sets are offered on a per-field basis, through three settings on the **Paragraphs
(stable)** widget. Go to the *Manage form display* of the entity that has your
Paragraphs field (for example a content type's **Manage form display**), confirm the
field is using the **Paragraphs** widget, and open its **cog** (widget settings).
You will find:

- **Enable Paragraphs Sets** — turns on the set selector at the top of the widget.
  This is the switch that makes everything else appear.
- **Limit sets to** — restrict which of your defined sets are offered on this
  particular field. Leave it unrestricted to offer them all, or curate a shorter
  list per field.
- **Default set** — use a chosen set as the field's *default value*, so a new entity
  starts with that set's paragraphs already in place. This option requires the
  widget's own **Default paragraph type** to be set to **- None -** (otherwise the
  two would conflict).

Click **Update**, then **Save** the form display.

## Using it as an editor

With sets enabled on a field, editors see a **set selector** above the Paragraphs
widget. Choosing a set appends its paragraphs, each pre-filled with the set's default
data, which the editor can then adjust. Editors can add multiple sets to build up a
longer page, mixing and matching the approved patterns.
