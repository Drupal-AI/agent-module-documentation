<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Editoria11y si (SiteImprove) — agent index

Imports SiteImprove QA data (**broken links**, **misspellings**, **reading scores**) and displays it as in-page Editoria11y tips plus admin report views. Depends on `editoria11y` (`^3.0`) and `key`. Core `^11`. Version **3.0.0**. Config UI at `/admin/config/content/editoria11y/si`.

- **Set up credentials, domain, checks, cron, reports** → [configure/editoria11y_si.md](configure/editoria11y_si.md)
- **Import service, cron helper, queue worker, entity/data model** → [api/editoria11y_si.md](api/editoria11y_si.md)
- **Permissions that gate config and reports** → [permissions/editoria11y_si.md](permissions/editoria11y_si.md)

Gotcha: the import queue worker type-hints Purge services but the module does not declare `purge` as a dependency — install Purge or cron processing may fail. Also requires an active SiteImprove subscription + API key.
