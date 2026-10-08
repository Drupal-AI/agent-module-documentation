<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A configuration-only Drutopia "feature" that layers sensible search-engine-optimization defaults onto a site.

---

The module ships no PHP; its `config/install` provides a shared meta-tags field storage (`field.storage.node.field_meta_tags`) and, via its dependencies on Metatag, Redirect and Redirect 404, wires up default metatag and redirect behaviour. It is intended as a base feature so other Drutopia features (for example drutopia_landing_page) can attach the meta tags field to their content types and inherit consistent SEO configuration.

Because it is pure configuration, the module defines no routes, services, permissions, or callbacks and makes no outbound requests. Its behaviour is entirely governed by the Metatag and Redirect modules it depends on. Typical use is enabling it early in a Drutopia build so that content types gain a meta tags field and the site benefits from redirect and 404-redirect handling without bespoke setup.
---
- Add default SEO configuration to a Drutopia site
- Provide a shared meta tags field for content
- Attach metatags to node content types
- Inherit Metatag defaults across the site
- Enable redirect handling for changed URLs
- Capture and redirect 404s via redirect_404
- Serve as an SEO base feature for other Drutopia modules
- Give landing pages a consistent meta tags field
- Improve discoverability with sensible metatag defaults
- Standardize meta-tag configuration across content types
- Reduce boilerplate when configuring site SEO
- Bootstrap search-engine metadata on a new build
- Pair with drutopia_landing_page for page metatags
- Provide the field_meta_tags storage other features reuse
- Maintain redirects when content URLs change
- Audit a Drutopia site's baseline SEO config