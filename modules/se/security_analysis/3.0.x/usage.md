<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Security Analysis rates the site's security config against a bundled ideal and exports a report.

---

Security Analysis reads configuration from other security modules (SecKit, Login Security, Password Policy, CAPTCHA/reCAPTCHA, Security Review) and compares each value against a bundled 'ideal' config set, producing a rating (letter grade + percentage) and charts on `/admin/security_analysis`. It can export the findings as an `.xlsx` workbook via PhpSpreadsheet. Two permissions gate it: `access security analysis admin overview` and `download security analysis report`. Depends on the phpspreadsheet module; the report library also pulls Chart.js from a public CDN. It is read-only reporting — it does not change any security settings for you.

---

- Audit the site's security posture at a glance.
- Compare SecKit settings against a recommended baseline.
- Check Login Security thresholds against an ideal.
- Review Password Policy configuration.
- Review CAPTCHA / persistence settings.
- Surface Security Review check results.
- List which security modules are installed.
- Show an overall letter/percentage security rating.
- Render rating charts and gauges on the admin page.
- Export the full report as an Excel workbook.
- Gate the overview behind a dedicated permission.
- Gate the download behind a separate permission.
- Give site builders a hardening checklist.
- Track improvements after applying security modules.
- Provide a printable/shareable security summary.
- Run on Drupal 8 through 11.
