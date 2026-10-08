# SSO Connector – Autologout — manual setup guide

**SSO Connector – Autologout** (`sso_connector_autologout`) makes the contributed
Autologout module aware of a federated SSO session, so a user who is still active
elsewhere in the SSO network is not logged out here — while genuine idle and
maximum-lifetime timeouts stay enforced.

Normally the Autologout module tracks activity on one site in isolation: sit idle
on this Drupal site and it logs you out, even if you are busy on a sibling site in
the same single sign-on network. This module bridges that gap. On each
authenticated request it asks the SSO Connector Cookie service to
*cryptographically validate* the shared SSO cookie, and only then does it refresh
Autologout's idle-activity marker. A cookie that is merely present, or a forged
one, never extends the session — the check is fail-closed. It runs before the
contributed Autologout subscriber, and if the cookie submodule is absent it simply
falls back to the contributed timeouts unchanged.

Alongside the SSO-awareness it keeps the idle and absolute maximum-lifetime
timeouts, offers an optional signed, cross-site activity cookie (HMAC-verified) to
share recent activity across the network, and guards the logout redirect
destination against open-redirect abuse — validating it both at runtime and when
you save the configuration.

This is a submodule of the SSO Connector suite. It depends on **SSO Connector**
(`sso_connector`), the contributed **Autologout** module (`autologout`, required),
and core **Help**, and it strongly recommends **SSO Connector Cookie** so there is
a cryptographic SSO session to validate. It requires Drupal 11.2 (or 12).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Autologout and SSO Connector.

## How to configure it

The idle and maximum-lifetime timeout *values* live in the contributed
**Autologout** module's own settings — configure those as you normally would.
This module layers SSO-awareness on top and adds a couple of its own options: an
optional signed cross-site activity cookie, and the logout redirect destination
(which it validates against open-redirect abuse when you save it). Set those, then
test that a user active on a sibling SSO site is not logged out here, while an idle
user still is.
