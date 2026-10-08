<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Acquia Purge Varnish Test mocks an Acquia Cloud environment so the purge integration can be exercised locally. Its own description says: **do not enable on production.**

---

The purge module needs an Acquia environment to talk to, and a developer's laptop is not one. Without a mock, the integration can only be tested by deploying it, which is the wrong place to find out that a purge targets the wrong environment.

This submodule supplies the mock: enough of an Acquia environment's shape for the purge code to run through its paths locally, so a change can be exercised before it reaches a real Varnish.

**The warning in its own info file is the important part of this documentation.** *"Mock Acquia environment for local testing. DO NOT enable on production."* A module that makes the site believe it is in an Acquia environment when it is not will, at best, make purges silently do nothing — which means cached pages stay stale and nobody notices until a customer reports last week's content. Worse combinations are possible depending on what the mock reports.

Treat it exactly as the class of module `vitals_extra`'s dev-modules check exists to catch: fine locally, and an active liability if it survives a deployment. Check for it during a production audit of any site running the purge integration.

---

- Test the purge integration locally.
- Exercise purge code without an Acquia environment.
- Verify a purge change before deploying.
- Mock environment detection in development.
- Run the integration's tests.
- Avoid testing cache purging in production.
- Confirm purge targets the intended environment.
- Develop against the purge API offline.
- Keep the module out of production.
- Audit production for enabled test modules.
- Detect a mock left enabled after a deployment.
- Explain purges that silently do nothing.
- Include it in a dev-modules check.
- Uninstall it before a release.
- Document the mock's behaviour for the team.
