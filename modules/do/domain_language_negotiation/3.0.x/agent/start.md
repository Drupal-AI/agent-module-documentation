<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Language Negotiation (domain_language_negotiation) — agent index

Negotiates site language from the **Domain module's domain record**. Depends on core `language`
and `domain`. Core requirement `^9 || ^10 || ^11`. **Release is 3.0.0-alpha7 — alpha.**

Key facts:
- **Negotiation order decides whether it works.** Drupal applies negotiation methods in sequence
  and the first that resolves wins. This must sit **above session and browser detection**, or a
  returning visitor's session language overrides the domain and a French domain serves English.
  That is the first thing to check when the behaviour looks wrong.
- The advantage over core's domain negotiation is that the hostname list is not duplicated:
  adding a domain and setting its language is one operation on the domain entity.
- **Check interaction with `domain_language`** (also in this collection) — both operate on the
  same axis, and that module's own entry records that its "allowed languages" is
  negotiation/switcher-only rather than access control.
