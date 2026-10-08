<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drutopia Group provides a Group type (built on the Group module) that can be classified by a group-type vocabulary, giving grassroots organisations their own mini-site within a Drutopia install.

---

Unlike the other Drutopia content-type features, this one builds on the contributed **Group** module (`group`, `gnode`) rather than a node type: it installs a `group` group type with address, description, email, phone, website, image, summary and group-type fields, group roles (member/outsider/anonymous), a group-membership relationship type, and Views for groups and their relationships. Each group gets its own page where its campaigns, actions and articles can be gathered, creating a mini-site for the organisation. It also ships a `config_perms` custom-permission entity (`administer_groups`) and augments the Drutopia `manager` role via `config/actions`.

The module is config-only apart from a small `.install` file: `drutopia_group_install()` calls `node_access_rebuild(TRUE)` so node grants reflect group membership after install. There are no custom routes, controllers, services or PHP permissions; access is enforced by the Group module's own membership/permission system plus the installed config_perms entity. Setup: install the Group and Address projects, enable this feature, then create groups and classify them with the group_type vocabulary.

---
- Add a Group type for grassroots organisations to a Drutopia site
- Give each organisation its own group page / mini-site
- Classify groups with the group_type taxonomy vocabulary
- Store a group's postal address (Address field)
- Record group contact details: email, phone, website
- Add a group description, summary and image
- Manage group membership via the Group module relationship type
- Assign group roles (member, outsider, anonymous)
- Delegate group administration via the config_perms 'administer_groups' entity
- Browse a Views listing of groups
- Browse a Views listing of group relationships/memberships
- Auto-generate URL aliases for groups, group types and memberships
- Rebuild node access grants so group membership gates node visibility
- Gather a group's campaigns, actions and articles on its page
- Grant the Drutopia manager role group permissions
- Show default/teaser/full view displays for groups
