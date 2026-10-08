# Civic Cookie Control — manual setup guide

**Civic Cookie Control** (`civicccookiecontrol`) wires the commercial
[Cookie Control by CIVIC UK](https://www.civicuk.com/cookie-control) consent widget
into Drupal. It gives your site the cookie-consent banner and granular controls
needed to comply with UK and EU cookie law (and GDPR) — an elegant, widely
recognised consent experience you configure rather than build from scratch. A
submodule, **`civic_govuk_cookiecontrol`**, adds a GOV.UK-styled variant following
the DWP GOV.UK cookie-consent pattern.

There are two things every site using this must understand. First, it is a **front
end to a third-party product**: it needs a CIVIC UK Cookie Control account and an
**API key**, and the consent UI is CIVIC's own script, so you take on that service
and its terms. Second — and this is the part sites get wrong — a consent banner
only actually achieves compliance if the scripts that set cookies **respect it**.
The module gives you the consent UI and the machinery to gate scripts by category,
but making your analytics, marketing, and embed scripts fire only *after* the
visitor consents is a configuration job you must finish. If you skip it, the banner
is decorative.

For a UK/EU site that needs a recognised consent experience, it is a solid choice.
Enable it, connect the API key (ideally kept out of plain configuration), configure
your consent categories, and then verify that gated scripts genuinely wait for
consent.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module (and optionally the GOV.UK submodule), and run database updates.
2. [Configuration](configuration/index.md) — connect the CIVIC API key, define
   consent categories, and gate your cookie-setting scripts.

## Where it lives in the admin menu

The settings form is under **Configuration → Civic Cookie Control**, and
administering it is gated by the module's **Administer Civic Cookie Control**
permission — keep it to trusted administrators.
