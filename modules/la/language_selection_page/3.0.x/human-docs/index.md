# Language Selection Page — manual setup guide

**Language Selection Page** (`language_selection_page`) adds a language
negotiation method that shows a visitor a landing / splash page where they choose
their language — but only when none of Drupal's other detection methods has
already decided. It slots into the existing negotiation chain rather than being a
redirect bolted on top, which is exactly the right shape: it runs as a *fallback*,
after URL, cookie, or account detection have had their say.

This is useful when you genuinely do not want to guess. Every core negotiation
method can be wrong — a URL with no language prefix, a browser advertising a
language the site does not have, a shared computer whose previous user chose
differently, a visitor in one country reading another country's language. On a
site whose languages are not simply translations of each other, in a regulated
market where the language carries legal weight, or for an organisation whose
audiences genuinely differ, asking is better than guessing. The module supplies
the asking. The selection page can be overridden through Drupal's theme system,
and you can blacklist paths where it should never run.

Two things are worth weighing before you turn it on. **An interstitial costs
visitors**: a page between the click and the content raises bounce and dilutes
referral traffic — and it is worst for the very people it is meant to help, who
arrive from a search result *already* in their language and are then asked to
confirm it. Place the method **below** URL and account detection, never above.
And **keep search engines away from it**: a crawler that hits the selection page
indexes *it* instead of your content, so keep the page out of your sitemap and
make sure your URL‑prefixed language pages stay directly reachable without passing
through it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   its core dependencies.
2. [Configuration](configuration/index.md) — enable and *position* the negotiation
   method, and set its options (injection method, blacklisted paths).

## Where it lives in the admin menu

There is no standalone settings page with its own menu item. You configure the
module inside Drupal's language detection screen at **Configuration → Regional and
language → Languages → Detection and selection**
(`/admin/config/regional/language/detection`), where "Selection Page" appears as
one of the detection methods you can enable and order. See
[Configuration](configuration/index.md) for the details.
