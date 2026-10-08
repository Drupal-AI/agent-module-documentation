# HTTP Headers — manual setup guide

**HTTP Headers** (`http_headers`) lets you configure the HTTP response headers your
site sends, site-wide, from the admin UI. It is primarily a **security-hardening**
tool: it is how you add and manage the browser-facing security and policy headers
that a well-locked-down Drupal site should send, such as **Content-Security-Policy
(CSP)**, **Strict-Transport-Security (HSTS)**, **X-Frame-Options**,
**Referrer-Policy**, and **Permissions-Policy**.

Getting these headers right is genuinely worthwhile — correct values mitigate
clickjacking, help block mixed content, cut down some classes of XSS, and enforce
HTTPS. The flip side is that they are powerful: a badly chosen value (an over-broad
CSP, an aggressive HSTS `max-age`) can weaken the very protection you meant to add,
or break parts of the site. So two rules apply. **Gate the configuration permission
to trusted administrators only**, since changing these headers is a privileged
action. And **test changes before you enforce them**, especially CSP and HSTS,
because their effects are wide-reaching and HSTS in particular is sticky in
browsers.

The module also provides a small **admin report that shows the current request's
HTTP headers**, which is handy for confirming what your site is actually sending
while you tune the configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the response-header settings, with the
   testing precautions for CSP and HSTS.

## Where it lives in the admin menu

Its settings form is reachable from the module's **Configure** link on the
**Extend** page (`/admin/modules`) and from the site's administration
configuration. Configuring headers is governed by the module's own permission —
grant it only to trusted administrators.
