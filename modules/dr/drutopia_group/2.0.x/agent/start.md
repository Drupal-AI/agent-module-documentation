<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drutopia Group (drutopia_group) — agent index

**Provides a Group type (built on the contributed Group module) classified by a group-type vocabulary, giving organisations their own mini-site within a Drutopia install.**

- **Version:** 2.0.x (dev checkout, branch `2.0.x`)
- **Core:** `^10.2 || ^11 || ^12`
- **Package:** Drutopia — config + a small `.install`

Installs a `group` group type + fields (address, description, email, phone, website, image, summary, group_type), group roles (member/outsider/anonymous), a `group-group_membership` relationship type, the `group_type` vocabulary, Views for groups and relationships, Pathauto patterns, and a `config_perms` custom-permission entity `administer_groups`. Requires the `group`/`gnode`, `address`, `config_perms` and `ctools` projects.

**Install hook:** `drutopia_group_install()` runs `node_access_rebuild(TRUE)` so node grants reflect group membership.

**Security:** No custom routes, controllers, services or `permissions.yml`. Access is enforced by the Group module's membership/permission system plus the installed `config_perms` `administer_groups` entity. The install hook only rebuilds node access. No anonymous or mutating endpoints, no dangerous sinks. No security findings.
