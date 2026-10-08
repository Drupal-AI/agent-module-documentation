# Gated Entity — manual setup guide

**Gated Entity** (`gated_entity`) locks the rendered view of chosen node types
behind a pluggable "locker". When a node is gated and locked for the current
visitor, the module keeps the node **title** visible but replaces the body with
whatever the locker chooses to show. The locker that ships with the module is the
**Login Locker**: it shows anonymous visitors a "Login to unlock" link in place
of the content, and treats any logged‑in user as unlocked.

You configure it from a single admin page: you tick which node types are gated
and pick the default locker. At render time the module checks whether each entity
is gated and, if so, swaps the rendered markup for the title plus the locker's
message. Developers can add their own locker by implementing a
`@GatedEntityLocker` plugin (for example a password gate).

**Please read this before you rely on it.** Gated Entity enforces the gate at the
**presentation layer only** — it strips the gated body out of that page's HTML,
but it does **not** use Drupal's node‑access system. That means the underlying
node stays fully readable through other channels: JSON:API, REST, Views field
output, search indexing, the node edit form, and other view modes. Treat this as
a *soft* gate for marketing or registration‑wall purposes, not as real access
control for sensitive content. For genuinely restricted content, pair it with a
proper access‑control mechanism.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose which node types are gated
   and which locker applies.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Content authoring →
Gated entities** (`/admin/config/content/gated-entities`). Access is gated by the
**Configure gated entities** permission.
