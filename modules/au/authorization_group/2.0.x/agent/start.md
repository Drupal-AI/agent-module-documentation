<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Authorization - Group (authorization_group) — agent index

**Authorization consumer plugin that provisions Group memberships and Group roles from an Authorization provider's mappings.**

- **Version:** 2.0.x
- **Core:** ^9 || ^10 || ^11
- **Dependencies:** group, authorization
- **Plugin:** `@AuthorizationConsumer(id="authorization_group")` → `GroupConsumer` (extends `ConsumerPluginBase`).
- **Key methods:** `buildRowForm()` (Group+role select), `grantSingleAuthorization()` (`$group->addMember()` + append group role), `revokeGrants()` (strip roles or delete membership per `delete_membership` config).
- **Routes/permissions:** none of its own; runs inside Authorization's grant/revoke lifecycle.

**Security:** No routes or request input; a back-office provisioning consumer only. Skips anonymous users and global group roles; membership/role writes happen only through Authorization profile application. No security findings.

See [configure/mappings.md](configure/mappings.md).