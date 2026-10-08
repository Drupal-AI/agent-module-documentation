# COOKiES MS Dynamics 365 Marketing Anonymize — manual setup guide

**COOKiES MS Dynamics 365 Marketing Anonymize** (`cookies_msdynamics365marketing`)
is a small "glue" module that connects Microsoft Dynamics 365 Marketing forms to
the [COOKiES Consent Management](https://www.drupal.org/project/cookies) cookie
banner. Its single job is to set — or clear — Dynamics 365's own **anonymize**
flag according to the consent decision the visitor makes in the COOKiES banner.

It is deliberately narrow. It does **not** add the Dynamics 365 Marketing form
code to your pages, and it does **not** block, load, or otherwise handle the
Dynamics scripts, forms, or cookies. All it does is emit the small JavaScript
snippet Microsoft documents for disabling non-essential Dynamics 365 Marketing
cookies: when consent has **not** been given (the default), it declares tracking
as `Anonymize: true`; once consent **is** given, it reconfigures tracking to
`Anonymize: false`. This is how you keep a Dynamics 365 form GDPR-friendly while
still embedding it the usual way.

Because it is consent glue, it works as soon as it is enabled — there is no
settings form. It depends only on the COOKiES module, and it works on Drupal 9,
10, and 11.

> **Heads-up from the maintainers:** this project describes itself as very
> specific and a work in progress, and advises against using it in production
> without careful testing. After setup, always verify that the anonymization is
> applied on every page and behaves as expected (see "How to use it" below).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside COOKiES.

There is **no configuration page** for this module. Once COOKiES and this module
are both enabled and configured, the anonymize flag is managed automatically.

## Where it lives in the admin menu

This module adds no admin page of its own. You manage consent categories and the
banner from the **COOKiES** module's own settings. This module simply reacts to
the consent decision.

## How to use it

1. Install and configure the **COOKiES** consent module and its cookie banner.
2. Enable this module.
3. Add your Microsoft Dynamics 365 Marketing forms to your pages exactly as you
   normally would.
4. Confirm the anonymization is added to every page. To test, open your browser's
   developer console and call `d365mktConfigureTracking();` both with and without
   cookie consent granted — you should see `Anonymize: true` returned before
   consent and `Anonymize: false` after. If the function is undefined, something
   in the setup is broken.
