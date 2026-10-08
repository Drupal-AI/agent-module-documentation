<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Calendar Link (calendar_link) — agent index

Two **Twig functions** that build "add to calendar" URLs from event fields. Version **3.0.4**. Core `^9.5 || ^10 || ^11`. No routes, no config, no external calls.

- `calendar_link(type, title, from, to, all_day, description, address)` → one provider URL (`type` ∈ google, yahoo, ical, weboutlook, ...).
- `calendar_links(title, from, to, all_day, description, address)` → array keyed by provider.
- `from`/`to` are PHP `DateTime`; output is auto-escaped by Twig (not marked safe HTML).

Security: no security surface — pure URL construction from template-supplied values, no request handling.

See [api/twig.md](api/twig.md) for the function signatures and a template example.