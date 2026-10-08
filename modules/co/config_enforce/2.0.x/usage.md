<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Enforce allows some configuration to be read-only.

---

Config Enforce lets you make **selected configuration read-only** — locking chosen config so it can't be
changed via the admin UI, keeping critical settings enforced (as defined in code/config) rather than
accidentally or maliciously modified. It is in the Configuration package.

Use it to lock down critical configuration. This is a **security/governance-positive** hardening tool: making
security-relevant settings read-only prevents a privileged user (or a mistake) from weakening them through the
UI. Note it enforces at the config layer — decide which config to lock and be aware read-only config must be
changed in code/deployment instead. It has no access-control role of its own. Configure which config is
enforced.

---

- Make selected config read-only.
- Lock critical settings.
- Prevent UI changes to config.
- Enforce config from code.
- Harden security settings.
- Keep settings enforced.
- Prevent weakening via the UI.
- Change locked config in code/deployment.
- Have no access-control role of its own.
- Configure which config is enforced.
- Handle config locking.
- Lock config.
- Configure enforcement.
- Handle the lockdown.
- Enforce config.
- Configure read-only.
- Handle governance.
- Protect config.
- Set the enforced config.
- Provide config enforcement.
