# RAIL Score — manual setup guide

**RAIL Score** (`rail_score`) integrates the **RAIL Score API** into Drupal to give
you an evaluation layer for responsible‑AI content governance. Content is scored
across the eight RAIL dimensions — Safety, Privacy, Fairness, Transparency,
Reliability, Accountability, Inclusivity, and User Impact — automatically on save,
with configurable thresholds, compliance checks, incident tracking, and a built‑in
human‑review queue.

The module scores content by sending it to the external RAIL Score service. It offers
two evaluation modes — **Basic** (fast, low‑cost scoring on every save) and **Deep**
(per‑dimension explanations, issue tags, and improvement suggestions) — and lets you
set an evaluation **context** (domain such as healthcare/finance/legal, and use case
such as chatbot or summarization). It can also run **regulatory compliance** checks
against frameworks like GDPR, CCPA, HIPAA, the EU AI Act, and India's DPDP. A single
dashboard at **`/admin/reports/rail-score`** shows account usage, local evaluation
statistics, recent evaluations, telemetry, open incidents, and the pending review
queue, with inline actions to acknowledge/resolve incidents and mark reviews done.

Two optional integration points appear when the Drupal **AI** module is installed and
enabled in settings: automatic scoring of every response from a registered AI provider
(via an event subscriber), and an AI Automators plugin that scores generated field
values before they are written, with an optional block‑on‑low‑score setting. Both are
fully optional and add zero overhead when the AI module is absent. A field formatter
can also display stored RAIL scores on decimal/float/integer fields as a badge,
progress bar, text, or a full per‑dimension breakdown.

> **Data egress and secrets:** scoring sends content to the external RAIL Score
> service, so confirm that outbound flow is acceptable for the content involved. The
> RAIL Score API key is a credential — store it securely and never commit it (see
> "Setting it up" below).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

The RAIL Score dashboard is at **Reports → RAIL Score**
(`/admin/reports/rail-score`), where you monitor evaluations, telemetry, incidents,
and the human‑review queue.

## Setting it up

1. Get a **RAIL Score API key** from responsibleailabs.ai.
2. Provide the API key to the module through its settings, and store it as a secret
   rather than committing it. On DDEV, the built‑in dotenv helper keeps it out of the
   repo:

   ```bash
   ddev dotenv set .ddev/.env --rail-score-api-key='your-key'
   ddev restart
   ```

   (`.ddev/.env` must stay out of version control.) Where possible, reference the key
   through a **Key** entity backed by that environment variable.
3. Choose the evaluation **mode** (Basic or Deep), the **context** (domain and use
   case), any **compliance** frameworks to check, and the per‑dimension **thresholds**
   below which content is queued for human review.
4. Optionally enable the Drupal **AI** module integration in settings to score AI
   provider responses and generated field values automatically.
5. Add the RAIL Score **field formatter** to a decimal/float/integer field if you want
   to display stored scores on the entity.
