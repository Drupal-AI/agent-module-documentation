# AI Decision Log — manual setup guide

**AI Decision Log** (`ai_decision_log`) is a durable record of *why* changes were
made — for both human and AI-assisted decisions. The reasoning behind a change
usually evaporates once the change ships; this module captures it in an
ADR-style (Architecture Decision Record) format: what was decided, the context,
the alternatives considered, and what the decision relates to. Each entry is stored
as an `ai_decision` content entity so it becomes a permanent, queryable part of your
site's governance trail.

Each decision captures a title, summary, context, the decision itself,
alternatives, related items, source, and author. Related entities, config, or
modules are recorded as structured references. Your own code (or another module) can
create entries through the `ai_decision_log.writer` service, and the module ships an
admin report and a decisions list so auditors can browse the history. A notable
safety feature: the writer runs a redaction pass that strips API-key, token, and
password-like values out of decision text before it is stored, so secrets don't
accidentally end up in the log.

It is **standalone**: it needs no paid AI provider and has no hard dependency on any
sibling AI module — it works purely as a decision store. It is also the ready
integration point for **AI Policy Gateway**, which mirrors every policy decision
here for audit. All of its pages live under `/admin/reports` and are
permission-gated; there are no anonymous endpoints. It requires PHP 8.3+ and works
on Drupal 10.3+, 11, and 12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings page, the report and
   list pages, and the permission set.

## Where it lives in the admin menu

Everything sits under **Reports**:

- **Settings / overview:** `/admin/reports/ai-decisions` (requires **Administer AI
  decision log**).
- **Decisions report:** `/admin/reports/ai-decisions/report` (requires **View AI
  decision log reports**).
- **Decisions list:** the entity list builder, for browsing all recorded decisions
  (also **View AI decision log reports**).
