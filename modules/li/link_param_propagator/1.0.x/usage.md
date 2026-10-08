<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Link Param Propagator appends configured query parameters to anchor tags in a specific DOM element.

---

Link Param Propagator appends configured query parameters to links — adding a set of query params
(e.g. campaign/UTM or tracking parameters) to the anchor (`<a>`) tags inside a specified DOM element, so
outbound/internal links carry the parameters. It is configured at `link_param_propagator.settings`, in the
SEO package.

Use it to propagate query params (campaign/tracking) onto links. It is an SEO/front-end feature that
rewrites link hrefs client-side; it does not change content or access. Note it adds parameters to links
(a tracking/marketing use) — the parameters are admin-configured. It has no access-control role. Configure
the parameters and target element.

---

- Append query params to links.
- Add UTM/campaign parameters to anchors.
- Target links in a DOM element.
- Configure at link_param_propagator.settings.
- Carry parameters on links.
- Rewrite hrefs client-side.
- Not change content or access.
- Have no access-control role.
- Use admin-configured parameters.
- Configure the parameters.
- Handle link parameters.
- Propagate query params.
- Add tracking params.
- Configure the target element.
- Append parameters.
- Handle campaign params.
- Add link params.
- Configure propagation.
- Rewrite links.
- Add params to anchors.
