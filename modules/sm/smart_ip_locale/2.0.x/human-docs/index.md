# Smart IP - Language Negotiation Redirect — manual setup guide

**Smart IP - Language Negotiation Redirect** (`smart_ip_locale`) adds an IP-based
language detection method to Drupal's multilingual system. Using the **Smart IP**
module's geolocation to guess a visitor's country, it can send them to the site
language you have mapped to that country — so a visitor from France lands on the
French version, a visitor from Germany on the German one, and so on.

It plugs into core's language-negotiation stack as an extra detection method
("Smart IP country code") that you enable and position alongside the usual methods
(URL, session, cookie, and so on). You then map each country code to a language.
Because it slots into negotiation, you decide how much weight it carries relative
to a visitor's explicit choices.

A few caveats are worth keeping in mind, because they are inherent to any
geolocation-based routing. IP geolocation is a **heuristic**: VPNs, proxies,
mobile carriers, and imperfect databases mean the guessed country is often wrong.
Auto-redirecting by IP can also frustrate people and confuse search-engine
crawlers, so it should not override a language the visitor has explicitly chosen —
always leave a way to switch back. For the country lookup to be meaningful, your
site must hand Drupal the real client IP, which means configuring trusted proxies
correctly if you sit behind a load balancer or CDN. The maintainers recommend
pairing it with the **Language Cookie** module so the country is resolved once and
remembered, rather than re-checked on every request.

It depends on the **Smart IP** module and works on Drupal 9, 10, and 11. It is a
multilingual/negotiation feature and has no access-control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Smart IP.
2. [Configuration](configuration/index.md) — turn on the detection method, order
   it, and map countries to languages.

## Where it lives in the admin menu

There is no standalone settings page of its own. You configure it from the core
**languages** screen at **Administration → Configuration → Regional and language →
Languages** (`/admin/config/regional/language`), where you enable and order the
detection methods and set up the country-to-language mapping.
