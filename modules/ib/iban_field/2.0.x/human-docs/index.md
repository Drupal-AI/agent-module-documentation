# IBAN Field — manual setup guide

**IBAN Field** (`iban_field`) gives you a proper input for collecting bank
account numbers. Instead of a plain text box where anyone can fudge a value,
it adds a field *widget* that presents the value as an IBAN input and checks,
when the form is submitted, that what was typed is a structurally valid
International Bank Account Number — the right country prefix, the right length,
and a matching checksum. Obviously wrong account numbers are rejected at entry
time rather than discovered later by a failed payment run.

The widget applies to ordinary text fields, so you are not adding a new field
*type* — the value is stored as normal text. The widget has just two settings,
**size** (how wide the input box is) and **placeholder** (example text shown in
the empty field), and both export cleanly as configuration. There is no
settings form, no permissions, and no Drush commands: you enable the module and
then choose the IBAN widget on a field's *Manage form display* screen.

A submodule, **Webform IBAN Field** (`webform_iban_field`), brings the same
capability to the Webform module, adding an IBAN element you can drop into any
webform. It has its own documentation.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and pick up the Webform submodule if you need it.

## How to use it

1. Add a plain **text** field to your content type, user account, or other
   entity in the usual way (*Manage fields → Add field*).
2. Go to that entity's **Manage form display** screen.
3. Find your text field and change its **Widget** to **IBAN Field**.
4. Click the widget's gear icon to set the **size** of the input and an optional
   **placeholder** (for example `NL91ABNA0417164300` to show editors the
   expected format), then **Update** and **Save**.

From then on, anyone editing that entity gets the IBAN input, and a mistyped or
structurally invalid account number is refused when they save the form.

One thing worth knowing: because the validation lives in the *widget*, values
written straight to the database, through migrations, or through REST/JSON:API
bypass the check. If you need the format enforced no matter how the value
arrives, add an entity-level constraint as well.
