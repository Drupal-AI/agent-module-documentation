# LinkedIn Insights Tag — manual setup guide

**LinkedIn Insights Tag** (`linkedin_insights_tag`) embeds the official LinkedIn Insight Tag
on your site so LinkedIn can track conversions, build retargeting/website audiences for
LinkedIn Ads, and report campaign insights. Instead of hand-editing your theme templates to
paste in LinkedIn's snippet, you enter your **LinkedIn Partner ID** once on a settings form
and the module injects the tracking code for you.

The module adds the LinkedIn `insight.min.js` script (loaded from LinkedIn's own
`snap.licdn.com` CDN) to your pages, along with a 1×1 tracking pixel that falls back to a
`<noscript>` image for visitors without JavaScript. You control **which user roles** get
tracked — for example only anonymous visitors, excluding logged-in editors and admins — which
is useful for honouring consent or opt-out policies. There is also an **"image only"** option
that skips the JavaScript entirely and serves just the tracking pixel, for stricter setups.

Nothing loads until you enter a Partner ID, so installing the module has no effect on its own.
Clearing the Partner ID later is a quick way to switch tracking off.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.
2. [Configuration](configuration/index.md) — enter your Partner ID and choose which roles are
   tracked.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → LinkedIn Insights**
(`/admin/config/system/linkedin-insights`), gated by the module's own **Administer LinkedIn
Insights** permission.
