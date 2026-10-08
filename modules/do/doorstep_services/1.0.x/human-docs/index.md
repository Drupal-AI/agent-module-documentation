# Doorstep Services — manual setup guide

**Doorstep Services** (`doorstep_services`) is a small platform that lets a site
offer at‑home ("doorstep") services and take customer registrations for them.
Visitors register service requests through a front‑end form and receive email
notifications about their requests; they can view, edit, and cancel their own
requests. Administrators can update the status of each request, filter requests by
status, and generate PDF bills that are emailed to both the customer and a copy to
the admin.

It is aimed at service‑business sites that need a straightforward request‑and‑track
workflow rather than a full e‑commerce system. It depends on core **Node**,
**User**, and **Views**, and — because of its email and PDF features — it also
needs the contributed **SMTP** module and the **TCPDF** PHP library
(`tecnickcom/tcpdf`) to be present. It runs on Drupal 10 and 11, provides its own
permissions, and is not covered by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   satisfy the SMTP and TCPDF requirements, and enable it.

The module does not expose a single admin settings form; you work with it through
the request pages described below, so there is no separate Configuration page in
this guide.

## Where it lives in the admin menu

Doorstep Services works through a handful of paths rather than one settings
screen:

- **`/doorstep-services/register`** — the public page where a customer registers a
  service request.
- **`/user-requests`** — where a logged‑in customer views (and edits or cancels)
  their own requests.
- **`/admin/service-requests`** — the administrative listing of all service
  requests, where staff update statuses and filter by status type.

## How to use it

1. Make sure the **SMTP** module is installed and configured so the module's
   notification and bill emails can actually be sent, and that the **TCPDF**
   library is available for PDF bill generation.
2. Grant the module's permissions to the appropriate roles (customers who may
   register requests, and staff who may manage them) on **People → Permissions**.
3. Point customers to **`/doorstep-services/register`** to submit a request. They
   will receive email notifications and can manage their own requests at
   **`/user-requests`**.
4. Staff manage incoming requests at **`/admin/service-requests`** — updating
   status, filtering by status, and generating a PDF bill, which is emailed to the
   customer with a copy to the admin address.
