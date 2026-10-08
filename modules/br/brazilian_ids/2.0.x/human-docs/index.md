# Brazilian IDs — manual setup guide

**Brazilian IDs** (`brazilian_ids`) adds support for Brazil's identification
numbers to Drupal fields and forms. It provides widget options for CPF (the
individual taxpayer number), CNPJ (the company number), and a combined CPF/CNPJ,
which you can apply to text fields through the Field UI. It also ships matching
Form API element types, so the same input handling, validation, and formatting
are available on custom forms as well as on entity fields.

The point is correctness: CPF and CNPJ have specific formats and check digits,
and this module gives you proper input handling and validation for them instead
of a plain text box. Use it on Brazilian sites that collect these numbers on user
profiles, registrations, orders, or bespoke forms.

One thing to keep in mind: CPF and CNPJ are personal and tax data. Handle and
store them with appropriate privacy care. The module is a fields/forms feature
with no access-control role of its own.

There is nothing to configure at the module level — you choose the widget on the
relevant field. It supports Drupal 10 and 11.

This guide is written for a **human** setting the module up through the admin UI.
If you want a terse, token-cheap reference for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — installing with Composer and enabling
   the module.

## Where it lives in the admin menu

Brazilian IDs has no settings page of its own. You use it from the **Field UI**:
add or edit a text field on a content type (or other entity) under **Structure**,
and choose the CPF, CNPJ, or CPF/CNPJ widget. For custom forms, developers use
the Form API element types the module registers.

## How to use it

For content, add a text field to your entity and select one of the module's
widgets — CPF, CNPJ, or combined — on the form display. The field then validates
and formats the identifier as it is entered. For custom forms, use the matching
Form API element type in your form definition to get the same handling. Because
these are tax identifiers, make sure your privacy notices and data handling cover
them.
