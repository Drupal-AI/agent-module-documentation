<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Persistent URL (PURL) provides a framework for modifying URLs based on context.

---

Persistent URL (PURL) provides a framework for modifying URLs based on context — letting other modules
define URL "modifiers" (a path prefix, subdomain, domain, etc.) that establish a context from the URL and
rewrite outbound links to preserve it. It is the foundation used by context-aware features (e.g. per-group or
per-workspace URLs). It is in the System package.

Use it as the underlying framework when a context needs to be carried in the URL. It is a site-structure/
routing framework; the context it establishes is used by consuming modules (which enforce their own access),
and PURL itself resolves/rewrites URLs and has no access-control role. Configure it via the modules that
provide PURL modifiers.

---

- Modify URLs based on context.
- Define URL modifiers (prefix/subdomain/domain).
- Establish context from the URL.
- Rewrite outbound links to preserve context.
- Underpin context-aware features.
- Serve as a routing framework.
- Have consuming modules enforce access.
- Resolve/rewrite URLs.
- Have no access-control role.
- Configure via PURL-provider modules.
- Handle URL context.
- Carry context in the URL.
- Provide the PURL framework.
- Handle URL modifiers.
- Establish URL context.
- Rewrite links.
- Handle context URLs.
- Provide URL modification.
- Configure modifiers.
- Modify URLs.
