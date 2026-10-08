Audit analyzer that scores pending module/theme updates, prioritizing security releases, using core Update Status data.

---

audit_updates registers the `updates` AuditAnalyzer plugin (UpdatesAnalyzer, weight 5) and depends on core's Update Status (update) module. It reads the update-status data to score the health of the update system itself (data availability/freshness), pending security updates (heavily weighted), and pending regular updates; an informational section reports next-major-version compatibility. Regular (non-security) updates can be de-emphasized with the `ignore_regular_updates` setting so the score reflects only security exposure.

---

- Detect pending security releases for contrib modules and themes.
- Score overall update posture, weighting security updates heaviest.
- Track every module/theme version and flag those with available updates.
- De-prioritize routine updates via `ignore_regular_updates` to focus on security.
- Confirm Update Status data is fresh (update system health).
- Report next-major-version compatibility of installed projects (informational).
- Provide a portfolio security-update overview via DruScan.
- Include update exposure in a pre-deploy or takeover audit.
- Run headless via `drush audit:run updates --filter="severity:error"`.
- Feed a weighted Updates score into the overall Project Score.
- Surface which projects need patching first for a maintenance window.
- Catch an unmaintained module with no stable release path.
- Give clients a scored, dated snapshot of their update backlog.
- Alert when a critical security advisory affects an installed module.
- Verify the update module is enabled (requirement warning otherwise).
