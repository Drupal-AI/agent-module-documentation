# Telephone E.164 — manual setup guide

**Telephone E.164** (`telephone_e164`) provides a telephone **field type** that
stores and validates phone numbers in the international **E.164** standard format —
the canonical `+<country code><number>` form with no spaces or punctuation. Where
Drupal core's telephone field is essentially a text box that validates almost
nothing, this field normalises what gets stored, so your phone data stays
consistent and interoperable for things like SMS gateways, click‑to‑dial, and CRM
synchronisation.

The problem it solves is that free‑form phone entry produces the same number in a
dozen incompatible shapes, and none of them are reliably machine‑usable. By fixing
storage to E.164, every number on the site is comparable and dialable by
downstream systems.

This is a plain field provider: it has no content, no routes, and no access role of
its own — render output is escaped normally and field access follows the host
entity. There is **no settings page**; you use it by adding a field of this type to
a content type and configuring it there. It depends on Drupal core's **Telephone**
and **Field** modules, and there are no submodules.

One note on status: this project is minimally maintained and marked obsolete
(it spun off from a core issue and the maintainers intended the work to fold back
into core's telephone project), and it targets **Drupal 11.3+ / 12** only. Check
whether it still fits your roadmap before adopting it on a new build.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Add a new field to a content type (or other entity) and choose the **Telephone
E.164** field type. From then on, values entered into that field are validated and
stored in E.164 form. All behaviour is per field — there is no central
configuration page.
