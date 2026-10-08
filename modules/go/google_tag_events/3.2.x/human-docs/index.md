# Google Tag Manager: Events — manual setup guide

**Google Tag Manager: Events** (`google_tag_events`) supplies the plumbing for
pushing *server-side* events into Google Tag Manager's data layer — the part the
main [Google Tag](https://www.drupal.org/project/google_tag) module deliberately
leaves to each site to build.

Google Tag puts the GTM container snippet on the page. What it does not solve is
how something that happens on the server — a form submitted, an order placed, a
login completed — reaches the data layer on the *next* page the visitor sees. This
module's answer is a plugin type plus a short-lived stash: you declare an event as
a plugin, the module collects it, and a cookie-backed temporary store holds the
pending event across the redirect (including for anonymous visitors, who otherwise
have no session). A lazy builder then injects the queued events into the rendered
page without spoiling page cacheability, and there is coverage for events raised
during AJAX responses too.

This is developer-facing infrastructure — you push events from PHP using the
`google_tag_events` service, or by encapsulating the data preparation in an event
plugin. There is a debug mode so you can test event pushing without any GTM
container configured.

One thing to weigh in a privacy review: queueing events for anonymous visitors
means a cookie is set before any consent decision is recorded. Check how that
interacts with your site's consent-management tooling before enabling it — this
belongs in a cookie audit.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Google Tag / js_cookie dependencies.
2. [Configuration](configuration/index.md) — configure a GTM container (or turn on
   debug mode) so events have somewhere to go.

## Where it lives in the admin menu

The settings form is at **Configuration → Services → Google Tag → Events →
Settings** (`/admin/config/services/google-tag/events/settings`). It is gated by
Google Tag's own **Administer Google Tag Manager** permission
(`administer google_tag_container`) — this module declares no permissions of its
own.
