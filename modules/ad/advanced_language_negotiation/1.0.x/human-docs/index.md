# Advanced Language Negotiation — manual setup guide

**Advanced Language Negotiation** (`advanced_language_negotiation`) extends how
Drupal decides which **language** a visitor sees. Where core generally negotiates
language by a single method, this module lets the active language be derived from
a **combination of domain and URL path prefix** — so a multilingual, multi-domain
site can map languages by domain *and* by path prefix together (for example a
primary language per domain, plus sub-language paths beneath it).

It is a multilingual / routing feature: it only affects which language is active
for a request. It does not change content or access, and has no role in access
control.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enable the negotiation method and
   set the domain / path-prefix rules.

## Where it lives in the admin menu

The module adds its negotiation capability to Drupal's language detection system.
You configure it under **Configuration → Regional and language → Languages →
Detection and selection**
(`/admin/config/regional/language/detection`), together with the per-language
domain and path-prefix settings on the Languages page.
