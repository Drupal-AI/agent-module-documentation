<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Requirement is a developer API that lets a module declare configuration requirements and suggestions as plugins, and — the part that distinguishes it — attach a fix an administrator can apply directly from a report.

---

Install it like any module (`drush en requirement`); it has no dependencies and no settings page of its own. Once enabled, a **Requirements report** appears under Reports at `/admin/reports/requirements` (permission: *administer site configuration*), and any unmet requirement is also summarized on the core Status Report at `/admin/reports/status`. The report is empty until other modules provide requirements, because the module ships none of its own — its value is the framework. As a developer you add a requirement by creating a plugin class in your module at `src/Plugin/Requirement/Requirement/`, extending `RequirementBase` with a `@Requirement` annotation (`id`, `label`, `description`, and optionally `severity` = `error`/`warning`/`recommendation`, `weight`, `group`, `dependencies`, and an `action_button_label`). You implement `isCompleted()` to report whether the requirement is met and `isApplicable()` to decide whether it is even relevant on this site; add `buildConfigurationForm()`/`submitConfigurationForm()` and an `action_button_label` to render a one-click fix that opens in a modal. Related requirements can be gathered under a fieldset by declaring a `@RequirementGroup` plugin in `src/Plugin/Requirement/RequirementGroup/` and pointing each requirement's `group` at its id, and a requirement can be hidden until its `dependencies` (other requirement ids) are completed. This is meant for configuration that cannot be automated at install time — because it needs administrator input or a decision — so the module surfaces it, explains it, and offers to do it, while still requiring the same permission as changing that configuration by hand.

---

- Install the module to get a Requirements report page.
- Add a fixable requirement to the Status Report from your module.
- Let an administrator apply a suggested fix in one click.
- Declare a module's configuration prerequisite as a plugin.
- Surface post-install setup that needs a human decision.
- Group several requirements under one fieldset.
- Hide a requirement until a prerequisite requirement is done.
- Mark a requirement as an error, warning, or recommendation.
- Order requirements in the report by weight.
- Show a suggestion only when a given module is enabled.
- Encode a site's own standards as checks that run.
- Warn about a risky permission grant.
- Suggest a recommended performance or config setting.
- Check for a configuration contradiction.
- Reduce the friction of fixing status warnings.
- Provide a modal configuration form as the fix.
- Persist the fix's changes from a submit handler.
- Enforce a deployment or go-live checklist.
- Warn when a companion module is misconfigured.
- Check that a required key or credential exists.
- Prompt to enable a suggested companion module.
- Support a site audit or readiness review.
