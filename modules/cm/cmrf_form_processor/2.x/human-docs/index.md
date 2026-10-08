# CiviMRF Form Processor — manual setup guide

**CiviMRF Form Processor** (`cmrf_form_processor`) connects Drupal's Webform
module to **CiviCRM's Form Processor**. When someone submits one of your
Webforms, this module forwards the submitted values to CiviCRM's Form Processor
over a **CiviMRF** (CiviCRM REST framework) connection — so a contact form,
event sign-up, or donation intake collected in Drupal lands directly in your
CRM without any copy-and-paste or nightly batch job.

It solves the classic "our website and our CRM don't talk to each other"
problem for organisations that run CiviCRM alongside Drupal. Instead of exporting
Webform results and importing them into CiviCRM, you attach a Form Processor
handler to a Webform and the data flows through automatically. Because it forwards
what people type into your forms — names, email addresses, and whatever else the
form asks for — the data it carries is **personal data**, and the CiviMRF
connection credentials it uses are **secrets** worth protecting.

The module needs configuration before it does anything: you must have a working
CiviMRF connection (set up in the **CMRF Core** module, `cmrf_core`) and a Form
Processor defined in CiviCRM, then map your Webform to it. It ships two optional
submodules: **CiviMRF Form Processor Display** (`cmrf_form_processor_display`)
and **CiviMRF Form Processor Mollie** (`cmrf_form_processor_mollie`), which adds
Mollie payment handling — and with payment come the usual payment-security
considerations.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its Webform / CMRF Core dependencies, and pick the submodules you
   need.

There is **no central settings page** for this module. Configuration happens on
each Webform by adding a Form Processor handler, as described in "How to use it"
below.

## How to use it

1. First make sure **CMRF Core** (`cmrf_core`) has a working **connection** to
   your CiviCRM backend — that is where the CiviMRF credentials live, and this
   module cannot reach CiviCRM without it.
2. In CiviCRM, define the **Form Processor** you want the Webform to feed.
3. In Drupal, open the Webform you want to wire up and go to its **Settings →
   Emails / Handlers** (or **Handlers**) tab.
4. Add the CiviMRF Form Processor handler, choose the CiviMRF connection and the
   target Form Processor, and map each Webform element to the matching Form
   Processor field.
5. Submit a test entry and confirm it arrives in CiviCRM before going live.

> **Handle submissions as sensitive data.** The values flowing to CiviCRM are
> personal data, so keep the CiviMRF connection credentials secure and confirm
> exactly which fields are forwarded, in line with your consent and
> data-protection obligations.
