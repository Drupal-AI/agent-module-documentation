# Domain Google Analytics — manual setup guide

**Domain Google Analytics** (project `domain_google_analytics`, machine name
**`multidomain_google_analytics`**) lets each domain on a
[Domain](https://www.drupal.org/project/domain)-module multi-site have its own
Google Analytics configuration. It builds on the Domain module, which runs several
sites from one Drupal installation — and analytics is one of the places where
"several sites" and "one installation" collide most obviously.

The problem it solves: a single measurement ID shared across a group of brand
sites mixes all their traffic into one property, so nobody can report on an
individual brand. A shared property with hostname filtering can be made to work,
but only if everyone doing the reporting remembers to apply the filter every time.
And a client site whose analytics belongs to the client can't share a property
with the agency's other clients at all. Per-domain configuration makes the tracking
match the organisational reality — each site's data goes where that site's owner
expects.

Setting it up is a matter of creating your domains in the Domain module, then
entering the Google Analytics tracking code for each domain on this module's own
configuration page. The tracking ID is ordinary configuration, not a secret.

Two things are worth attaching, carried over from the module's own guidance:

- **Per-domain tracking is a per-domain cache context.** A page cached for one
  domain must not be served to another with the wrong measurement ID embedded — a
  general Domain hazard worth verifying here, because a wrong ID sends one site's
  traffic to somebody else's property.
- **Consent is per-domain too.** Your domains may sit in different jurisdictions
  with different requirements, so a consent banner configured once at the
  installation level is answering a question that has more than one right answer.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it with
   the correct machine name, and make sure Domain is present.
2. [Configuration](configuration/index.md) — entering per-domain tracking codes.

## Where it lives in the admin menu

The configuration page is at **Configuration → System → Multidomain Google
Analytics** (`/admin/config/system/multidomain-google-analytics`). Your domains
themselves are created and managed on the Domain module's page at
`/admin/config/domain`.
