# Roles and Permission Builder — manual setup guide

**Roles and Permission Builder** (`roles_permission_builder`) lets you define your
site's roles and the permissions assigned to them in **YAML files**, then (re‑)build
those roles from the files. Instead of clicking through the People → Permissions
grid by hand on every environment, you describe the access model once, in code,
and apply it repeatably — which makes it a natural fit for deployment workflows
and keeping development, staging, and production in sync.

The important thing to internalize is what those YAML files really are: they are
**security policy**. Because the module *grants* permissions to roles straight
from the files, whatever the files say becomes your access model. A single added
line can hand a role a dangerous permission such as `administer users` or
`administer permissions`. Treat the files accordingly.

In practice that means: keep the YAML in version control alongside your code,
**control who can edit it**, and **review every change** the same way you would
review any access‑control change — because that is exactly what it is. A careless
edit here is a privilege‑escalation risk, not a cosmetic tweak.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no settings form** for this module — its configuration *is* the YAML
files, described in "How it works" below.

## How it works

Roles and Permission Builder is driven entirely by one or more YAML files that
declare each role and the permissions it should receive. When the module builds
(or rebuilds) roles, it reads those files and applies the declared permission
assignments to the matching roles on your site.

Because the files define the access model, adopt the same discipline you would
for any sensitive configuration:

- **Store the YAML in version control** with your codebase.
- **Restrict who can change it** — edit access to these files is effectively the
  power to grant permissions.
- **Review every change** before it ships. Look closely at any newly granted
  permission, especially administrative ones.

If you are unsure exactly how a given permission behaves, confirm it on the core
**People → Permissions** screen before adding it to a YAML file.
