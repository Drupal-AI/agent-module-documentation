# Confirmation — manual setup guide

**Confirmation** (`confirmation`) is a **developer framework**, not a
point‑and‑click feature. It provides a reusable set of "confirmation entities" for
building confirm / disconfirm flows — the kind of double‑opt‑in, approval, or
verification step where a user receives a link (usually by email, but it could be
any channel), clicks it, and thereby confirms or rejects a pending action. Each
confirmation entity represents one such pending action, carries a hash meant to act
as its capability token, and can optionally have an expiry time. The response link
looks like `/confirmation/{confirmation}/{hash}`.

The module deliberately provides only the **core mechanics**. It has no admin
settings page and no ready‑made user‑facing feature: any domain‑specific logic
(what the confirmation actually *does*, what data it stores) lives in a bundle
class and its fields that an integrating module supplies. The distribution ships a
`confirmation_example` submodule and tests to show the pattern. It supports Drupal
10 and 11 and depends only on core.

When a confirmation is answered, the module dispatches a `state_settled` event so your
integrating code can act on the result — the bundled `confirmation_example` subscriber, for
instance, publishes the linked node when a confirmation is confirmed and deletes it when it is
disconfirmed. What each confirmation does is entirely up to the bundle you write.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** — this is an API/framework module. You wire it
up in code by defining a confirmation bundle and the logic each confirmation
performs. Start from the bundled `confirmation_example` submodule and tests.
