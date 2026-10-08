<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
OIDC Refresh refreshes the OIDC session through AJAX.

---

OIDC Refresh **keeps an OpenID Connect session alive** — periodically refreshing the OIDC session via AJAX
(optionally only on user interaction) so a logged-in SSO session doesn't expire while the user is active. It
depends on the OIDC module, provides its own permissions, in the OIDC package.

Use it to prevent premature OIDC session timeouts. It is an authentication-support feature; the actual **token/
session handling is done by the OIDC module** (this just triggers refreshes on an interval), so it stores no
tokens of its own. Note: keeping sessions alive indefinitely has a trade-off (a walk-away session stays valid) —
use the interaction-only option and sensible intervals. It has no access-control role beyond its permission.
Configure the refresh interval.

---

- Keep the OIDC session alive.
- Refresh via AJAX at an interval.
- Support interaction-only refresh.
- Depend on the OIDC module.
- Provide its own permissions.
- Avoid premature timeouts.
- Let the OIDC module handle tokens/session.
- Store no tokens of its own.
- Mind the walk-away-session trade-off.
- Have no access-control role beyond permission.
- Configure the interval.
- Handle OIDC refresh.
- Refresh sessions.
- Configure the refresh.
- Keep sessions alive.
- Handle the integration.
- Refresh OIDC.
- Extend sessions.
- Use sensible intervals.
- Provide OIDC refresh.
