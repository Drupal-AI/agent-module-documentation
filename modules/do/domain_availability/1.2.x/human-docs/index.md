# Domain Availability — manual setup guide

**Domain Availability** (`domain_availability`) checks whether a domain name is
registered — across many top-level domains at once — in a single parallel sweep.
It queries **RDAP** first and falls back to **WHOIS**, and it is deliberately
careful never to guess: a lookup that no authority can answer is reported as
**"unknown"**, never as "available". So every check returns one of three honest
states — available, registered, or unknown.

Despite the name, this module is unrelated to the Domain Access ecosystem: it is
a web-services integration for *domain-name registration lookups*, not a
multi-site tool. It provides an **API endpoint** (`/domain-check`), a **search UI**
(`/domain-search`), a **health endpoint** (`/domain-check/health`), an optional
**pricing** layer, and an optional **domain-registration request workflow**.
Availability providers and pricing strategies are pluggable via service tags, so
developers can add their own lookup backends or pricing models.

The module is built defensively, which is worth knowing when you plan who can use
it. Its routes are each gated by dedicated permissions — **use domain
availability api**, **access domain availability search**, and **administer domain
availability** — plus three more for the registration requests. All input is
reduced to a bare domain label before any network call, and requests are
rate-limited per client IP so the outbound lookups cannot be abused. Note that the
module is **not covered by Drupal's security advisory policy**, so weigh that
against your site's risk tolerance.

Two practical requirements: it needs **PHP 8.3 or newer**, and it needs
**outbound network access** so it can reach RDAP and WHOIS servers (it discovers
the right servers from the IANA bootstrap and caches them). It has a real settings
form where you configure providers, cache TTL and rate limits before going live.

**About version 1.2.0:** this release adds **Drupal 12 compatibility** on top of
the existing Drupal 10.3 and 11 support. It is a compatibility and refactor
release — there is no change to how the module behaves, and upgrading from 1.1.x
needs no database update.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, satisfy the
   dependencies, enable it, and set permissions.
2. [Configuration](configuration/index.md) — the settings form: providers, cache
   TTL and rate limits.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Domain availability**. The
user-facing pieces are the search UI at `/domain-search` and the JSON lookup API
at `/domain-check`, with a search block also available for placement.
