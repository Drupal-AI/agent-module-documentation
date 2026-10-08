# Meta Conversions API — manual setup guide

**Meta Conversions API** (`meta_conversions_api`) sends conversion events to Meta
(Facebook) **from your server** rather than from the visitor's browser, as a
replacement for — or supplement to — the traditional Facebook pixel. When something
happens on your site that you want to report to Meta (a page view, a purchase, a lead
form submission), the module tells Meta directly, server to server, matching the
event to a person by hashed identifiers such as email address.

Why this exists: the browser pixel has been degraded from several directions at once —
ad blockers remove it, Safari's tracking prevention truncates the cookies it relies
on, and iOS app tracking transparency cut the identifiers it depended on. Server-side
reporting bypasses all three, which is why advertisers move to it. Out of the box the
module ships a **PageView** event; you can enable or disable each event, declare new
ones, and control triggering through hooks so it can integrate with a cookie banner.

**This changes the privacy position substantially, and you must plan for it before
enabling.** Because the event comes from your server, the visitor cannot see or block
it — ad blockers and browser settings have no effect. That means **consent has to be
enforced by your site in code**: if a visitor declined tracking, your code must not
send the event. And the data being sent is **personal data** — a hashed email is still
personal data under GDPR, since hashing is pseudonymisation, not anonymisation — so it
needs a lawful basis, an entry in your records of processing, and a line in your
privacy notice. See [Configuration](configuration/index.md) for how to wire consent
and store the access token safely.

It requires Facebook's PHP Business SDK (`facebook/php-business-sdk`) as a Composer
dependency, and a Meta **access token** and **Pixel ID** entered on its settings form.
(Note: the project's declared core requirement is written `^9 | ^10 || ^11` with a
single pipe, which is not valid Composer OR syntax — worth checking it resolves the way
you expect.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   Facebook Business SDK) and enable it.
2. [Configuration](configuration/index.md) — enter the Pixel ID and access token,
   enforce consent, and manage events.

## Where it lives in the admin menu

Its settings form is reached via the `meta_conversions_api.settings` route under
**Configuration**, and access is gated by the **Administer meta conversions api**
(`administer meta_conversions_api`) permission granted at **People → Permissions**.
