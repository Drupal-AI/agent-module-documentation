# Accessible Autocomplete Element/Widget — manual setup guide

**Accessible Autocomplete Element/Widget** (`a11y_autocomplete_element`) replaces
plain select dropdowns with an accessible, type-to-filter autocomplete. Long
`<select>` lists are awkward for everyone and genuinely hard for people using a
keyboard or a screen reader; this module offers a drop-in alternative that lets
users type to narrow the options while staying friendly to assistive
technology.

It comes in two forms. As a **Form API element** you can use it in custom forms
where you'd otherwise reach for a select. As a **field widget** you can apply it
to Options fields (list fields) so content editors get the autocomplete instead
of a dropdown. Either way the values stored are exactly the field's normal
allowed options — the module only changes how the choice is made, not what gets
saved.

This is purely an input and accessibility enhancement: it has no access-control
role, no permissions, and no settings form. It depends on core's **Options**
module. You enable it, then select the widget on a field's form display or use
the element in your own form code.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

To swap a dropdown for the accessible autocomplete on a field:

1. Enable the module (see [Installation](installation/index.md)).
2. Go to the entity's **Manage form display** screen.
3. Find your Options / list field and change its **Widget** to the accessible
   autocomplete widget, then **Save**.

Editors now type to filter the field's allowed values instead of scrolling a
long select, and keyboard and screen-reader users get a properly accessible
experience. Developers building custom forms can use the module's autocomplete
as a Form API element in place of a `select`; see the
[`agent/`](../agent/start.md) docs for the element details.
