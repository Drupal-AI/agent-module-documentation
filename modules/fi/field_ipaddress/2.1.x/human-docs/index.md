# Field IP address — manual setup guide

**Field IP address** (`field_ipaddress`) provides a **field type** for storing a
single IP address or an IP range, in either **IPv4 or IPv6**. It's the storage
primitive you reach for when content or user entities need to record IPs —
allow‑lists, per‑user network mappings, geo/network metadata — and it's designed
so other modules can efficiently ask "is this IP within the stored range?".

The clever part is under the hood: values are stored as a `[start, end]` pair in
indexed binary columns, so range‑membership queries run natively in SQL against
the field's index rather than in PHP. A single text input accepts, and
normalises, a wide range of forms: a single IP (`10.10.10.10`), a dash range
(`10.10.10.0 - 10.10.12.255`), a partial last‑octet range (`10.10.10.10-20`),
wildcards (`10.10.*.*`), and CIDR notation (`10.10.10.0/24`). Invalid input is
rejected inline by the widget, and returned as an HTTP 422 by REST/JSON:API.

The field integrates with **Views** — its values are exposed with native sort
and filter handlers, including range‑aware operators like `BETWEEN` and
`NOT BETWEEN` — and ships a **Drupal 7 migration** plugin for sites moving from
the old field type. It depends only on core's Field module.

> **Privacy note.** IP addresses are considered **personal data** in many
> jurisdictions (for example under the GDPR). Store and handle values from this
> field in line with your site's privacy policy and applicable law. The field
> itself is storage only — it enforces no access control of its own; any security
> or privacy behaviour is the responsibility of the code that consumes the value.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no central configuration page** for this module — it has no site‑wide
settings form. Its options are set per field when you add the field to an entity,
described in "How to use it" below.

## Where it lives in the admin menu

Field IP address adds no admin page. You use it through the usual Field UI:
**Structure → Content types (or any fieldable entity) → *(bundle)* → Manage
fields → Add field**, where **IP address** appears in the list of field types.

## How to use it

1. On an entity's **Manage fields**, add a new field and choose the **IP
   address** field type.
2. In the field's settings, configure the per‑field options:
   - **IP version** — restrict the field to IPv4, IPv6, or allow both.
   - **Allow ranges** — whether the field accepts a range, or only a single IP.
   - **Allowed range** — optionally limit accepted values to a specific
     sub‑range, configured independently per IP family.
3. Save the field. Editors then enter a single IP, a range, a wildcard, or CIDR
   notation; invalid input is rejected as they type.
4. To surface the values in listings, add the field to a **View** — the native
   sort and filter handlers (including `BETWEEN` / `NOT BETWEEN` and correct
   range‑to‑range comparisons) are available there.

Developers who need to query the field can use the `field_ipaddress.iptools`
helper service for "contains IP" and "overlaps range" lookups; see the
[`agent/`](../agent/start.md) docs and the project page for details.
