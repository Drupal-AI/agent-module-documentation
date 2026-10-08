# PDF Services — manual setup guide

**PDF Services** (`pdf_services`) connects Drupal to the **Adobe PDF Services API**
so that PDFs uploaded to your site can be automatically analysed, accessibility‑
checked, and optimised. It is aimed at organisations — government, education, and
anyone with a compliance obligation — that need their published PDFs to be
accessible and lean without a lot of manual work. The module is maintained by the
City of Tampa web development team.

Once configured, PDF Services can extract document properties (page count, size,
structure), validate PDFs against the **PDF/UA** accessibility standard and produce
detailed reports with remediation suggestions, and compress/linearise files to
reduce their size. It can optionally **block** an upload that fails accessibility
checks (with a separate permission to record a justification for exemptions),
embed PDFs on the page with a rich Adobe viewer, process files asynchronously via
Drupal's queue, notify editors by email when issues are found, and expose results
to Views. Processing settings can be tuned per field, so different content types
can be handled differently.

Two things are important to understand before you rely on it. First, this module
**uploads your PDFs to Adobe's cloud service** for processing — that is outbound
data transfer to a third party, and PDFs can contain sensitive content, so confirm
this is acceptable for your data and disclose it in line with your privacy policy.
Serve your site over HTTPS. Second, it authenticates with **Adobe API
credentials** (a Client ID and Client Secret), which the module stores through the
**Key** module rather than in plain configuration — a good practice you should
follow by keeping the secret in an environment variable (see Installation).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and the Key dependency.
2. [Configuration](configuration/index.md) — enter your Adobe credentials, set
   processing options, enable per‑field processing, and monitor the queue.

## Where it lives in the admin menu

- Main settings and credentials: **Configuration → Content authoring → PDF
  Services** (`/admin/config/content/pdf-services`).
- Processing status and reports: the queue dashboard at
  `/admin/config/content/pdf-services/queue`.
- Per‑field processing options: on each file field's settings under **Structure →
  Content types → *(your type)* → Manage fields**.

See [Configuration](configuration/index.md) for the details.
