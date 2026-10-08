# Administrator Login — manual setup guide

**Administrator Login** (`administrator_login`) is intended to limit login and
password-reset access to administrators only. When enabled, it adds a validation
handler to Drupal's login form that blocks any account without the `administrator`
role from logging in through that form — the idea being to lock a site (for
example a staging or staff-only site) down so that only administrators can sign
in. It depends on core's **User** module and supports Drupal 10 and 11.

**Important limitation — read before relying on this.** The restriction is
**form-only**. It hooks the HTML login form's validation, but Drupal core also
exposes a JSON login endpoint (`POST /user/login?_format=json`) that never builds
that form, so the module's check never runs there. A non-administrator can still
authenticate through the JSON endpoint — and through other authentication
providers such as basic auth or OAuth if they are enabled. In other words, this
module blocks the everyday browser login form but does **not** actually restrict
authentication, so it can give a false sense of security. The password-reset guard
has the same limitation.

If your real goal is to lock a site to administrators only, do not rely on this
module alone. Enforce the restriction at the authentication / request layer
instead — for example an event subscriber that rejects non-admin logins on every
route — and disable or deny the JSON login route and any REST / basic-auth
providers for non-admins. This is called out plainly in the sibling agent docs;
treat this module as a cosmetic gate on the login form, not a security boundary.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no settings page. The module works by altering the core login and
password-reset forms once enabled.

## How to use it

Enable the module and the login form immediately begins rejecting non-administrator
accounts. Because the protection is form-only (see the limitation above), you must
independently close the other authentication entry points — the JSON login route
and any REST / basic-auth / OAuth providers — if you actually need an
administrators-only site. Test by attempting a non-admin login both through the
browser form (blocked) and through `POST /user/login?_format=json` (not blocked by
this module) so you understand the real coverage.
