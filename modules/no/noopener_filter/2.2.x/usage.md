Noopener Filter adds a text-format filter (and an optional link-alter hook) that appends `rel="noopener"` to links that open in a new tab (`target="_blank"`), mitigating reverse-tabnabbing where a linked page can reach back through `window.opener`.

---

The module ships two independent mechanisms. First, a **filter plugin** (`filter_noopener`, "Add noopener to all links") of type `TYPE_HTML_RESTRICTOR` that you enable per text format on *Configuration → Content authoring → Text formats and editors*. When that filter runs over WYSIWYG/CKEditor body markup it parses the HTML, finds every `<a>` whose `target` is exactly `_blank`, and adds `noopener` to the `rel` attribute (prepending it to any existing `rel` value). Second, a global **`hook_link_alter()`** implementation gated by a single config flag `noopener_filter.settings:filter_links`; when that flag is on, Drupal-generated links (built through the link generator / `#type => 'link'`) that carry `target=_blank` also get `noopener` added to their `rel` array. The flag is toggled by a tiny settings form at `/admin/config/noopener-filter/settings` (route `noopener_filter.settings`), guarded by the `administer noopener filter` permission. The module has no field type, no plugin type, no config schema, and no Drush; its only stored state is the one boolean config value. Note it adds only `noopener` (not `noreferrer`), and only touches links whose target is `_blank`.

---

- Add `rel="noopener"` to editor-entered links that open in a new tab, so a target page cannot hijack the opener window.
- Harden a site against reverse tabnabbing without editing every link by hand.
- Apply noopener automatically to CKEditor body content on articles, pages, and blog posts.
- Enable the filter on the "Full HTML" format so trusted editors' `target="_blank"` links stay safe.
- Enable it on "Basic HTML" so limited editors also get noopener on new-tab links.
- Batch-secure legacy content: existing `target="_blank"` links get noopener on next render once the filter is on.
- Add noopener to Drupal-generated menu/link-generator links by turning on the `filter_links` setting.
- Meet a security-audit requirement that all `target="_blank"` links carry `rel="noopener"`.
- Preserve any existing `rel` value (e.g. `nofollow`) while prepending `noopener`.
- Standardise link security policy centrally instead of relying on editors to add `rel` manually.
- Combine with an outbound-link or nofollow filter to build a complete link-hardening pipeline.
- Restrict who can change the behavior via the `administer noopener filter` permission.
- Toggle the global link-alter behavior per environment through exported `noopener_filter.settings` config.
- Ensure marketing links to third-party sites cannot script the originating tab.
- Protect authenticated/admin sessions from tabnabbing attacks originating in linked pages.
- Keep noopener out of same-tab links (the filter ignores links without `target="_blank"`).
- Apply the fix to comment body text formats as well as node body formats.
- Add the filter to a webform or custom entity's rich-text format so its links are covered too.
- Document a repeatable, config-exportable link-security baseline across a multi-site install.
- Avoid writing custom preprocess/JS to add noopener, using a maintained filter instead.
- Order the filter in the text-format processing pipeline alongside other HTML restrictors.
- Provide defense-in-depth on top of modern browsers that already imply noopener for `_blank`.
