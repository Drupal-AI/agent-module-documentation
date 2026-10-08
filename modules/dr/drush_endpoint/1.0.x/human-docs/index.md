# Drush Endpoint — manual setup guide

**Drush Endpoint** (`drush_endpoint`) exposes a small set of Drush commands over
HTTP so they can be triggered with a POST request. It exists for **automated
testing**: when your test suite (for example Cypress) runs in a different
container from your web server and cannot call Drush directly, this module lets
the tests reach a handful of maintenance commands over HTTP instead — clearing
caches, running cron, resetting migrations, or getting a one-time login link.

Commands are reached at `POST /api/drush/{command}`, and only a short allowlist is
permitted: `cr`, `cron`, `uli`, `mim`, `mr`, `sapi-i`, and `sapi-r`. It supports
Drupal 10, 11, and 12.

**Read this before you install it.** This is a remote command-execution surface
intended purely for automated testing. The endpoint is **off unless you explicitly
enable it** in a settings file. Treat it as a testing-only tool for isolated
development and CI environments — enable it there and nowhere else. Never switch it
on for a public or production site, and firewall the `/api/drush/*` path so it is
not reachable from outside your test environment.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and switch the endpoint on in `settings.local.php`.

There is **no admin configuration page** for this module — it is switched on and
off entirely through settings flags in code, covered in
[Installation](installation/index.md).

## How to use it

Once enabled (see [Installation](installation/index.md)), a test or script sends a
**POST** request to `/api/drush/{command}`. For example, to run cron from a
Cypress test:

```js
cy.request({
  method: 'POST',            // must be POST
  url: '/api/drush/cron',
});
```

Or from the command line with cURL:

```bash
curl -X POST https://SITENAME.ddev.site/api/drush/cron
```

Requesting a one-time login link works the same way and returns JSON containing
the link:

```js
cy.request({ method: 'POST', url: '/api/drush/uli' }).then((response) => {
  const uli = response.body.output.trim();
  cy.visit(uli);   // you are now logged in
});
```

Note that `uli` requires an extra opt-in flag beyond the general enable flag — see
[Installation](installation/index.md).
