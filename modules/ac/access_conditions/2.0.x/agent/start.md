<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Access Conditions — agent orientation

Reusable, condition-plugin-based visibility rules exposed as `access_model` config entities plus an `AccessChecker` service.

Key files:
- `src/AccessChecker.php` — `checkAccess(AccessModelInterface)`, uses `ConditionAccessResolverTrait`, applies context mappings, honors `bypass access conditions access`, exposes cache metadata.
- `src/Entity/AccessModel.php` — config entity holding conditions + logic.
- `src/Plugin/Condition/AccessModel.php` — a Condition plugin wrapping a model.
- `modules/entity/` — submodule adding the `access_model` reference field type/widget/formatter.

Consumers (this module only decides; it does not gate routes itself): `access_conditions_field_group`, `access_conditions_commerce`. They call the checker and set `#access`/pane `isVisible()`.

Security posture: sound. Decision goes through core condition resolution; bypass is an explicit restricted permission; no fail-open path. Admin routes require `administer access models`.
