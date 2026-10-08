<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
External Link Update bulk-adds target and rel attributes to external links in node body fields via a form or Drush command.

---

External Link Update scans the body field of nodes for external `<a>` links and rewrites them to add a chosen `target` (`_blank`, `_self`, `_parent`, `_top`) and one or more `rel` attributes (`nofollow`, `noreferrer`, `noopener`), processed with the Batch API.

An admin form at `/admin/config/elink-update` (`access administration pages`) lets you pick content types, a link target and rel attributes, then queues a batch that loads each node, parses its body HTML and saves the updated markup. The same operation is available headless through the Drush command `elink-update:find-external-link`, which builds and runs the batch from the CLI.

Use it to retrofit `rel="noopener noreferrer"` and `target="_blank"` across a large content set for security/SEO hygiene without editing nodes by hand. It only rewrites link attributes in existing body markup; it does not change link destinations.

---
- Add `target="_blank"` to external links across chosen content types.
- Apply `rel="nofollow"` to outbound links in bulk.
- Add `noopener`/`noreferrer` to existing external links.
- Select which content types to process on the form.
- Run the update as a batch from the admin UI.
- Run the same update headless via Drush.
- Retrofit link-security attributes site-wide.
- Improve SEO by marking outbound links nofollow.
- Process only the node body field's external links.
- Combine multiple rel attributes in one pass.
- Re-run after content imports to normalize links.
- Log batch progress and completion via the elink_update channel.
- Preview which content types contain external links.
- Standardize link-opening behavior across a site.
- Script link normalization in a deployment pipeline.
- Exclude internal links from rewriting automatically.
- Update thousands of nodes without manual edits.
- Enforce an outbound-link policy after a migration.