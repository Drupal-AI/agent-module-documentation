# Spain NIF, NIE and CIF Field — manual setup guide (1.0.x)

**Spain NIF, NIE and CIF Field** (`field_nif_nie_cif`) provides a Drupal field type
for entering and validating Spanish identification numbers: **NIF** (individual tax
ID), **NIE** (foreign-resident ID), and **CIF** (company ID). It checks each
identifier's format and control character on entry, so malformed or wrong-checksum
numbers can't be saved. It validates the *structure* of the number — it does not
confirm that an identifier has actually been issued or that it belongs to a
particular person or organization.

Beyond plain validation, the field is friendly to editors: site builders can choose
which of the three identification types editors are allowed to enter, an optional
**smart mode** detects the type automatically from a single input, and the field
accepts lowercase input and common visual separators (spaces, dots, hyphens) while
storing the value in a clean canonical uppercase form. Manual type selection
remains the default for backward compatibility. There is also an optional
**Webform** integration submodule (`field_nif_nie_cif_webform`) that adds a
matching Webform element which auto-detects, validates, and normalizes the value.

The module depends only on Drupal core's **Field** module (plus Webform for the
optional submodule). It has no access-control role — validation applies to the
identifier itself.

> **This is the 1.0.x line.** A newer **1.2.x** release refines the widget settings
> and documentation; if you are choosing a version for a new site, see that
> release's guide. This page documents 1.0.x specifically.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and optionally add the Webform submodule.
2. [Configuration](configuration/index.md) — the per-field widget options (allowed
   types and smart detection) on Manage form display.

## Where it lives in the admin menu

The module adds **no admin settings page**. You add and configure the field per
bundle from **Structure → Content types (or any entity bundle) → *(bundle)* →
Manage fields** and its **Manage form display** / **Manage display** screens.

> **Note:** NIF/NIE/CIF numbers are personal / tax data. Handle and store them with
> appropriate privacy care.
