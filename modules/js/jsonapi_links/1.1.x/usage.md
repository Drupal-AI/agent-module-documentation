<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON:API Links strips the `links` members from JSON:API responses.

---

JSON:API is a HATEOAS format: every resource, relationship and collection carries `links` telling a client where to go next. That is the specification working as designed, and on a Drupal site it is also a substantial share of the payload — a collection of fifty nodes with several relationships each emits links for all of them, and a front end that constructs its own URLs reads none of it.

Removing them is a size and noise decision. Responses get materially smaller, and what remains is the data the client actually uses.

**Two things to be deliberate about, because this is deviating from a specification.** A generic JSON:API client — a library, a tool, anything that discovers rather than hard-codes — may depend on those links, so stripping them is safe for a front end you control and unsafe as a general setting. And `links` includes the `self` link, which is often how a client re-fetches or invalidates a single resource; a front end relying on that will break in a way that looks unrelated.

There is a small security-adjacent benefit worth naming honestly rather than overstating: `links` reveal the shape of the API — related resource paths, collection URLs, pagination structure — so removing them makes casual enumeration slightly harder. That is obscurity, not access control; the resources are still there and still reachable. Use `jsonapi_permission` or entity access for the actual boundary.

---

- Reduce JSON:API response size.
- Strip links a front end never reads.
- Simplify payloads for a known client.
- Speed up a large collection response.
- Reduce bandwidth on a mobile client.
- Decide whether a generic client needs links.
- Check whether a client uses the self link.
- Avoid breaking resource re-fetching.
- Recognise this as deviating from the spec.
- Make casual API enumeration slightly harder.
- Avoid treating link removal as access control.
- Use jsonapi_permission for the real boundary.
- Configure which links are removed.
- Measure payload size before and after.
- Document the module's behaviour for the team.
- Review it during a site audit.
- Verify its assumptions after an upgrade.
