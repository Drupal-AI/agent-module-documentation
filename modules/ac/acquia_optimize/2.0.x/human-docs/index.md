# Acquia Web Governance (Acquia Optimize) — manual setup guide

**Acquia Web Governance** (`acquia_optimize`, formerly *Acquia Optimize*) connects
your Drupal site to Acquia's governance platform, which continuously crawls the
site and reports **SEO problems, accessibility violations, readability scores and
policy breaches** — then surfaces those findings back inside Drupal where the
people who can fix them already work.

The value of a governance platform over a one-off audit is that it keeps scanning.
A site that passed its accessibility checks at launch drifts as editors add
content: broken links, thin pages and unlabelled images accumulate where nobody is
looking. This module puts the results in front of editors — there is a dashboard, a
quick-scan for checking a single page, a preview, and a form addition that shows the
readability score and SEO issues **on the node edit form itself**, so an editor sees
problems before publishing.

Two permissions keep the roles sensibly apart: one for **running scans** (which cost
time and vendor quota, and is access-restricted) and one for **the connection
settings**. You will need an Acquia Web Governance account and its API key to
connect the site.

**A note on the API key.** The key is stored in this module's configuration. The
settings form masks it on screen and preserves the stored value, which is careful —
but masking is a display measure, not storage: the key still lives in config, so it
ends up in any config export, repository or database dump. The module does not offer
a Key entity. If you can, put the key in an environment variable and reference it
from `settings.php` with a config override, so your exported configuration carries
nothing secret.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — connect your account, the API key, and
   the two permissions.

## Where it lives in the admin menu

The connection settings live at the module's settings form
(`acquia_optimize.admin_settings`) under Drupal's configuration. Once connected, the
governance dashboard and quick-scan tools are reachable from the admin, and findings
also appear directly on the node edit form.

## How to use it

Sign in to your Acquia Web Governance account, enter its API key on the module's
settings form to connect the site, grant the scan and administer permissions to the
right roles, and then let the platform crawl. Editors see SEO and readability
feedback on the pages they edit; you can trigger a quick scan of a single page on
demand or review the full dashboard for site-wide governance status.
