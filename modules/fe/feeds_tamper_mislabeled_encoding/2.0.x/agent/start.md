<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Feeds Tamper Mislabeled Encoding (feeds_tamper_mislabeled_encoding) — agent index

**A single Feeds Tamper plugin that rewrites mis-encoded Windows-1252 punctuation (0x80-0x9f) to correct Unicode during feed import.**

- **Version:** 2.0.x
- **Core:** ^10 || ^11 — depends on `tamper` and `feeds_tamper`
- **Plugin:** `@Tamper id = "mislabeled_encoding"` (category Text) — `MislabeledEncoding::tamper()` does a fixed `str_replace()` over a `"\xc2\x8?"` → Unicode table; non-string input throws `TamperException`.
- **Config:** none (no routes, services, forms, permissions).
- **Security:** pure in-pipeline string transform; no endpoints, no user-facing surface, no dynamic code. No security findings.