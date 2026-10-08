<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Siwecos connects a Drupal site to the SIWECOS security-scanning service. Using stored SIWECOS credentials it logs in, registers and verifies the site's own domain (via a `siwecostoken` meta tag / response header), triggers scans and renders the resulting security score and per-scanner findings on an admin report page. It also provides a "Siwecos seal" trust-badge block.

Use it to surface an external security posture score/report for your own site inside Drupal.

---

Register at siwecos.de, then configure at Administration > Configuration > System > Siwecos (`siwecos.settings_form`). Enter your SIWECOS email and password; on save the module logs in, obtains an API token, and registers/verifies the site's front-page domain (the domain field is locked to the current host, so scans only ever target your own site). Domain token and API token fields are read-only/populated by the service.

View the report at `/admin/reports/siwecos` (permission `access administration pages`), which renders the score circle and each scanner's results. Place the "Siwecos seal" block to show a verification badge. Note: the settings route requires an `administer siwecos configuration` permission that the module never defines, so in practice only user 1 can reach the form.

---

- Integrate the SIWECOS security scanner with Drupal.
- Log in to SIWECOS with stored credentials.
- Register the site's own domain for scanning.
- Verify domain ownership via a `siwecostoken` meta tag.
- Also emit the domain token as a response header.
- Trigger security scans against your own domain.
- Render an overall security score with color coding.
- Show per-scanner findings in collapsible details.
- Add the score to the status report requirements.
- Provide a trust-seal block linking to siwecos.de.
- Lock the scanned domain to the current site host.
- Store the API/domain tokens returned by the service.
- Show a registration prompt when unconfigured.
- Use Guzzle with default TLS verification for API calls.
- Warn users to register a free SIWECOS account.
- Support Drupal 8, 9 and 10.
