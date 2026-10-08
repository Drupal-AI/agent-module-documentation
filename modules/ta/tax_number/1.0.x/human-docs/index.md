# Tax Number — manual setup guide

**Tax Number** (`tax_number`) gives you a proper field type for storing tax and
VAT numbers, plus a matching Webform element, with a plug‑in validation system
so each country's number format can be checked by its own rules. Different
countries format their tax identifiers differently — a Spanish NIF/CIF is not
shaped like a Portuguese NIF — and this module lets you validate the right
format at the point of data entry instead of accepting whatever gets typed in.

Out of the box it provides a `tax_number` field type (with a widget and a
default formatter for display) and a `WebformTaxNumber` element, so the same
validation works whether you are collecting the number on a content type or on a
webform. Validation itself is delegated to pluggable validators. The module
ships three: a **default** validator that stores any value without a
country‑specific check, an **es** validator for Spanish NIF/CIF (with letter and
checksum checks), and a **pt** validator for the Portuguese NIF. You pick which
one applies on a per‑field basis in the form‑display widget settings, or per
element in the webform element settings.

There is no admin settings page and no anonymous‑facing HTTP surface to worry
about: the validation is pure, local PHP (regex and checksum logic) with no
external service calls or network requests, and the module requires nothing
outside Drupal core. Developers who need another country can add support by
writing a small validator plugin — see the sibling agent doc
[`agent/plugins/validator.md`](../agent/plugins/validator.md) for the code
pattern. Its Composer package (`drupal/tax_number`) matches the module machine
name (`tax_number`). It works on Drupal 8, 9, 10 and 11.

This guide is written for a **human** setting the site up through the admin UI.
If you are an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is nothing to configure globally; you use Tax Number by adding a field or
a webform element.

- **On a content type (or any fieldable entity):** add a new field of type
  **Tax number**. Then go to **Manage form display** for that bundle and open
  the tax‑number widget's settings — there you choose which validator to apply
  (default, Spanish, Portuguese, or a custom one). The bundled formatter renders
  the stored number on **Manage display**.
- **On a webform:** add the **Tax number** element to the form, and choose the
  validator in the element's settings.

Validation runs when the form is submitted: a value that fails the chosen
validator is rejected as an invalid entry, exactly like any other field or
element validation error.
