# Secure Domain Login — manual setup guide

**Secure Domain Login** (`secure_domain_login`) restricts *which domain names* can
reach your site's `/user` pages. If your site answers on more than one hostname — say
a public marketing domain and a separate admin subdomain — this module lets you say
"the login and account pages are only allowed on these hosts," and it redirects any
`/user` request arriving on a different host to the front page.

It works by watching every response: it takes the request's Host header, compares it
against a comma-separated whitelist of domains you configure, and if the host is not
on the list *and* the path contains `/user`, it swaps the response for a redirect to
the site's front page. So a visitor hitting `/user/login` on your public domain lands
back on the home page, while the same page on your whitelisted admin host loads
normally.

Be clear about what this is: a **coarse, best-effort deterrent**, not a robust
access-control layer. It trusts the client-supplied Host header (which can be spoofed
behind a naive proxy), it matches `/user` as a substring anywhere in the path, and it
only acts at response time. Most importantly, if the whitelist is left **empty or
misconfigured**, *no* host matches — which redirects **all** `/user` traffic,
including your own login form, to the front page and can lock everyone out. Always
populate the whitelist carefully before relying on it, and layer it on top of real
web-server-level host restrictions for anything sensitive.

This guide is written for a **human** clicking through the admin UI. If you are an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter the allowed login domains (do this
   before relying on the module).

## Where it lives in the admin menu

The settings form is at **`/admin/config/secure-domain-login`** (config route
`secure_domain_login.config`). Access to it is gated by the **Administer secure domain
login configuration** permission — grant it only to trusted roles.
