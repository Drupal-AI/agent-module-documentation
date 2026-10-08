<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# 2factor.app (twofactor) — agent index

Second authentication factor delegating verification to the **external 2factor.app** SaaS. A
`KernelEvents::REQUEST` subscriber redirects a 2FA-enabled user to `/user/{uid}/twofactor/auth` until
the session flag `twofactor.allowed` is set. Version **8.x-1.4**. Core `^10.3||^11||^12`.

The challenge page calls `set_auth`; the polling path (`get_auth`) marks the session verified on
`code:100` / `request_status:2`. The factor depends on the external 2factor.app service being
reachable at authentication time.
