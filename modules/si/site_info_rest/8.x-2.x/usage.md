<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Site Info REST adds a rest resource with basic site info.

---

Site Info REST **adds a REST resource exposing basic site info** — returning the site name, slogan, logo and
favicon URLs as JSON, so a decoupled front-end can fetch site branding. It depends on core REST, in the Web
services package.

Use it to serve site branding to a decoupled front-end. It is a decoupled/web-services feature and it is
low-sensitivity: the resource returns only **public branding** (name/slogan/logo/favicon — not version or module
information), and being a REST resource it is **permission-gated** (grant the `restful get` permission to the
intended audience). It has no access-control role beyond that REST permission. Enable and configure the
resource.

---

- Expose basic site info via REST.
- Return name/slogan/logo/favicon.
- Serve decoupled front-ends.
- Depend on core REST.
- Serve web services.
- Provide site branding.
- Return only PUBLIC branding (no version/module info).
- Be permission-gated (restful get).
- Grant the permission to the intended audience.
- Have no access-control role beyond the REST permission.
- Enable and configure the resource.
- Handle site-info REST.
- Serve branding.
- Configure the resource.
- Expose branding.
- Handle the integration.
- Return site info.
- Fetch branding.
- Gate the resource.
- Provide a site-info REST resource.
