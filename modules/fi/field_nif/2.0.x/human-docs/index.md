# Field NIF — manual setup guide

**Field NIF** (`field_nif`) adds a dedicated **NIF/CIF/NIE** field type for
capturing Spanish administrative identification numbers — NIF for individuals, CIF
for companies, and NIE for foreign residents. It validates both the format and the
check digit of whatever is entered, so an invalid number simply cannot be saved,
and it stores the value **split into its parts** (first letter, number, last /
control letter, and the detected type) rather than as one opaque string. That means
your formatters and any downstream code can display or process the components
independently.

The module ships everything you need to use the field end to end: a default
**widget** for entering the number, a default **formatter** that renders it (and
HTML-escapes the value on output for safety), a Form API `nif` render element for
use in custom forms, and a **Webform** element plugin so the same validated input
can be collected in Webforms. All of these share one validation implementation, so
entity fields, plain form elements, and Webform submissions all enforce exactly the
same rules.

It is a straightforward field type: enable the module, add a NIF/CIF/NIE field to
any fieldable bundle, and configure its widget and formatter the way you would for
any other field. There is no special settings page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated configuration page** for this module. You add and configure
the field per bundle from the standard Field UI, as described below.

## Where it lives in the admin menu

Field NIF adds no admin page of its own. You use it from **Structure → Content
types (or any entity bundle) → *(bundle)* → Manage fields** (to add the field) and
**Manage display** (to choose the formatter).

## How to use it

1. Go to a bundle's **Manage fields** and click **Add field**.
2. Choose the **NIF/CIF/NIE** field type, give it a label, and save.
3. Configure the field's widget and formatter as usual on **Manage form display**
   and **Manage display**. The default formatter renders the stored value with the
   output safely escaped.
4. When editors fill the field in, the entered number is validated on save — an
   invalid NIF, CIF, or NIE is rejected — and the valid value is stored split into
   its letter/number/control-letter/type components.

To collect the same validated identifier in a Webform, add the module's
**NIF/CIF/NIE** Webform element to your form; it applies the identical validation.
Developers who need the identifier in a custom form can use the `nif` render
element — see the sibling [`agent/`](../agent/start.md) docs for the API details.

> **Note:** These are personal / tax identifiers. Handle and store them with
> appropriate privacy care.
