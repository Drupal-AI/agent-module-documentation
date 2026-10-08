# LDAP SSO Auth — manual setup guide

**LDAP SSO Auth** (`ldap_sso_auth`) logs users in from an identity the web server
has already established — typically **Kerberos** or **NTLM** setting the
`REMOTE_USER` variable — and resolves that name against the servers configured by
the [LDAP](https://www.drupal.org/project/ldap) suite. It is a lighter,
faster‑feeling alternative to the `ldap_sso` module: it covers fewer use cases,
but it authenticates without any page redirects during login. The module
describes itself as the right choice when *all* of a site's content should be
visible only to authenticated users.

The premise is that authentication happened before Drupal saw the request:
Apache negotiated Kerberos, or an SSO proxy set a variable, and the resulting
username is already sitting in the request environment. This module reads that
variable, optionally trims a `@realm` or domain suffix, hands the name to the
LDAP suite's SSO login validator, and — if the directory recognises it — logs the
person in. **No password is ever involved**: the web server is responsible for
establishing the identity, and the module maps that established username onto a
Drupal account through the LDAP suite.

Because the whole flow depends on your web server actually setting the SSO
variable, the two things worth planning for are your **stack** (which server
variable your Kerberos/NTLM/proxy layer populates, and how) and your
**dependencies** (a working `ldap_servers` connection and `ldap_authentication`).
Both are covered below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm the LDAP suite dependencies.
2. [Configuration](configuration/index.md) — the settings form field by field,
   and how the SSO identity is resolved against your LDAP servers.

## Where it lives in the admin menu

The settings form (`ldap_sso_auth.admin_form`) lives with the LDAP suite at
**Administration → People → LDAP servers → LDAP SSO Auth**
(`/admin/config/people/ldap/sso-auth`). Note that although the module's help text
mentions a `/user/login/sso` route, no such route exists in this release —
automatic login is simply what the authentication provider does on each request;
there is no explicit SSO login URL to link to.
