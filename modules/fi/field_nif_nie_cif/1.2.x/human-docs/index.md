# Spain NIF, NIE and CIF Field — manual setup guide (1.2.x)

**Spain NIF, NIE and CIF Field** (`field_nif_nie_cif`) provides a Drupal field type
for entering and validating Spanish identification numbers: **NIF** (individual tax
ID), **NIE** (foreign-resident ID), and **CIF** (company ID). It checks each
identifier's format and control character, so malformed or wrong-checksum numbers
can't be saved. It validates the *structure* of the number — it does not confirm
that an identifier has actually been issued or that it belongs to a particular
person or organization.

This 1.2.x release ships a complete, well-defined set of plugins: a `nif_nie_cif`
**field type** that stores a `type` (NIF / NIE / CIF) plus the `number`, a
`nif_nie_cif_default` **widget** and **formatter**, and a `NifNieCif` **validation
constraint** that runs through Drupal's validation API — so forms, JSON:API, and any
other entity validation all report the same errors. Input is **normalized**
automatically: it is uppercased and stripped of spaces, dots, and hyphens, so
`12.345.678-Z` or `B 99286320` are accepted and stored canonically. Editors get
accessible live feedback as they type.

The widget gives site builders two useful controls: which identification types are
**allowed** in a field, and whether to show a single **auto-detect** input instead
of a separate type selector. There is also an optional **Webform** submodule
(`field_nif_nie_cif_webform`) that adds a matching element which always auto-detects
and normalizes the value.

The module depends only on Drupal core's **Field** module (plus Webform for the
optional submodule) and requires **PHP 8.1 or later**. It has no access-control
role — validation applies to the identifier itself.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and optionally add the Webform submodule.
2. [Configuration](configuration/index.md) — the per-field widget settings
   (`allowed_types` and `auto_detect`) on Manage form display.

## Where it lives in the admin menu

The module adds **no admin settings page**. You add and configure the field per
bundle from **Structure → Content types (or any entity bundle) → *(bundle)* →
Manage fields** and its **Manage form display** / **Manage display** screens.

> **Note:** NIF/NIE/CIF numbers are personal / tax data. Handle and store them with
> appropriate privacy care.
