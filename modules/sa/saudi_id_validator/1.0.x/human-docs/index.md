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

This is a developer/building‑block module rather than a point‑and‑click feature.
There is **no configuration form** and nothing to set up in the UI: once enabled,
you wire the service, the form validator or the constraint into your own forms and
entities. Administration is gated by the `administer saudi id validator`
permission. It has no module dependencies and no submodules, but it does require a
reasonably recent PHP.

This guide is written for a **human**. If you want a terse, token‑cheap reference
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## How to use it

Because there is nothing to configure, using the module means calling it from
code. Attach the `SaudiId` constraint to an entity field so stored values are
validated everywhere they are written, add the Form API element validator to a
form field to reject invalid input on submit, or inject the
`saudi_id_validator.validator` service and call it directly. All validation is
local — no network calls are made.
