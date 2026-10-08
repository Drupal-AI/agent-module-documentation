Connects a Drupal site to the external Silktide website-quality/SEO/accessibility testing service: whenever a node is published or updated, the module notifies Silktide's API so the changed page is re-scanned, and it injects an encrypted meta tag that lets the Silktide toolbar deep-link editors to the Drupal edit form.

---

Silktide is a thin integration with the hosted Silktide platform (silktide.com). You enter a Silktide **API key** on the settings form at `/admin/config/services/silktide` (route `silktide.form`, gated by the `silktide configuration` permission). Two node hooks — `silktide_entity_insert` and `silktide_entity_update` — fire a `SilktideEvent` carrying the node's absolute canonical URL, but only for **published** `node` entities. `SilktideService` subscribes to that event and makes an **outbound POST to `https://api.silktide.com/cms/update`** (via the Guzzle `http_client`) with the API key and URL form-encoded, so Silktide re-crawls the page within seconds; failures are caught and logged to the `silktide` channel (without a valid key the call returns 403 and just produces log noise). Separately, `silktide_page_attachments` adds a `<meta name="silktide-cms">` tag on node routes whose content is the node's edit-form URL, **AES-256-CBC encrypted with the API key** (IV + HMAC-SHA256 + ciphertext, base64-encoded) so the Silktide browser toolbar can authenticate the CMS and jump to the editor. The module stores only `apikey` (and a `lastnotified_time`) in `silktide.settings`; it defines no plugins, entities, or Drush commands. Note the deliberate external dependency: the site phones home to Silktide's API on every publish/update — expected behavior, not a fault.

---

- Automatically tell Silktide to re-scan a page as soon as an editor publishes or updates it.
- Keep Silktide's SEO/accessibility/quality reports in near-real-time sync with site content.
- Register a Drupal site with a Silktide account by pasting the account's API key.
- Let the Silktide browser toolbar deep-link from a scanned page straight to that node's Drupal edit form.
- Monitor accessibility (WCAG) compliance of published pages via the connected Silktide dashboard.
- Track broken links, spelling, and content-quality issues surfaced by Silktide after each edit.
- Trigger a fresh Silktide crawl of just the changed URL instead of a full site re-scan.
- Provide content teams a one-click path from Silktide findings back into the CMS.
- Audit new nodes for SEO problems the moment they go live.
- Feed publish/update events to Silktide for change-driven quality gating.
- Restrict who can configure the integration with the dedicated `silktide configuration` permission.
- Log notification successes/failures to the `silktide` log channel for troubleshooting.
- Suppress notifications for unpublished/draft nodes (only published nodes are sent).
- Encrypt the editor deep-link so only the paired Silktide account can decode it.
- Integrate Drupal into an agency's multi-site Silktide monitoring setup.
- Use Silktide's marketing/analytics-style reporting alongside content workflows.
- Route Silktide's page-quality checks through the site's normal Guzzle HTTP client.
- Disable the phone-home simply by uninstalling the module or clearing the API key.
