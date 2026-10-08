# Entity Reference Direct Input — manual setup guide

**Entity Reference Direct Input** (`entity_reference_direct_input`) makes
entity-reference autocomplete fields smarter for editors who already know
*which* item they want. Instead of typing part of a label and hunting through
suggestions, an editor can paste a raw identifier — a numeric entity ID, the
`#123` shorthand, a user's email address, a full `http(s)://` URL, or a path
alias — and the field resolves it to the correct reference.

The problem it solves is the daily friction of picking references when you
already have the identifier in hand. You copy a node's URL from another browser
tab, paste it into a reference field, and the module turns it into the right
reference; you type a bare ID during a migration cleanup; you reference a user
by their email. Under the hood it replaces core's autocomplete matcher so that
normal label matches still come first, and then — for the entity types you have
enabled — it prepends a resolved match shown as "Label — /alias (id: N)".

Supported target types are **Node**, **User**, and **Taxonomy Term**, and you
choose which of them get the behaviour on the settings page — so it needs a
little configuration before it does anything. It respects the field's allowed
target bundles before injecting a match, so it can never broaden the set of
things a field is allowed to reference. Note that path/URL resolution
deliberately maps a path to an ID without a view-access check; the resolved
entity is still subject to the reference field's selection handler and the
entity's own access when the content is saved or rendered.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose which entity types accept
   direct input.

## Where it lives in the admin menu

The settings form sits at **Configuration → Content authoring → Entity
Reference Direct Input** (`/admin/config/content/entity-reference-direct-input`),
behind the **Administer site configuration** permission. There is no per-field
setup: once a type is enabled here, direct input applies to that type's
autocomplete reference fields site-wide.
