# AI Provenance — manual setup guide

**AI Provenance** (`ai_provenance`) records and shows how much AI contributed to a
piece of content — and by which model and provider — down to the individual
entity, revision, and field. It then renders a **transparency badge** that is both
human-visible and machine-readable, so readers (and auditors) can see whether text
was AI-generated, AI-assisted, human-reviewed, or human-written.

The motivation is compliance and trust. The EU AI Act's text-transparency
obligations (effective August 2026) require AI-generated content to be labelled,
and disclosing AI involvement is fast becoming an editorial baseline regardless.
Existing Drupal tooling mostly signs media and images; this module fills the gap
for node/field-level editorial *text*. It complements `ai_decision_log` (which
records *why* something was decided) by recording *what* was AI-produced.

Rather than adding disclosure fields to every content type, it stores provenance
in a dedicated `ai_provenance_record` content entity. That gives you one queryable
store with per-revision and per-field detail, and lets you apply access control to
the provenance data independently of the content it describes. It calls no AI
provider and stores no API keys — it only records and displays provenance.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose which entity types are
   tracked, understand the disclosure gradient, and manage records.

## Where it lives in the admin menu

- **Settings:** **Configuration → AI → AI provenance**
  (`/admin/config/ai/provenance`), gated by the restricted **Administer AI
  provenance** permission.
- **Records:** **Reports → AI provenance** (`/admin/reports/ai-provenance`), also
  admin-gated.
- **Front-end badges:** shown to users who have the separate **View AI
  provenance** permission.

## How to use it

Decide which entity types you want to track, then let the module record the AI
disclosure level (generated / AI-assisted / human-reviewed / human-written) for
each entity, revision, and field. Publish the transparency badge to your readers,
and use the records collection as evidence for auditors or regulators.
