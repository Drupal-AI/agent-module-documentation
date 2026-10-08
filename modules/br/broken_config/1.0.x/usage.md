<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Broken Configuration finds configuration that is broken or references missing dependencies.

---

Broken Configuration provides a scan that inspects the site's active configuration and reports broken or invalid entries — for example config referencing missing modules, plugins, or dependencies. It helps operators find and fix configuration problems before they cause runtime errors.

It's a developer/operations diagnostic gated by `scan broken configuration`; it reads config but doesn't change it. Depends on core `config`; supports Drupal 10 and 11.

---

- Scan configuration for problems.
- Find broken config entries.
- Detect missing dependencies.
- Report invalid configuration.
- Help fix config before runtime errors.
- Gate with `scan broken configuration`.
- Read config without changing it.
- Depend on core `config`.
- Support Drupal 10 and 11.
- Aid operations/diagnostics.
- Surface config referencing missing modules.
- Improve config health.
- Act as a developer tool.
- Audit the active configuration.
- Prevent runtime failures.
- List problematic config.
- Support maintenance workflows.
- Diagnose configuration issues.
