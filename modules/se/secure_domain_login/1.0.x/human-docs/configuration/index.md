# Configuration

This module has a single setting, and getting it right matters — an empty or wrong
whitelist can redirect your own login page away.

## Open the settings form

1. Log in as a user with the **Administer secure domain login configuration**
   permission (grant this only to trusted roles).
2. Go to **`/admin/config/secure-domain-login`** (config route
   `secure_domain_login.config`).

## The setting

- **WhiteList Domains** (`whitelist_domains`, required) — a textarea listing the
  host names that *are* allowed to reach `/user` pages, separated by commas with **no
  spaces**. For example:

  ```
  admin.example.com,intranet.example.com
  ```

  Any request for a `/user` path arriving on a host that is **not** in this list is
  redirected to the site's front page. A request on a listed host loads normally.

### How the host is matched

The module compares your entries against the request's Host header exactly as the
browser sends it — that is, `getHttpHost()`, which is `host` (and `:port` if a
non-standard port is in the URL). Enter the hosts precisely as they appear in the
address bar. If your site sits behind a reverse proxy that rewrites the Host header,
confirm what value actually reaches Drupal before trusting the guard.

## Save, then test

Click **Save configuration**. Then verify the behaviour:

- Request `/user` (or `/user/login`) on a **whitelisted** host — it should load.
- Request the same on a **non-whitelisted** host — it should redirect to the front
  page.

## Cautions

- **Never leave the whitelist empty.** With no entries, no host matches and *every*
  `/user` request — including your login form — is redirected to the front page.
- The check trusts the client-supplied Host header, matches `/user` as a substring,
  and only fires at response time. Treat it as a soft deterrent and pair it with
  web-server-level host restrictions for sensitive sites.
- When you add a staging or QA host, remember to add it here too; when you
  decommission a domain, remove it.
