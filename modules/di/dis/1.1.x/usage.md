Deployment identifier status (dis) adds a warning to Drupal's status report when the site's `deployment_identifier` setting is not configured.

---

The module is a tiny, dependency-free utility. It ships a single `hook_requirements()` implementation (in `dis.install`) that runs during the runtime phase of `/admin/reports/status`. It reads `Settings::get('deployment_identifier')` and, when that value is `NULL`, emits a `REQUIREMENT_WARNING` row titled "Deployment identifier" with value "Not set" and an explanation of why the identifier matters (it lets Drupal invalidate and rebuild the dependency-injection container as soon as code that changes the container is deployed). There is no configuration UI, no routes, no permissions, no services, and no schema — the module only observes the existing `$settings['deployment_identifier']` value that an operator sets in `settings.php` (or via a deployment tool). Install and uninstall each add a one-time status message. Once the identifier is set to any non-null value, the warning disappears from the status report.

---

- Surface a status-report warning on any site that has not set a deployment identifier.
- Remind operators to configure `$settings['deployment_identifier']` in `settings.php`.
- Give CI/CD pipelines a visible signal that container-invalidation on deploy is not wired up.
- Audit a fleet of sites for whether each one sets a deployment identifier.
- Catch a missing deployment identifier before it causes stale-container bugs after a code deploy.
- Teach developers about the `deployment_identifier` setting via the status-report description text.
- Encourage setting the identifier so the DI container rebuilds when contributed/custom code changes.
- Add a lightweight deployment-readiness check to an existing status-report monitoring workflow.
- Verify, after configuring the setting, that the warning clears (a quick correctness check).
- Use as a template/example of a minimal `hook_requirements()` module.
- Pair with deployment automation that stamps a git SHA or build number into the identifier.
- Detect drift where an identifier was configured on one environment but not another.
- Provide a documented reason (the description text) for why an identifier should be set.
- Run on Drupal 9, 10, or 11 with no other module dependencies.
- Keep a status-report red/orange indicator visible until deployment tooling is corrected.
- Confirm environments (dev/stage/prod) each define a deployment identifier as part of a launch checklist.
- Add the check to a new-site setup checklist so the identifier is never forgotten.
- Use the warning as a nudge in code review / onboarding about container invalidation on deploy.
- Monitor the status report programmatically (drush) for the presence of the "Not set" warning.
- Remove the module cleanly once the identifier is reliably set by tooling (it leaves no config behind).
