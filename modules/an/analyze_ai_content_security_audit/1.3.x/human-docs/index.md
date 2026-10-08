# Analyze AI Content Security Audit — manual setup guide

**Analyze AI Content Security Audit** (`analyze_ai_content_security_audit`) is a
submodule of the [Analyze](https://www.drupal.org/project/analyze) content-analysis
framework. It uses an AI provider to read your content and flag when sensitive data
may have slipped into it — personal information (PII) or exposed credentials such as
API keys and passwords. Each piece of content gets a risk score from 0 to 100 for
every "security vector" you have enabled, shown as an easy-to-read gauge on the
entity's Analyze report.

Behind the scenes the module renders an entity, strips the markup, builds a prompt
describing each security vector, and asks your site's default chat AI provider for a
risk score. The results are cached in a custom database table and keyed to the exact
content and configuration, so a piece of content is only re-scored when it actually
changes or when you change a vector's setup. Two vectors ship enabled out of the box —
**PII disclosure** and **Credentials disclosure** — and you can add, edit, or delete
your own.

Because the module sends your rendered content to an external AI provider, only enable
it where sending content off-site is acceptable for your organization. The scores are
advisory: treat them as a triage aid for editors, not a guarantee.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its dependencies
   with Composer, then enable it.
2. [Configuration](configuration/index.md) — connect an AI provider, enable the
   analyzer per content type, and manage your security vectors.

## Where it lives in the admin menu

The security-vector management screens live at **Configuration → Analyze → Content
security audit** (`/admin/config/analyze/content-security-audit`). Per-content-type
enablement is handled from the Analyze settings at
`/admin/config/content/analyze-settings`, and the AI provider is chosen at
`/admin/config/ai/providers`. All of the module's own screens require the Analyze
permission **Administer analyze settings**.

## How to use it

Once an AI provider is configured and the analyzer is enabled for a content type, open
any node of that type and look at its **Analyze** report tab. You will see a summary
gauge (the highest risk score across all vectors) and, in the full report, one gauge
per enabled vector. A Views-powered dashboard lists audited content with color-scaled
gauges so you can quickly spot and triage the highest-risk items.
