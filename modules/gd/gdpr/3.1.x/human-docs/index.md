# General Data Protection Regulation (GDPR) — manual setup guide

**General Data Protection Regulation** (`gdpr`) is an umbrella toolkit that helps
you make a Drupal site GDPR‑compliant. It's important to set expectations up front:
installing this module does **not** make your site compliant on its own — it's a
set of tools and a guided checklist that help *you* do the work. Compliance is a
legal and organizational responsibility; this module gives you the Drupal pieces to
support it.

The base module is mostly orientation and glue. It gives you three things: a
**self‑assessment checklist** (built on the Checklist API) that walks a site owner
through responsibility acknowledgements, policy and content checks, feature reviews,
and configuration steps — reporting progress on the site's Status Report; a
**Content links** form where you record the URLs of your Privacy policy, Terms of
use, About us, and Impressum pages (per language), which the checklist then uses to
confirm those pages exist; and a per‑user **"All your data"** page that gives each
user a single place to reach their data requests or consents.

The real functionality lives in five submodules, which together cover the classic
GDPR workflows — **consent**, **subject access requests**, and the **right to be
forgotten (RTBF)**:

- **GDPR Fields** (`gdpr_fields`) — mark which entity fields hold personal data, and
  set how each is treated for Right‑to‑Access and Right‑to‑be‑Forgotten (e.g. which
  anonymizer to apply).
- **Anonymizer** (`anonymizer`) — a plugin system that anonymizes personal values,
  used by the fields and tasks workflow.
- **GDPR Consent** (`gdpr_consent`) — versioned consent agreements and a consent
  field, so you can record what each user agreed to and when.
- **GDPR Tasks** (`gdpr_tasks`) — the request workflow: process a **Subject Access
  Request** (export everything you hold about a person) and a **Right‑to‑be‑
  Forgotten** removal (anonymize their data), as trackable task entities.
- **GDPR Dump** (`gdpr_dump`) — a Drush command that produces anonymized SQL dumps,
  so you can share a sanitized database with developers.

It requires the **Checklist API** module plus several contrib modules and PHP
libraries (see [Installation](installation/index.md)).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the suite with Composer, enable
   the base module, and pick the submodules you need.
2. [Configuration](configuration/index.md) — the compliance checklist, the Content
   links form, the "All your data" user page, and permissions.

## Where it lives in the admin menu

Everything lives under **Configuration → GDPR** (`/admin/config/gdpr`):

- **The checklist** at `/admin/config/gdpr/checklist` — this is the module's main
  configure page.
- **Content links** at `/admin/config/gdpr/content-links`.

Individual users reach their own data via the **All your data** tab on their profile
(`/user/{user}/gdpr`).

## How to use it

1. Install the suite and enable the base module plus the submodules matching the
   workflows you need (consent, tasks/RTBF, fields, dump).
2. Work through the **checklist** at `/admin/config/gdpr/checklist`, ticking off each
   item as you address it.
3. Record your policy page URLs on the **Content links** form so the checklist can
   verify them.
4. Configure the submodules — mark personal‑data fields, define consent agreements,
   and set up the task workflow — to actually handle consent and subject requests.
