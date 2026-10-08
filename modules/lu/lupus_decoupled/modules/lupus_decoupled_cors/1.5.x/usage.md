<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lupus Decoupled CORS configures the cross-origin headers a browser-based front end needs to call Drupal's APIs.

---

A decoupled site is two origins, and browsers do not let one call the other without permission. CORS is that permission, and getting it right is the first thing that blocks a decoupled build and the last thing anyone wants to debug — the failure is a browser console message, not a server error, and the fix lives in configuration nobody has looked at.

This submodule sets it up for the suite's needs, so the front end can fetch `/ce-api` and the other endpoints from the browser. It is a hard dependency of the top-level module, which is the right call: shipping a decoupled setup without CORS configured would mean every installation starts broken.

**CORS is an access boundary, so configure it narrowly.** Its purpose is to name which origins may read responses from this site with the visitor's credentials. A wildcard origin, or a permissive configuration copied from a tutorial, hands that to anyone. List the front end's actual origins — production, staging, and the local development origin if needed — rather than `*`, and review the list when environments change. Whether credentials are allowed is a separate and equally consequential switch.

---

- Let a decoupled front end call Drupal from the browser.
- Configure allowed origins for the front end.
- Fix a blocked cross-origin request.
- Support separate production and staging origins.
- Allow a local development origin.
- Decide whether credentials may cross origins.
- Avoid a wildcard origin in production.
- Review CORS configuration during a security audit.
- Debug a browser console CORS error.
- Ship a decoupled site with CORS working by default.
- Restrict which headers may be sent.
- Restrict which methods are allowed.
- Remove a stale origin after an environment change.
- Understand why a request works in curl but not the browser.
- Document the site's cross-origin policy.