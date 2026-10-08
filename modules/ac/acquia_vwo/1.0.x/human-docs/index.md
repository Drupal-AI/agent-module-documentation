# Acquia VWO — manual setup guide

**Acquia VWO** (`acquia_vwo`) integrates **VWO (Visual Website Optimizer)** with
Drupal and adds *enhanced data capture*, so your A/B tests can segment on things
Drupal knows about your content but the testing tool otherwise cannot.

A plain A/B testing tool sees a page; it does not see that the page is an *Article*
in the *Pricing* section tagged for a particular audience. Enhanced data capture
closes that gap by passing Drupal's content metadata — content type, taxonomy terms
and the like — into VWO (which is why the module depends on **Node** and
**Taxonomy**). Experiments and reports can then segment on what the CMS knows.

You control **which pages carry the VWO script** through the module's visibility
settings, and you set your **VWO account ID** so the script talks to your account.
Deciding deliberately where the script loads — rather than loading it everywhere —
is part of a sound setup.

**Two things belong in any A/B-testing deployment, and neither is the module's to
solve.** First, the VWO script is a **third-party script that can modify the page
client-side** before a visitor sees it — that is the whole point of the tool, and it
also means the VWO account becomes part of your site's trust boundary. Second, it
**sets cookies to bucket visitors**, so on an EU-facing site it needs consent gating
like any other non-essential tracker (a consent tool such as `usercentrics` or
`consent_mode` is how that is arranged). As with any configuration permission, grant
*administer acquia vwo* only to roles you trust to manage the integration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — the VWO account ID, visibility, the
   permission, and the consent/privacy points.

## Where it lives in the admin menu

The settings live under **Configuration → System → Acquia VWO**
(`/admin/config/system/acquia_vwo`), with companion pages for **visibility**
(`/admin/config/system/acquia_vwo/visibility`) and the **VWO account ID**
(`/admin/config/system/acquia_vwo/vwoid`). See
[Configuration](configuration/index.md).

## How to use it

Enter your **VWO account ID**, choose **which pages** should carry the script, and
grant the administer permission only to trusted roles. Arrange consent gating for
the VWO cookies on EU-facing sites. Then run your experiments in VWO — thanks to
enhanced data capture, you can segment and report by content type, section or
taxonomy term.
