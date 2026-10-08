# Select (or other) — manual setup guide

**Select (or other)** (`select_or_other`) adds an **"Other"** choice to a select
list, radio buttons or checkboxes. When a user picks "Other", a free‑text field
appears so they can type a value that is not in the predefined options. It is the
classic pattern for "Country… or Other", "How did you hear about us?" with a
catch‑all, and any field where you want a tidy shortlist that can still capture the
occasional answer you did not anticipate.

It comes in two forms. As a **field widget** it plugs into the Field UI: on a
content type's *Manage form display* tab you choose "Select or Other" as the widget
for a List field or an entity‑reference field (including taxonomy). As a reusable
**Forms API element** it can be dropped into any custom form with a `#type`, giving
developers the same select‑with‑other input without depending on this module beyond
enabling it.

Two nice touches make it more than a plain select. On a List field it can
automatically **add** whatever a user types in "Other" to the field's allowed‑values
list, so the option list grows over time (or you can leave the list fixed and just
capture the free text). On an entity‑reference or taxonomy field, typing a new value
in "Other" can **auto‑create** the referenced entity — for example a brand‑new
taxonomy term — on save, provided the field is set up to allow that and the user has
permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the Forms API
element properties and return values — read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Select (or other) has no central settings page and no permissions of its own. It is
configured **per field**, on the entity's **Manage form display** tab (for example
**Structure → Content types → _\<type\>_ → Manage form display**), by choosing the
"Select or Other" widget.

## How to use it

### As a field widget

1. Add (or reuse) a **List** field (`list_string`, `list_integer`, `list_float`) or
   an **entity‑reference** field, and enter its allowed values or reference settings
   as usual — do **not** add an "other" entry yourself.
2. On the entity's **Manage form display** tab, set that field's widget to **Select
   or Other**.
3. Click the widget's gear icon to adjust its settings:
   - **Element type** — render as a select list or as check boxes / radio buttons.
   - **Sort options** — leave unsorted, or sort ascending or descending.
   - **"Other" option label** — rename the default `- Other -` choice.
   - **"Other" field label** — a visible label for the free‑text field.
   - **"Other" placeholder** — hint text shown inside the free‑text field.
   - **Add other values to allowed values** *(List fields only, on by default)* —
     when a user types a value in "Other", add it to the field's allowed‑values list;
     turn it off to keep the list fixed while still storing the typed value on that
     item.

For an **entity‑reference or taxonomy** field, the "Other" option only appears when
the field is configured to *create referenced entities if they don't already exist*
(auto‑create) **and** the user has permission to create them. When both are true,
typing a new value in "Other" auto‑creates the referenced entity on submit. If the
user lacks create access, the "Other" option is hidden automatically.

### As a Forms API element (for developers)

In a custom form you can use either element type directly:

```php
$form['options'] = [
  '#type' => 'select_or_other_select',   // or 'select_or_other_buttons'
  '#title' => $this->t('Options'),
  '#options' => [
    'value_1' => $this->t('One'),
    'value_2' => $this->t('Two'),
  ],
  '#multiple' => TRUE,
];
```

`select_or_other_select` renders a `<select>`; `select_or_other_buttons` renders
radios (single value) or checkboxes (multi‑value). Properties such as
`#other_option`, `#other_field_label`, `#other_placeholder`, `#merged_values` and
`#no_empty_option` let you tune the labels and the returned value shape — see the
sibling [`agent/`](../agent/start.md) docs for the full list.
