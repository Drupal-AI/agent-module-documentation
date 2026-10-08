# Masked Output — manual setup guide

**Masked Output** (`masked_output`) displays field values as **masked strings** —
showing only part of a value, such as `******9845`, in the rendered output. It is
meant for sensitive‑looking data you still want to show on screen: partial card or
account numbers, phone numbers, SSNs, email addresses in public listings, API keys
and reference codes. It provides configurable **field formatters**, a **Views**
field handler, and a **JSON:API** normalizer, so the same masking follows a field
across entity displays, Views pages, and API responses.

The module ships several masking strategies you choose per field: **Mask Output**
for string fields (show the first/last N characters and mask the rest, with a
custom mask symbol), **Mask Email Output** (mask the local part, keep the domain —
`john.doe@example.com` → `********@example.com`), and **Mask Pattern Output** for
string and telephone fields (a positional pattern where `#` shows the original
character and `*` masks it — `(***) ***-####` → `(***) ***-5309`). Each formatter
offers a **role‑based bypass** (chosen roles see the unmasked value) and an
optional **reveal‑on‑demand** button gated by the *Reveal masked output values*
permission, with every reveal written to an audit log.

> **Understand the scope precisely: this is display‑only masking, not a
> data‑access control.** The real, unmasked value is unchanged in the database, in
> the entity/Field API, in the edit form, and in exports — masking happens only in
> the specific rendered output. The JSON:API normalizer and Views handler extend
> the *presentation* masking to those surfaces, but anyone who can reach the
> field's data through a path you have not masked (a different display, another API
> route, the edit form, direct database access) sees the true value. Do **not**
> rely on Masked Output to protect genuinely sensitive data — for that use
> field‑level access control, encryption, or simply not storing the data.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central settings page** — masking is configured per field on the
display, in Views, and via permissions, described in "How to use it" below.

## Where it lives in the admin menu

Masked Output adds no admin settings page of its own. You configure it in three
places:

- **Structure → *(entity type)* → Manage display** — pick a Masked Output
  formatter for a field.
- **The Views UI** — every string, email, and telephone field gains a **(Masked)**
  variant in the field picker.
- **People → Permissions** — grant the *Reveal masked output values* permission to
  the roles allowed to click "Reveal".

## How to use it

1. On a bundle's **Manage display**, choose a Masked Output formatter for the
   sensitive field — **Mask Output**, **Mask Email Output**, or **Mask Pattern
   Output** — and set its options (how many characters to show, the mask symbol or
   pattern, and which **roles** may see the unmasked value).
2. If you want an in‑place reveal, enable the formatter's **Reveal on demand**
   option and grant the *Reveal masked output values* permission to the
   appropriate roles. You can also set an **auto re‑mask timeout** so a revealed
   value hides itself again after a few seconds. Every reveal is recorded to the
   `masked_output` log channel (**Reports → Recent log messages**).
3. For listings, add the **(Masked)** variant of the field in your View and
   configure its masking independently of the entity display.
4. If the `jsonapi` module is enabled and the field's default display uses a masked
   formatter, JSON:API responses are masked automatically — no extra configuration
   — with role bypass honoured for authenticated consumers.

Keep the display‑only caveat above in mind when deciding which fields this is
appropriate for.
