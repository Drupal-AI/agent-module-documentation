<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Multistep Form Advanced (msf) — agent index

**A field_group "Form step" formatter that renders an entity form as a stepped wizard with next/prev buttons and a step indicator.**

- **Version:** 1.0.x
- **Core:** `^9 || ^10 || ^11`
- **Depends:** field_group, account_field_split
- **Plugin:** `FieldGroupFormatter` id `form_step` (`src/Plugin/field_group/FieldGroupFormatter/FormStep.php`).
- **Key class:** `MultistepController::rebuildForm()` — hides non-current steps (`#access=FALSE`), adds `FormButton`/`StepIndicator`/`FormText`, scopes `#limit_validation_errors` per step.
- **Config:** none of its own; set up entirely via Manage form display (group fields → choose "Form step" formatter).

**Security:** no routes, permissions, or services; a pure form-display formatter with no anonymous or mutating endpoint. See [configure/steps.md](configure/steps.md). No security findings.
