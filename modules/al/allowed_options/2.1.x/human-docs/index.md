# Allowed Options — manual setup guide

**Allowed Options** (`allowed_options`) lets you show only a **subset** of a
list/options field's choices on a particular form, without changing the field
itself. A list field's allowed values are defined once on the field storage and
shared everywhere the field is used — so normally, if you want one form to offer
fewer choices, you would have to clone the field. Allowed Options solves that per
form-display widget instead.

It adds an **Allowed options** checkboxes control to supported field widgets on
the **Manage form display** screen. You tick only the options that should appear
on that form, and at render time the module narrows the widget's choices down to
just those — keeping the empty "- None -" option where relevant. The full list of
options still lives untouched on the field storage; the restriction is purely
presentational and applies only to that form display.

This is handy for simplifying an editor form to a few relevant choices, offering
different subsets on different bundles, hiding deprecated or legacy options from
new content, or rolling out a new option to only some forms first — all without
duplicating fields or migrating data. It works on the standard list field types
(`list_string`, `list_integer`, `list_float`, and boolean-style options), and
only on real edit widgets, not the default-value widget.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no central settings page. You configure it on **Structure → Content
types → (your type) → Manage form display**, inside an individual field widget's
settings.

## How to use it

1. Go to **Manage form display** for the entity bundle.
2. Open the settings (the cog icon) of a supported list/options field widget.
3. Under **Allowed options**, tick only the options that should appear on this
   form, then **Update** and **Save**.
4. That form now offers just the ticked options; every other form or display of
   the same field keeps the full set.
