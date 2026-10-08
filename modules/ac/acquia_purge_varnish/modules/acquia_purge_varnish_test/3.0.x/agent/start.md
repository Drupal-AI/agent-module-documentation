<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Acquia Purge Varnish Test (acquia_purge_varnish_test) — agent index

Submodule of **acquia_purge_varnish**. **Mocks an Acquia environment for local testing.**
Version **3.0.0**. Core `^10 || ^11`. `package: Development`.

**Its own info file says: "DO NOT enable on production."** Lead with that.

A module that makes the site believe it is in an Acquia environment when it is not will at best
make purges **silently do nothing** — cached pages stay stale and nobody notices until a customer
reports last week's content.

Exactly the class `vitals_extra`'s `DevModules` check exists to catch. Check for it when auditing
production on any site running the purge integration.