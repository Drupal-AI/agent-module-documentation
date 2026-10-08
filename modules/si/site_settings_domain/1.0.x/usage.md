<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Site Settings Domain makes Site Settings entities domain-specific via the Domain module.

---

Site Settings Domain adds domain context to Site Settings entities — so a multi-domain site (using the Domain module) can have per-domain values for its site settings, letting each domain override shared settings with its own. It bridges Site Settings and Domain.

Deleting domain-specific settings is gated by `delete domain context specific site setting entities`. Depends on `site_settings` and `domain`; supports Drupal 10.3+ and 11.

---

- Add domain context to Site Settings.
- Support per-domain settings.
- Override shared settings per domain.
- Serve multi-domain sites.
- Bridge Site Settings and Domain.
- Gate deletion with a dedicated permission.
- Depend on `site_settings` and `domain`.
- Support Drupal 10.3+ and 11.
- Configure per-domain values.
- Manage domain settings.
- Support Domain module sites.
- Handle setting overrides.
- Provide domain scoping
- Manage multi-domain config
- Override site settings.
- Support domains.
- Scope settings.
- Configure per domain
