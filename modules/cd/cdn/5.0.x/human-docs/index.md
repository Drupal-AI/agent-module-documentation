# CDN — manual setup guide

**CDN** (`cdn`) rewrites the URLs of your static files — CSS, JavaScript, images,
fonts, videos — so they are served from an **Origin Pull CDN** instead of from your
web server, *without* putting your whole site behind the CDN. Your HTML keeps coming
from Drupal; only the asset URLs point at a CDN domain, which the CDN then fetches
("pulls") from your origin the first time and caches at the edge.

It works by decorating Drupal's file-URL generator, so any public-file URL is
rewritten according to a mapping you define. The **mapping** is flexible: serve every
static file from one domain, serve only certain extensions, exclude a few (the
shipped default serves everything *except* CSS and JS), split assets across several
CDNs, or auto-balance them across domains with consistent hashing so a given file
always resolves to the same domain. A single master switch turns rewriting on or off
instantly, and you can choose scheme-relative (`//`), `https://`, or `http://` URLs.

An optional **Far Future** feature serves files through a token-protected route with
480-week cache headers, giving you forever-cacheable assets (on large sites this is
best offloaded to the web server with a few `.htaccess` rules). The module
deliberately never serves HTML, REST responses, or private files from the CDN, adds
DNS-prefetch hints so browsers connect to the CDN sooner, and prevents duplicate
content when your site sits behind a reverse proxy.

This module ships **no admin UI of its own**. You configure it either by editing the
`cdn.settings` config directly (great for config-as-code deployments) or by enabling
the bundled **CDN UI** submodule, which you can uninstall again after setup.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and (optionally) the CDN UI submodule.
2. [Configuration](configuration/index.md) — the master switch, the three mapping
   types, the URL scheme, Far Future, and eligible stream wrappers.

## Where it lives in the admin menu

The base module has no settings page. If you enable the **CDN UI** submodule, its
form appears at **Configuration → Development → CDN**
(`/admin/config/development/cdn`). Otherwise you configure everything by editing the
`cdn.settings` config object.

## How to use it

1. Provision an Origin Pull CDN pointed at your site (this is done in your CDN
   provider, not in Drupal).
2. Enable the **CDN UI** submodule (or edit config directly) to set your CDN
   domain(s) and mapping.
3. Turn on the master **status** switch to start rewriting file URLs.
4. Optionally uninstall CDN UI once configured — the settings stay in `cdn.settings`.

See [Configuration](configuration/index.md) for the mapping types and options.
