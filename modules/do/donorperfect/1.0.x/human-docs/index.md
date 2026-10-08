# DonorPerfect Base Module — manual setup guide

**DonorPerfect Base Module** (`donorperfect`) is the foundation for integrating
Drupal with [DonorPerfect](https://www.donorperfect.com), a fundraising and donor
management (CRM) platform for nonprofits. It makes DonorPerfect **Donors, Gifts,
Contacts, and Other Info** available inside Drupal as *remotely stored entities* —
the data itself stays in DonorPerfect and is queried live through the DonorPerfect
XML API, while Drupal keeps only a local cache of *metadata* about the available
fields. Those entities can then be used in Views or by custom modules.

On top of the entities it provides three developer‑facing conveniences: **Name,
Address, Email, and Phone form elements** (the Name element runs an AJAX search of
DonorPerfect and, when a match is picked, auto‑populates the address, email, and
phone fields); and a **DPQuery** object that custom modules can use to run any of
DonorPerfect's predefined XML API procedures or custom SQL queries against the
DonorPerfect database.

This is the *base* module — other DonorPerfect submodules (Donor, Gift, Contact,
Other Info) build on it. It requires a DonorPerfect account with XML API access
enabled, and you must supply API credentials — ideally an **API key** from your
DonorPerfect representative rather than a username and password. It depends on
core **Datetime** and **Options** plus the contributed **Entity API** and
**Address** modules, runs on Drupal 10 and 11, provides its own permissions
(`donorperfect user` and `donorperfect admin`), and is security‑advisory covered.

> **Data and privacy note.** This module sends queries to and receives donor
> personal data from an external service (DonorPerfect). Treat the API
> credentials as secrets (see [Configuration](configuration/index.md) for the
> recommended env‑backed storage), and be deliberate about where donor data is
> displayed — never expose private donor data through a publicly accessible View.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   satisfy its dependencies, and enable it.
2. [Configuration](configuration/index.md) — enter your API credentials, populate
   the metadata cache, and choose which DonorPerfect fields appear on your Drupal
   entities.

## Where it lives in the admin menu

The module's settings live at **`/admin/donorperfect/settings`**. This is where
you enter API credentials, populate the DonorPerfect metadata cache, and select
which DonorPerfect fields are exposed on the Drupal entities.

## How to use it

Once credentials are saved and the metadata cache is populated, you select which
DonorPerfect fields should be included on the Drupal entities, and those fields
become available when building Views or loading entities in custom modules. From
there you can build Views to display donor data (with appropriate access
restrictions) and write custom modules that use the provided form elements and the
DPQuery object. Grant the **Use DonorPerfect** permission to any Drupal user who
needs the Name‑element search functionality.
