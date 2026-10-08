# Hospital Price Transparency — manual setup guide

**Hospital Price Transparency** (`hospital_price_transparency`) helps US hospitals
meet the machine‑readable‑file (MRF) requirements of the Centers for Medicare &
Medicaid Services (CMS) price‑transparency rules. It gives you a purpose‑built
content entity — an **HPT** entity — that holds a single standard‑charges file
(CSV, JSON, or XML) plus the metadata CMS asks for, and it publishes that file at
a public URL using the naming convention CMS mandates.

Each HPT entity has a required file field (limited to the allowed formats), plus
required **EIN** and **hospital name** fields. The module uses those values to
build a path alias in the CMS‑mandated form
`[ein]_[hospitalname]_standardcharges.[json|csv]`, and when someone visits the
entity it serves the file's contents directly — so linking to the file is as simple
as linking to the entity. For very large files there is zip‑upload support. The
entities are compatible with the common sitemap modules, so the file can be found
by automated searches.

Viewing a published HPT file requires only the standard **access content**
permission, which anonymous visitors have by default — that's deliberate, because
CMS requires the information to be reachable free of charge, without registration,
and without submitting any personal information.

> **A note on scope:** this module makes the *technical* requirements easier to
> meet. The maintainers do not claim that installing it fulfils any hospital's
> legal obligations — always confirm your setup against current CMS guidance.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside its core dependencies.
2. [Configuration](configuration/index.md) — the module settings (allowed file
   types), permissions, and how to create and publish an HPT file.

## Where it lives in the admin menu

You work with this module in two ways: the module's **settings** (where you can
adjust the allowed file extensions) and the **HPT content entities** you create and
publish. The exact settings path is shown on the module's help/description; the
day‑to‑day task is creating an HPT entity, attaching the charges file, and filling
in the EIN and hospital name so the mandated public path is generated.

## How to use it

1. Create an **HPT entity** and upload your standard‑charges file (CSV, JSON, or
   XML — or a zip for very large files).
2. Fill in the required **EIN** and **hospital name** fields; the module uses these
   to build the CMS‑required path alias automatically.
3. Publish the entity. Its canonical URL now serves the file's contents directly.
4. Link to it from a publicly available page, and add it to your sitemap so
   automated searches can find it.
