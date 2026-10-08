Rel Attributes Filter adds `rel` attributes (`nofollow`, `noopener`, `noreferrer`) to anchor tags through three text-format filter plugins you enable per text format. No configuration form and no code — you toggle the filters on a format at `admin/config/content/formats`.

---

The module ships three core `@Filter` plugins — `filter_nofollow`, `filter_noopener` and `filter_noreferrer` — each of type `TYPE_TRANSFORM_IRREVERSIBLE`. When a filter is enabled on a text format, it parses the rendered HTML with Drupal core's `Html::load()` (a DOMDocument-based parser), walks every `<a>` element, and sets the corresponding `rel` token. Only anchors that carry `target="_blank"` are modified — despite the plugin titles reading "add to all links", plain and `target="_self"` links are left untouched. If an anchor already has a `rel` value the new token is prepended (e.g. an existing `rel="nofollow"` becomes `rel="noopener nofollow"`); otherwise `rel` is created. The `rel` tokens are hardcoded constants, never drawn from config or user input, and the DOMDocument round-trip (`Html::serialize()`) escapes attribute values, so the transform cannot inject markup. Configuration is entirely through the text-format UI: enable one or more of the three filters on the formats you want. There is no settings form, no permissions, no config schema, and no Drush command. The module is core-only (no dependencies) and works on Drupal 8 through 11.

---

- Add `rel="noopener"` to `target="_blank"` links to prevent reverse-tabnabbing on formats used by untrusted authors.
- Add `rel="noreferrer"` to new-tab links so the destination cannot read the referring URL.
- Add `rel="nofollow"` to outbound new-tab links so search engines do not pass authority to them.
- Harden a comment or user-generated-content text format where authors can insert links.
- Apply link-hardening to existing, migrated, or API-submitted content at render time (a filter runs on all content, not only what is typed after install).
- Enable `noopener` on a "Full HTML" format to backfill the attribute on legacy content authored before browsers implied it.
- Stack multiple tokens on one format (enable `nofollow` + `noopener` together) to produce `rel="nofollow noopener"`.
- Enforce SEO `nofollow` policy on links added by editors in CKEditor without training every author.
- Reduce link-spam value in moderated content by stripping followed-link authority from new-tab links.
- Retrofit referrer-privacy on outbound links without a custom preprocess hook or CKEditor plugin.
- Keep `rel` hardening consistent across every rendering of a field, including views, feeds, and JSON output that reuses the format.
- Add new-tab safety attributes to marketing/body content edited by non-technical staff.
- Combine with `filter_html` on the same format (filter order permitting) to first restrict tags, then add `rel`.
- Provide a lightweight, dependency-free alternative to writing a custom `hook_link_alter` or DOM-processing filter.
- Ensure affiliate or sponsored outbound links opened in a new tab carry `nofollow`.
- Meet a security-review checklist item requiring `noopener`/`noreferrer` on all `target="_blank"` anchors.
- Apply the same policy to multiple text formats by enabling the filter on each one.
- Protect against `window.opener` abuse on older browsers that do not imply `noopener`.
- Document/enforce a site-wide link policy purely through configuration that ships in config export.
- Serve as a base to fork if you need the token applied to links regardless of `target` (the current code gates on `target="_blank"`).
