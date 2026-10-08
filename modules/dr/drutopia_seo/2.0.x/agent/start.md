<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drutopia SEO (drutopia_seo) — agent index

**Config-only Drutopia feature installing baseline SEO defaults: a meta tags field plus Metatag and Redirect configuration.**

- **Version:** 2.0.x
- **Core:** ^10.2 || ^11 || ^12
- **Depends:** drutopia_core, metatag, redirect, redirect_404, field, node
- **Config-only** (`config/install`): `field.storage.node.field_meta_tags` (shared meta tags field); SEO behaviour delegated to Metatag/Redirect.
- **No PHP, no routes, no services, no permissions.**

**Security:** No code or endpoints; behaviour delegated to the Metatag and Redirect dependencies. No anonymous/mutating surface, no TLS/credential handling. No security findings.