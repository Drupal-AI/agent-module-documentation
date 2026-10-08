# AdSense User Consent — manual setup guide

**AdSense User Consent** (`adsense_consent`) shows Google AdSense ads on your
site while giving each visitor a say in whether their ads are personalised. It
can serve ads two ways — as page-level "auto ads" that AdSense injects across
the site, and as a placeable **AdSense** block for a fixed ad unit — and in both
cases it holds personalised advertising back until the visitor has agreed.

The consent decision is handled in the browser. The module can read an existing
consent signal from the **EU Cookie Compliance** module or the **Klaro** consent
manager, or fall back to its own `ad_consent` cookie, and only enables
personalised ads once that gate passes. Ads only load at all when you have
entered a syntactically valid AdSense publisher ID (`pub-` followed by digits),
so clearing the ID is a quick way to switch everything off.

It also publishes a public **`/ad-options`** page, built entirely from text you
write on the settings form, where visitors can read your explanation of ad
personalisation, see the third-party ad networks you list, and toggle their own
preference. That page is public by design but read-only — it never changes site
data.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form field by field:
   publisher ID, ad placement, the consent gates, and the visitor-facing text.

## Where it lives in the admin menu

The settings form sits at **Configuration → Services → AdSense Consent**
(`/admin/config/services/adsense-consent`) and requires the *Administer site
configuration* permission. The visitor-facing options page lives at `/ad-options`
and is open to everyone. To place the fixed ad unit, use the normal **Block
layout** page and add the **AdSense** block to a region.
