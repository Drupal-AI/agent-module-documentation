# Ahrefs Analytics — manual setup guide

**Ahrefs Analytics** (`ahrefs`) adds the Ahrefs Web Analytics tracking script to
your site. Once enabled and given your Ahrefs analytics key, it injects Ahrefs'
snippet into your pages so that page views and visitors are recorded in your
Ahrefs Analytics account — the same idea as dropping in a Google Analytics tag,
but for Ahrefs.

This is an SEO / analytics helper, not an AI module. It does one job: load the
tracking snippet with your key so Ahrefs can measure traffic. It provides its own
permission so you can control who is allowed to change the tracking settings.

Because it loads a **third‑party tracking script that sends visitor data to
Ahrefs**, treat it like any other analytics tag: disclose it in your privacy
policy and wire it into your cookie/consent tooling if your jurisdiction
(for example the GDPR) requires consent before analytics scripts run. The Ahrefs
analytics key it asks for is a public tracking key that is embedded in the page's
HTML — it is not a secret API token, so there is nothing to hide in an
environment variable here.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Once enabled, the module adds a small settings form where you paste your Ahrefs
analytics key. Access to that form is controlled by the permission the module
provides, so grant it only to the administrators who manage your analytics.

## How to use it

1. Sign in to your [Ahrefs](https://ahrefs.com) account and create a Web
   Analytics project for this site. Ahrefs gives you an **analytics key** (a
   short identifier used in the tracking snippet).
2. In Drupal, open the Ahrefs settings form and paste that analytics key, then
   save.
3. The module now injects the Ahrefs tracking script on your site's pages. Visit
   a public page and, after a short delay, your Ahrefs dashboard should begin
   showing visits.

There is nothing else to configure — the module simply keeps the snippet on your
pages using the key you entered.
