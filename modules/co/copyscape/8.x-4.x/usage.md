Copyscape checks the originality of node content against the Copyscape Premium plagiarism API whenever a node is created or edited, and can warn, block saving, or eventually block the editor when matches exceed a configured threshold.

---

Copyscape integrates a Drupal site with the paid Copyscape Premium web-service API to detect plagiarised text. An administrator enters the Copyscape account username, key and API URL, then selects which long-text fields (`text_long`, `string_long`, `text_with_summary`) on which node bundles should be checked. When a non-bypassing user saves a node create/edit form, a form validation handler strips tags from each selected field, sends the text to Copyscape, and inspects the returned percent-match. If a match exceeds the configured "reject" percentage, the module either raises a validation error that prevents saving or shows a non-blocking warning (configurable), records the failure count for that user in a `copyscape_fail` entity, and — once a per-user maximum fail count is reached — blocks and logs out the offending account. Successful responses can optionally be logged as `copyscape_result` entities and reviewed at an admin results page. Bypassing is available per user ID and (partially) per role; user 1 always bypasses. The module supports checking Paragraph subfields via a compact field-path syntax. It provides two content entity types, two admin config forms, a results controller, an entity access handler, permissions and config schema; it depends only on Drupal core (node, user) and requires a purchased Copyscape subscription to function.

---

- Automatically screen every new or edited article for plagiarism before it is published on a busy editorial site.
- Prevent editors from saving a node whose body text matches existing web pages above a chosen percentage.
- Run plagiarism checks as non-blocking warnings while editors learn, without preventing content from being saved.
- Restrict checking to specific content types (e.g. only `article` and `blog`) and leave others unchecked.
- Check only chosen long-text fields on a bundle (body, summary, custom rich-text fields) rather than all text.
- Include Paragraph subfields in the plagiarism check using the `parent_field:paragraph_field:i` path syntax.
- Check each repeated Paragraph field value individually (`:i`) for accuracy, or combine them to reduce API cost.
- Exclude your own domains and known partner sites from match results via the "ignore sites" list.
- Set a copy-percentage threshold below which matches are ignored and above which content is rejected.
- Automatically block and log out an editor who repeatedly submits plagiarised content beyond a fail cap.
- Exempt trusted editors from checking by listing their user IDs in the bypass list.
- Exempt whole roles (e.g. administrators) from plagiarism checking.
- Guarantee that user 1 (superuser) is never subjected to the Copyscape check.
- Keep an auditable log of Copyscape responses per node as `copyscape_result` entities for later review.
- Review all recorded plagiarism results, matched URLs and percentages in a paged admin table at `/copyscape/results`.
- Delete individual stored Copyscape result records from the admin results table.
- Add a per-field "Check this field with Copyscape" toggle directly on the node field-configuration form.
- Control Copyscape spend by combining Paragraph fields into a single request when accuracy can be traded for cost.
- Configure the Copyscape API endpoint URL to match your account's API access settings.
- Surface the matched source URL and view URL to the editor in the validation message so they can see the copied source.
- Enforce originality policy across a large multi-editor content team from a single central configuration.
- Disable logging to avoid storing responses when only inline enforcement (not an audit trail) is needed.
