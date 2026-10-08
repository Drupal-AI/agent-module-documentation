<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Crawler (simple_crawler) — agent index

Fetches website data via **cURL**, crawling links (from an entity field) in a batch. Version
**1.0.0-beta2**.

**SSRF surface:** the server fetches URLs — if the crawled URLs come from **user-controlled content**,
a submitter can steer the server to internal services. Batch is admin-triggered (limits initiation),
but **validate/allow-list** URLs from untrusted fields. Confirm cURL uses **TLS verification**; handle
failures.