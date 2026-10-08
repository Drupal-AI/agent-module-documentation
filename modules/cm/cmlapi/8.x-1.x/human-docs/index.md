# CML API — manual setup guide

**CML API** (`cmlapi`) provides the CommerceML (CML) API layer that lets Drupal
exchange commerce data with **1C:Enterprise** systems. CommerceML is the XML
exchange standard used by 1C — a widely‑used (particularly in Russian‑speaking
markets) ERP/accounting platform — for syncing catalogs, products and orders. This
module implements the CML exchange protocol so a Drupal store can talk to 1C.

It's best thought of as **foundational plumbing** rather than a finished feature: it
creates a "CML" entity to record exchange information and provides an XML parser for
CommerceML. On its own it gives you the exchange machinery; in practice you pair it
with companion modules — most often [CML Migrations](https://www.drupal.org/project/cmlmigrations)
for the import side, and optionally [cmlexchange](https://www.drupal.org/project/cmlexchange)
for file exchange. It belongs to the `cml` package and provides its own permissions.

**A note on scope:** cmlapi itself does *not* expose the inbound HTTP endpoint that
1C connects to — that lives in the companion **cmlexchange** module — and it does not
create commerce products (that's **cmlmigrations**). cmlapi is the storage entity plus
the XML parser in the middle. Its own pages are admin-only inspection screens behind
the "view published cml entity entities" permission. When you build the full stack,
serve the 1C exchange (provided by cmlexchange) over **HTTPS**, protect the exchange
credentials, and grant the cml view/edit permissions only to accounts that need them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

CML API is an API/foundation module: it has no standalone settings form of its own —
the actual import behavior and configuration live in the companion modules (such as
CML Migrations). See "How to use it" below.

## How to use it

Install CML API as the base of a 1C:Enterprise ↔ Drupal integration, then add the
companion modules for the parts you need — typically CML Migrations for importing
catalog/product/order data, and cmlexchange for file exchange with 1C. Configure the
CML exchange through those modules, grant the exchange permission only to the 1C
integration account, and make sure the exchange endpoint is reachable only over
HTTPS.
