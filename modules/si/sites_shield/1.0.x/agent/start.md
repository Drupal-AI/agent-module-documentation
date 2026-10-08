<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sites shield (sites_shield) — agent index

**Per-site HTTP Basic-Auth gate enforced in the kernel request pipeline.**

- **Version:** 1.0.x
- **Core:** ^11.2 || ^12
- **Dependency:** sites
- **Permission:** `skip sites_shield auth` (bypass the shield)
- **Services:** `sites_shield.subscriber` (`SitesShieldSubscriber`, KernelEvents::REQUEST priority 33), `DisallowBasicAuthRequests` page-cache request policy
- **Setting:** per-site `sites_shield` = {user, hashed pass}, read from `@current_site`
- **Security:** Enforcement is fully server-side (request subscriber returns 401 before routing); password compared with the password service against a stored hash; no bypass path observed. Not active when no username is set. No security findings.
