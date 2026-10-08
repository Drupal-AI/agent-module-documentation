# CSP Google Supported Domains — manual setup guide

**CSP Google Supported Domains** (`csp_google`) is a small helper for the
[Content Security Policy](https://www.drupal.org/project/csp) (`csp`) module. Its
one job is to add Google's country‑code domains — the ones listed at
`https://www.google.com/supported_domains` — to your CSP rules automatically, so
you don't have to hand‑maintain that long, changing allowlist yourself. It
depends on the `csp` module and supports Drupal 9, 10, and 11.

You only need this if you use Google features that load assets through
country‑code top‑level domains (some of Google's ad‑related features do this).
Basic analytics functionality does **not** require these domains, so if you only
run standard Google Analytics or Tag Manager you may not need this module at all.
When you do need it, it saves the tedium of keeping dozens of Google ccTLDs
current in your policy by hand.

Once installed, the module doesn't have a settings page of its own. Instead it
adds a single **"Add Google supported domains"** checkbox to the CSP module's
own policy editing form. You turn the feature on per CSP policy, exactly where you
already manage your Content Security Policy.

> **One caution before you enable it everywhere:** turning on "Add Google supported
> domains" for all policies can make the `Content-Security-Policy` HTTP header very
> long. If the header grows larger than your reverse proxy or CDN allows, visitors
> can hit a **502 error**. Enable it only on the policies that actually need Google
> ccTLDs, and keep an eye on your header length.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and the required
   `csp` module) with Composer and enable it.

There is **no configuration page** for this module. You enable its behavior with a
checkbox on the CSP module's policy form, described in "How to use it" below.

## Where it lives in the admin menu

CSP Google Supported Domains adds no admin page of its own. Its checkbox appears
inside the **CSP** module's settings at **Configuration → System → Content
Security Policy** (`/admin/config/system/csp`), on the policy you are editing.

## How to use it

1. Make sure the **CSP** (`csp`) module is installed, enabled, and configured with
   at least one policy (Reporting‑only or Enforced).
2. Go to **Configuration → System → Content Security Policy** and edit the policy
   you want to extend.
3. Tick **Add Google supported domains** on that policy and save.
4. Re‑check your rendered `Content-Security-Policy` header — confirm the Google
   ccTLDs are present and that the header hasn't grown beyond what your proxy or
   CDN permits.
