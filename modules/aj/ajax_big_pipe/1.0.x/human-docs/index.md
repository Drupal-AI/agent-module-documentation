# AJAX BigPipe — manual setup guide

**AJAX BigPipe** (`ajax_big_pipe`) extends Drupal core's BigPipe streaming
technique to **AJAX responses**. Core's BigPipe is one of Drupal's better
performance ideas: the cacheable shell of a page is sent immediately, the
personalised fragments — the user menu, a cart count, anything that varies per
visitor — are replaced by placeholders, and each is streamed in as it finishes
rendering, so the visitor sees content quickly instead of waiting for the slowest
component. Core applies that to ordinary page responses; this module applies the
same treatment to AJAX responses — a Views AJAX pager, a dialog, an off‑canvas
panel, a decoupled fragment fetch — which matter more and more as pages load
content after the initial request.

There is nothing to configure and no admin UI: enabling the module (with its
core `big_pipe` and `rest` dependencies) is the whole setup. That said, three
things are worth understanding about any BigPipe‑family module before you rely on
it — see below.

This guide is written for a **human**. If you want terse, token‑cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — AJAX BigPipe has no settings form or menu items. It works automatically
once enabled.

## Three things to understand before relying on it

1. **Placeholders are a correctness mechanism, not only a speed one.** A fragment
   that is auto‑placeholdered because it varies per user must actually declare
   that variance in its **cache contexts**. A fragment with wrong cache metadata
   is served to the **wrong person** — that is a disclosure, not just a slow page.
2. **The gain is conditional on nothing buffering the response.** Streaming needs
   the whole response path to not wait for the complete body. A reverse proxy, an
   output filter, or a compression layer that buffers removes the benefit
   **silently**.
3. **It changes the shape of an AJAX response.** Test anything downstream that
   parses AJAX replies rather than assuming it still works.

## How to use it

Enable the module and let it work — its benefit shows up on AJAX‑heavy interfaces
such as Views AJAX pagers, dialogs, off‑canvas panels, and progressively
decoupled fragments. Verify the three points above hold for your setup.
