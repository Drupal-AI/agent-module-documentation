# Site Integrator — manual setup guide

**Site Integrator** (`site_integrator`) brings an **external website into your Drupal
site** — either embedded in an iframe or with its HTML content merged directly into a
Drupal page. It targets a common situation: you have a third-party web tool, not built
in Drupal, that you want to present inside your site.

The simplest approach — a plain iframe pointing at the external URL — has well-known
downsides: you have to size the iframe by hand, you can't resize it when its content
changes, browser security usually stops you reading the content's size, a
restricted-access external site has to be made publicly reachable to appear in the
iframe, and the isolated iframe makes it hard to restyle the external site or let Drupal
and the external tool interact. Site Integrator offers better options. You can still use
a classic iframe if you accept those limits, but you can also use an **enhanced iframe**
where the external content is fetched **server-side** and injected via JavaScript rather
than loaded from a source URL — which lets Drupal act as a gateway (so the external site
can be locked down to only the web server), handle content changes, and even rewrite the
external content on the fly to match your theme. Going further, it can drop the iframe
entirely and merge the external HTML straight into a Drupal page for seamless
interaction (at the cost of possible CSS/JS conflicts, which usually need some
on-the-fly tweaking).

Because it can fetch a remote site **server-side**, treat Site Integrator like a proxy:
make sure the external host is one you trust, and constrain what can be requested so the
server isn't tricked into fetching internal or unintended URLs (a server-side request
forgery, or SSRF, risk). If it forwards requests or cookies, be mindful of not leaking
session data, and if you embed via iframe, remember the usual third-party-content
implications. The module has no dependencies beyond core, adds its own permission, and
is in the **Services** package. Note the project is currently **beta** and **not covered
by Drupal's security advisory policy**.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

After enabling, open the site's **Configuration** page and look under the **External
Data** section for a link to list, add, or edit **Integrated Sites**. That is where you
define each external site you want to bring in — its URL and whether it is presented as
a classic iframe, an enhanced (server-side-fetched) iframe, or merged HTML — and where
you manage them afterwards.
