# Field Login & Simple OAuth Password Grant — manual setup guide

**Field Login & Simple OAuth Password Grant** (`field_login_simple_oauth`) bridges
the [Field Login](https://www.drupal.org/project/field_login) and
[Simple OAuth](https://www.drupal.org/project/simple_oauth) modules so that an
OAuth2 **password-grant** token can be obtained using a configured login field —
for example an email address or a phone number — in place of the account name. It
extends to the API/token world the same idea Field Login brings to the browser
login form: let people authenticate by a familiar identifier instead of their
Drupal username.

Importantly, the grant does **not** bypass authentication. Its user repository
loads the account by the field value and then calls Drupal's
`authenticateAccount($account, $password)`, so the password is genuinely verified
before any token is issued — a wrong password gets no token. It builds directly on
Simple OAuth (6.x and later) and Field Login (3.x and later), and it supports
Drupal 10.3 and 11.

> **Heads-up — this project is no longer maintained.** The maintainers mark it as
> obsolete and recommend using
> [Simple OAuth Password Grant](https://www.drupal.org/project/simple_oauth)
> instead. Treat this documentation as a reference for existing installs rather
> than a recommendation for new sites.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Simple OAuth and Field Login.

There is **no configuration page** for this module. It has no settings form of its
own: once enabled, it registers a field-aware password grant, and the identifier
used for login comes from your **Field Login** configuration. Simple OAuth's own
consumers, scopes, and keys are configured in the Simple OAuth module.

## How to use it

1. Configure **Field Login** first — choose which user field acts as the login
   identifier (see the Field Login module's own settings at
   `/admin/config/people/accounts/field-login`).
2. Configure **Simple OAuth** as usual — set up your keys and at least one consumer.
3. With this module enabled, clients requesting a password-grant token can send the
   configured field's value (for example an email or phone number) as the
   `username` parameter, together with the account's password. The module resolves
   the account from that field and verifies the password before issuing the token.
