Adds a configurable `target` attribute to hyperlinks in text-format output, scoped to all, internal, or external links.

---

Target Attributes Filter is a small text-format (input filter) module. Once its "Add target attribute to links" filter is enabled on a text format, every anchor in content processed by that format is walked with Drupal's HTML DOM parser and given a `target` attribute. An administrator picks the target value (`_blank`, `_self`, `_parent`, `_top`), decides whether it applies to all links or only internal links or only external links (a link is "internal" when its host matches the site's request host, with a leading `www.` ignored on both sides), and chooses whether an existing `target` on a link should be replaced or left alone. The behavior is defined entirely by the text format's saved filter settings, not by the content author or per-link markup, so the same rule applies uniformly wherever that format renders. The module has no routes, permissions, services, blocks, or Drush commands of its own; it depends only on core's `filter` module and configures itself through the standard Filter settings UI on each text format.

---

- Force every link in a body field to open in a new browser tab by setting the target to `_blank` for all links.
- Keep links opening in the same tab by choosing `_self` (the module's default target value) while still normalizing the attribute.
- Open only external links in a new tab, leaving internal navigation in the same tab, by selecting `_blank` with the "Only external links" scope.
- Open only internal links in a specific frame or window by selecting a target with the "Only internal links" scope.
- Break content out of a framed/embedded context by targeting `_top` on the links.
- Target the parent frame with `_parent` when content is rendered inside a nested iframe.
- Apply a new-tab policy to marketing or CTA text without editing each anchor by hand in the editor.
- Enforce a consistent link-target policy across all content that uses a given text format (e.g. Full HTML, Basic HTML).
- Give a "Newsletter" or "Email" text format its own link-target rule separate from the site's on-page formats.
- Preserve target attributes that authors set deliberately by unchecking "Replace target attribute" so existing `target` values are kept.
- Overwrite inconsistent author-set targets by checking "Replace target attribute" so the format's rule always wins.
- Treat `https://www.example.com` and `https://example.com` as the same (internal) host, since a leading `www.` is stripped before the host comparison.
- Skip links with an empty or whitespace-only `href` (they are left untouched) while still processing real links.
- Combine with core's Limit allowed HTML tags filter, ordering this filter after it, to add targets to the sanitized markup.
- Apply the rule to WYSIWYG (CKEditor) body content, comment bodies, or any field rendered through a text format.
- Standardize link behavior for accessibility or brand guidelines across an entire content type via its display format.
- Migrate legacy content that lacks target attributes by enabling the filter on the format used to render it.
- Provide different link-target behavior to different roles by assigning them different text formats.
- Roll the policy out safely: because it is a display-time transform, disabling the filter immediately reverts to the stored markup with no data migration.
