<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON:API Permission adds an `access jsonapi` permission, so a role can be allowed or denied the API as a whole.

---

Core's JSON:API has no switch of its own. It is on when the module is on, and access is decided entirely per entity — which is correct in principle and leaves a gap in practice: there is no way to say "this role does not use the API at all". A site that exposes JSON:API for a decoupled front end has, by default, also exposed it to every authenticated visitor with a browser.

This module supplies the missing coarse control: one permission, checked before the request reaches JSON:API's own handling.

**Understand what it is and is not.** It is a gate in front of the API, not a replacement for entity access. Everything JSON:API already enforces still applies to whoever passes the gate; what the permission adds is the ability to keep whole roles out, which reduces the surface an anonymous or ordinary authenticated user can probe.

**And it is a gate, so the direction of a mistake matters.** Denying it to a role that includes the decoupled front end's service account breaks the site; granting it to anonymous restores the pre-module behaviour. Set it deliberately and test both the front end and an anonymous browser after changing it.

Worth pairing with the general point about JSON:API on a decoupled site: it exposes the content model, so a resource enabled for the front end is a resource enumerable by anyone who can reach it.

---

- Deny JSON:API to a role entirely.
- Restrict the API to a service account.
- Keep anonymous users off JSON:API.
- Reduce the API surface a visitor can probe.
- Add a coarse gate in front of entity access.
- Grant API access to a decoupled front end.
- Test the front end after changing the permission.
- Test anonymous access after changing it.
- Audit which roles hold access jsonapi.
- Explain that entity access still applies.
- Limit content-model enumeration.
- Plan API access for a headless build.
- Revoke API access from a compromised role.
- Document the site's API access policy.
- Combine with per-resource controls.
