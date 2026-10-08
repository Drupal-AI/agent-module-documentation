# Masked Input — manual setup guide

**Masked Input** (`masked_input`) adds **input masks** to text fields — the
placeholder patterns like `(___) ___-____` for a phone number or `__/__/____` for
a date that show the expected shape of a value and let characters fall into place
as the user types. A bare text field tells the user nothing about the format you
want, so people type reference numbers, phone numbers and postal codes every way
imaginable. A mask communicates and gently enforces the format right at the point
of entry, which makes forms friendlier and cuts down on malformed submissions.

The module wraps the well‑known **Masked Input** jQuery plugin by Josh Bush and
gives you a settings page for defining which mask applies to which field. Masks are
built from a few simple characters: `9` for a digit, `a` for a letter, and `*` for
any alphanumeric character — so `(999) 999-9999` masks a US phone number and
`999-99-9999` masks a social‑security number.

> **A mask is a client‑side convenience, not validation.** It runs as JavaScript
> in the browser: it shapes what a cooperating user types and does nothing to a
> script, a `curl` request, or a browser with JavaScript disabled — those can
> submit whatever they like. Always back a masked field with real server‑side
> validation on anything that matters, and never treat a masked value as
> sanitised. Used as what it is — a formatting hint that improves the human
> experience — it is a small, genuine improvement; mistaken for a security control
> it is a false assurance.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — define your masks on the settings
   page and apply them to fields.

## Where it lives in the admin menu

The settings form sits at **Configuration → User interface → Masked Input**
(`/admin/config/user-interface/masked_input`).
