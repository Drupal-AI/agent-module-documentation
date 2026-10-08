Audit analyzer that scores common Drupal security misconfigurations across permissions, config and static code checks.

---

audit_security registers the `security` AuditAnalyzer plugin (SecurityAnalyzer, weight 1 — highest priority). It runs eleven scored checks: a static code-security scan (regex rules in `rules/static_security_rules.yml` applied to PHP/YAML in the scan directories), risky administrative permissions granted to untrusted roles (an admin can whitelist roles via the `trusted_roles` setting), production error-reporting level, dangerous text-format/filter configuration, file-system permissions and the SA-2006-006 `.htaccess`, `trusted_host_patterns`, admin (uid 1) account exposure, Views access control, allowed upload extensions, open account creation, and a lightweight self-request that inspects the returned HTTP security headers. Findings render as scored, faceted issue lists on the Security detail page.

---

- Run a broad security-configuration audit before launching or taking over a site.
- Detect risky permissions (e.g. PHP/admin capabilities) granted to anonymous/authenticated or other untrusted roles.
- Whitelist legitimately-privileged roles via `trusted_roles` to reduce noise.
- Confirm production error reporting is set to hide messages (no verbose errors to visitors).
- Flag text formats/filters that allow dangerous HTML or unsafe tags to untrusted users.
- Check file-system permissions and the presence of the files-directory `.htaccess` protection.
- Verify `trusted_host_patterns` is configured to block host-header attacks.
- Detect an exposed or weak uid 1 admin account.
- Review Views displays that may leak data through missing access control.
- Audit allowed file-upload extensions for dangerous types.
- Detect open (visitor) account creation that should require approval.
- Inspect recommended HTTP security headers via a self-request (skips gracefully if unreachable).
- Run a static code-security regex scan over custom PHP/YAML for insecure patterns.
- Produce the highest-weighted Security score feeding the overall Project Score.
- Run headless via `drush audit:run security --filter="severity:error"` in CI.
- Monitor security posture across many sites via DruScan.
