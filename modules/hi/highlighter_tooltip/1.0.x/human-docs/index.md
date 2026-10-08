# Highlighter Tooltip — manual setup guide

**Highlighter Tooltip** (`highlighter_tooltip`) adds a lightweight
"select‑to‑share" behaviour to your pages. When a visitor highlights (selects) a
piece of text, a small tooltip pops up offering to copy a shareable URL to the
clipboard — handy for quote‑sharing or letting readers grab a link to what
they've selected.

It's a front‑end, client‑side feature: the tooltip and the copy action all run in
the browser via a JavaScript library the module attaches for you. There's nothing
persisted server‑side and the module has no content or access‑control role. It
depends on core's **Path Alias** module and runs on Drupal 10 and 11.

Because the behaviour is driven entirely by JavaScript, there is no admin settings
page. On a Drupal site the library is wired up automatically through
`drupalSettings`; the tooltip's messages and an optional URL‑shortener endpoint are
options a developer can pass when initialising the listener, rather than fields in
an admin form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no admin settings
form. Any customisation (the copy/success/error messages, or an optional
URL‑shortener endpoint) is done in JavaScript by a developer; see "How to use it"
below.

## Where it lives in the admin menu

Highlighter Tooltip adds no admin page. Once enabled, its library is attached and
the tooltip appears automatically when a visitor selects text.

## How to use it

1. Enable the module — the tooltip behaviour is attached to the page for you and
   works out of the box.
2. On the front end, select any text; a small tooltip appears offering to copy a
   shareable URL to the clipboard.
3. *(Developers, optional)* The behaviour is a `HighlighterTooltipListener`
   wired through `drupalSettings.highlighterTooltipListener`. You can customise
   its share/success/error messages, the context element it listens on, and an
   optional `urlShortener` endpoint that returns a shortened URL — all passed as
   options when the listener is initialised in your own JavaScript, not through an
   admin form.
