<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
HTML Tag Usage scans the contents of formatted-text fields across the site and produces a report of which HTML tags and attributes are actually in use, broken down by text format, with drill-down to the entities that use each one.

---

When you inherit a site whose text formats do not restrict HTML (or allow more than they should), you cannot safely tighten the "Limit allowed HTML tags" filter without knowing what markup real content depends on. This module answers that: an admin selects which field types to scan, runs a Batch analysis that parses every field value with `Html::load()`, and stores per-format tag/attribute counts in a dedicated `html_tag_usage` table. The report groups results by text format and, for any tag/attribute, an AJAX dialog lists the exact entities (linked to their edit forms, with paragraphs resolved to their host) that use it. It also generates a candidate allowed-HTML filter string per format covering everything currently in use — explicitly flagged as a starting point that may be insecure and must be reviewed.

All endpoints are permission-gated: viewing needs `view html tag usage report`, generating needs `generate html tag usage report` (and the generate/inspect routes are CSRF-protected), and changing the scanned field types needs `administer html tag usage`. Queries are built with Drupal's database API (parameterized conditions, no string concatenation). The module warns that on large sites the results table can grow big, so it is best used on dev/staging and uninstalled once the audit is done.

Setup: install, choose field types at `/admin/config/development/html_tag_usage`, then open *Reports > HTML Tag Usage* and click Generate report.

---

- Inventory every HTML tag used across a text format before restricting it
- Find every attribute (e.g. `style`, `onclick`) currently present in content
- List the exact entities that use a specific tag/attribute combination
- Decide whether to remove `iframe` embeds and see how many use them (GDPR cleanup)
- Audit a migrated site whose formats return HTML unfiltered
- Generate a starting allowed-HTML filter config from real usage
- Scope the analysis to specific field types via configuration
- Regenerate the report after content changes
- Drill into paragraphs and follow the link to the host entity's edit form
- Identify tags used with no attributes (shown as `*`)
- Quantify how often a tag appears to prioritise remediation
- Grant read-only report access to auditors without generate rights
- Restrict who can trigger the (expensive) analysis batch
- Compare tag usage across multiple text formats side by side
- Export findings by reading the report tables for a content cleanup plan
- Uninstall after the audit to drop the potentially large results table
