Requirements Manager provides an admin UI to selectively hide, or override the severity of, individual entries on Drupal's Status Report (`/admin/reports/status`).

---

The module implements `hook_runtime_requirements_alter()` (as an object hook, ordered last) to post-process
the requirements array that builds the status report. Its settings form
(`/admin/config/system/requirements-manager`) discovers every current requirement via
`SystemManager::listRequirements()` and lists them in a table; for each requirement key an admin chooses an
action — **Show** (default, nothing stored), **Hide** (removed from the report), or **Change severity**
(remap to Info/OK/Warning/Error) — plus an optional free-text **reason**. Only non-default choices are
persisted, into the `requirements_manager.settings` config object under a `requirements` sequence keyed by
requirement id. At runtime the alter hook applies those overrides: hidden keys are unset, and severity-
changed keys get their `severity` swapped and an italic "Severity altered … by Requirements Manager"
notice (with the reason) appended to their description. Previously-hidden keys are still shown on the form
(labelled "hidden by this module") so they can be un-hidden. There is no dedicated permission — the config
form uses core's `administer site configuration`. Requires PHP 8.3 and Drupal 11.2+.

---

- Hide a noisy or irrelevant status-report warning from `/admin/reports/status`.
- Downgrade a Warning you've accepted to Info so it stops drawing attention.
- Downgrade an Error to Warning/OK where your environment legitimately differs from core's expectation.
- Escalate an OK/Info requirement to Warning/Error to force your team to notice it.
- Record a reason for each alteration so the next admin knows why it was changed.
- Suppress the "update available" or module-specific requirement rows on a locked-down site.
- Keep the status report green on purpose-built environments without patching modules.
- Un-hide a requirement you previously hid (it remains listed on the settings form).
- Manage requirement overrides declaratively via the `requirements_manager.settings` config for deployment.
- Show a per-row audit note on the report describing the original vs new severity.
- Clean up the status report before a screenshot or stakeholder demo.
- Silence a false-positive requirement contributed by a module you can't easily change.
- Apply overrides only to specific requirement keys, leaving the rest untouched.
- Roll overrides across environments by exporting/importing the settings config.
- Reduce alert fatigue on monitored status reports by curating severities.
