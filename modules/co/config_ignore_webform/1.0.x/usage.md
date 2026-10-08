<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Ignore Webform ignores webform config during config import/export (except templates/exclusions).

---

Config Ignore Webform **excludes webforms from config sync** — configuring Config Ignore to ignore webform and
webform-options configuration (except templates and configured exclusions), so site-editors' webforms aren't
overwritten on config import. It depends on the Config Ignore and Webform modules.

Use it to protect editor-managed webforms from deployment overwrites. It is a configuration-management feature; it
changes what config sync manages and has no content or access role. Note: ignored config isn't tracked in
version control — accept that trade-off for the editor-managed forms. Configure the ignore patterns.

---

- Ignore webform config on import/export.
- Protect editor webforms from overwrite.
- Keep templates/exclusions tracked.
- Depend on Config Ignore + Webform.
- Serve configuration management.
- Exclude webforms from sync.
- Change what config sync manages.
- Accept that ignored config isn't version-controlled.
- Have no content/access role.
- Configure the ignore patterns.
- Handle config ignore.
- Ignore webforms.
- Configure the ignores.
- Protect webforms.
- Handle the sync.
- Exclude config.
- Configure Config Ignore.
- Handle the deployment.
- Skip webforms.
- Provide webform config ignore.
