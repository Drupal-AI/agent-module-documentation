# CMRF Reference Field — manual setup guide

**CMRF Reference Field** (`cmrf_reference`) adds new **Webform elements** that
reference live **CiviCRM** data through a **CiviMRF / CMRF** connection. Instead
of hard-coding a list of options into a form, you add a CMRF Reference element
that queries CiviCRM as the user types — an autocomplete contact picker, a
membership-type selector, or any other input whose choices should come straight
from your CRM.

It provides two element types: a **CMRF Reference** autocomplete (the user types
and sees matching CiviCRM records) and a **CMRF Radios** variant (the CiviCRM
matches rendered as radio buttons). Both keep CiviCRM as the single source of
truth, so the form always reflects current CRM data rather than a stale copied
list.

The autocomplete runs server-side: as the visitor types, the browser calls an
endpoint that looks matches up through the CMRF connection and returns them as
JSON. That endpoint's access is tied to the ability to view the Webform's
submission page, so it is only as open as the form itself. Queries go through the
CMRF connection abstraction rather than being built from raw SQL.

It depends on **Webform** and **CMRF Core** (`cmrf_core`), and it needs a
configured CiviMRF connection plus a CiviCRM data processor or search to
reference. There is no site-wide settings page — you configure everything on the
individual Webform element.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Webform / CMRF Core dependencies.

There is **no configuration page** for this module. You add and configure its
elements directly on a Webform, as described in "How to use it" below.

## How to use it

1. Make sure **CMRF Core** has a working **CiviMRF connection**, and that CiviCRM
   has the **data processor or search** you want to reference (permissioned
   appropriately on the CiviCRM side).
2. Edit a Webform and, in the element list, add a **CMRF Reference** (autocomplete)
   or **CMRF Radios** element.
3. On the element, choose the **connection**, the **data processor / search**,
   the **display field** (the human-readable label shown to users), and the
   **return field** (the value actually stored in the submission).
4. Optionally set the **autocomplete match length** (minimum characters before a
   lookup runs, default 3) and the **result limit** (maximum suggestions,
   default 10).
5. Test the element on a draft Webform before exposing it publicly, and confirm
   the CiviCRM data processor only returns records you intend visitors to see —
   the autocomplete reflects whatever CiviCRM is allowed to return.
