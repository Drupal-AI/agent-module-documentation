<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce License Og Role adds a Commerce License type that, while active, grants a purchaser a role in an Organic Groups (OG) group — turning a product purchase into timed group membership/role access.

---

It provides the `commerce_license_og_role` license type plugin (`OgRole`, extending `LicenseTypeBase`) implementing `ExistingRightsFromConfigurationCheckingInterface` and `GrantedEntityLockingInterface`. When a license of this type becomes active it creates/updates the buyer's OG membership and assigns the configured OG role in the configured group; when the license expires or is revoked the granted membership/role is removed. The license configuration references a target group (via `dynamic_entity_reference`) and an OG role, and the module locks the granted entity so the referenced group/role can't be pulled out from under an active license. Existing-rights checking prevents selling access a user already has.

Security-wise it ships one restricted permission, `grant group roles with licenses in any group`, that lets a license grant membership of *any* group (bypassing per-group control) and is marked `restrict access: true`; an OG permission-event subscriber additionally registers a per-group `grant group roles with licenses` permission (default for OG administrators, restricted) so group admins can allow this only within their own group. Typical setup: enable, create a product variation with a `commerce_license_og_role` license, choose the group and OG role granted, and configure license duration. It requires og, commerce_license, and dynamic_entity_reference.
---
Sell timed membership to an Organic Group.
- Grant an OG role automatically on license activation.
- Revoke the OG role when the license expires.
- Bundle group access into a Commerce product.
- Configure which group a license grants access to.
- Configure which OG role the license assigns.
- Offer subscription-style recurring group access (with recurring).
- Prevent selling access a user already holds (existing rights).
- Lock the granted group/role while a license is active.
- Restrict who can grant roles in any group via a permission.
- Let group admins allow license-granted roles per group (OG permission).
- Use dynamic entity reference to target different group entity types.
- Grant membership of the default membership type for a group.
- Tie paid access to a specific OG role tier.
- Automatically create an OG membership on purchase.
- Remove the OG membership on cancellation/refund.
- Combine with Commerce checkout to gate group content.
- Model "join this group by buying" flows.
- Provide role-based paywalled group content.
- Manage access duration through the license period.
