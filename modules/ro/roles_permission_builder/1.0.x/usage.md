<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Roles and Permission Builder builds roles and permissions from YAML files.

---

Roles and Permission Builder **builds roles and permissions from YAML files** — a declarative way to define
roles and their permission assignments in YAML and apply them to the site, for repeatable/deployable access setup.
It works on core 10–11.

Use it to manage roles/permissions as code. It is an access-configuration/deployment tool, and its YAML files are
effectively **security policy**: because the module **grants permissions to roles from those files**, the files
determine your access model — so **control who can edit the YAML** (they live in code/config), **review every
change carefully** (a single line can grant a dangerous permission like `administer users` or `administer
permissions`), keep them in version control with code review, and treat them exactly like the sensitive
access-control configuration they are. It has this configuration role. Configure the role/permission YAML.

---

- Build roles and permissions from YAML.
- Grant permissions to roles declaratively.
- Apply repeatable access setup.
- Serve access configuration/deployment.
- Manage roles/permissions as code.
- Define access in YAML.
- TREAT the YAML files as security policy.
- GRANT permissions from the files (they determine the access model).
- Control who can edit the YAML + review every change (a line can grant a dangerous permission).
- Keep them in version control with code review.
- Configure the role/permission YAML.
- Handle role/permission building.
- Build roles.
- Configure the YAML.
- Grant permissions.
- Handle the config.
- Apply permissions.
- Define roles.
- Review the YAML.
- Provide YAML role/permission building.
