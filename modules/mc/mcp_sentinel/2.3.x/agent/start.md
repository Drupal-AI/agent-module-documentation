<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Sentinel — agent index

**Enterprise governance for AI-agent access to Drupal** (policy profiles, field redaction, DLP, tamper-evident
audit logging, reliable webhooks) over MCP / JSON:API / GraphQL. Depends on `audit_chain`, `key`, `simple_oauth`,
`consumers`, `encrypt`, `tool`, `jsonapi`. Provides permissions. Version **2.3.0**. Core `^10.6||^11.3`.

**Security-positive** control plane — authenticates agents (Simple OAuth/Consumers), protects data (Key/Encrypt),
logs immutably (Audit Chain), redacts/DLP-filters fields. Protection depends on **policy configuration** (define
restrictive profiles, verify redaction coverage, secure keys, monitor the log).
