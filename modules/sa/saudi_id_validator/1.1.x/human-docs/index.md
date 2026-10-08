# Saudi ID Validator — manual setup guide

**Saudi ID Validator** (`saudi_id_validator`) validates Saudi **National ID** and
**Iqama** (residency permit) numbers entirely offline. It checks the length and
shape of a number, works out whether it belongs to a citizen or a resident by its
leading digit, and verifies the official Luhn checksum — all without ever
contacting an external service, so the ID data never leaves your server.

It solves a focused problem: making sure the Saudi ID numbers people enter into
your forms, or that get written to your entities, are actually well‑formed before
you trust them. It does this in three interchangeable ways so you can pick
whichever fits your code: a reusable, dependency‑injected **validation service**
(`saudi_id_validator.validator`) you can call from your own code; a **Form API
`#element_validate` callback** you attach to a form field; and an **entity /
typed‑data constraint** (`SaudiId`) that validates a value wherever it is written.
It can also tell you the detected type — citizen versus resident.

There is also a small **settings screen** at *Administration → Configuration →
System → Saudi ID Validator* (permission `administer saudi id validator`). It lets
you switch on **automatic validation** — any form field whose machine name is on a
configurable list (shipping with `national_id`, `saudi_id`, `identity_number`,
`iqama`, `id_number`) gets validated without the form asking for it — and lets you
optionally show the detected ID type back to the user. Note the settings only
control *where* validation is added; nothing there ever relaxes a rule, and a
field that attaches the validator or constraint itself is always validated.

This remains primarily a developer / building‑block module: the richest use comes
from wiring the service, the form validator or the constraint into your own forms
and entities. It has no module dependencies and no submodules, but it does require
a reasonably recent PHP (8.3+).

This guide is written for a **human**. If you want a terse, token‑cheap reference
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## How to use it

Attach the `SaudiId` constraint to an entity field so stored values are validated
everywhere they are written, add the Form API element validator to a form field to
reject invalid input on submit, or inject the `saudi_id_validator.validator`
service and call it directly. To validate matching fields without touching code,
turn on automatic validation on the settings screen and list their machine names.
All validation is local — no network calls are made.
