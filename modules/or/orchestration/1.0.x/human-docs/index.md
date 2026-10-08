# Orchestration — manual setup guide

**Orchestration** (`orchestration`) connects your Drupal site to **external
automation platforms** and lets them drive Drupal. It exposes Drupal's capabilities
as a unified API so an outside system can trigger Drupal workflows, call Drupal AI
agents, and run business logic — and it works both ways: external platforms can
invoke Drupal functions, and Drupal events (content updates, user registrations, form
submissions, and so on) can flow out to trigger work elsewhere.

The point is to build end‑to‑end automated processes that span Drupal and external
services — CRMs, email platforms, spreadsheets, and hundreds of other tools. For
example, when a visitor submits a contact form, an automation platform could add them
to a CRM, send a personalised email, open a support ticket, and update a spreadsheet,
all without custom code. At this version the module works with **Activepieces**, with
support for platforms like n8n and Zapier noted as a future direction.

Orchestration ships as a base module plus a set of submodules you enable as needed:

- **`orchestration_ai_agents`** — makes Drupal AI agents callable from external
  platforms.
- **`orchestration_ai_function`** — exposes AI functions.
- **`orchestration_eca`** — lets ECA workflows be triggered from outside Drupal.
- **`orchestration_tool`** — lets tool plugins be invoked remotely.

Treat this as a powerful integration and automation feature. It connects to external
platforms with **credentials** (store those as secrets, over HTTPS), and the AI / ECA
/ tooling submodules **execute automations and actions with the site's own
privileges** and can reach out to external services (AI functions, for instance, send
data to external LLMs). Restrict who can configure orchestrations to trusted
administrators. See [Configuration](configuration/index.md) for the details.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the base
   module plus the submodules you need.
2. [Configuration](configuration/index.md) — connect an external platform, store its
   credentials as secrets, enable the right submodules, and lock down who can
   configure orchestrations.

## Where it lives in the admin menu

Orchestration provides its own permissions and connects to external platforms. Which
admin surfaces appear depends on which submodules you enable (AI agents, AI functions,
ECA, tools). Start with the permissions and platform connection covered in
[Configuration](configuration/index.md).
