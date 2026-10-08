<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce License Entity Field adds an `entity_field` Commerce License type whose grant writes a configured value onto a field of a user-owned entity (for example flipping a boolean or setting the `promoted` flag on a node).

---

The problem it solves is selling an "upgrade" to an existing entity: the product configures which field and which value to set, and the purchasing customer chooses which of their entities the license targets (stored on the license's `license_target_entity` dynamic entity reference field). When the license is active the value is applied; the module's `hook_form_alter()` also removes the delete action from the target entity's edit form and shows a status message, so an entity cannot be deleted while a license controls one of its fields (which would leave a subscription in an illogical state).

Note the README declares the module INCOMPLETE: the customer-facing entity-selection widget in the license cart form is not finished, and configuration options for target entity/field selection are only partially implemented in the `EntityField` license type plugin. Treat it as a starting point requiring custom code, not a turnkey solution. It defines no routes, permissions or services of its own and relies entirely on Commerce License's plumbing.
---
- Sell an upgrade that toggles a boolean field on a node the buyer owns.
- Grant a license that sets the `promoted` flag on a purchased entity.
- Model "feature unlock" purchases as a field value change instead of a role.
- Configure the target field and value on the product variation's license.
- Let the buyer choose which of their entities receives the field change.
- Tie a field value to an active Commerce License lifecycle (grant/expire/revoke).
- Prevent deletion of an entity while an active license controls its field.
- Show buyers a status message explaining why the locked entity cannot be deleted.
- Combine with commerce_license subscriptions for recurring paid field access.
- Use dynamic_entity_reference to target any entity type from one license field.
- Extend the `entity_field` license type plugin to add missing config UI.
- Build a custom entity-reference selection plugin limiting choices to owned entities.
- Reset the field value automatically when the license expires (via commerce_license).
- Audit which licenses target a given entity via the license storage query.
- Prototype paid content-promotion features on a Commerce store.
- Restrict the upgrade to specific entity bundles once config is completed.
- Pair with commerce_license_role where some upgrades are roles and some are fields.
- Test license grant/revoke effects on the target field in a kernel test.
