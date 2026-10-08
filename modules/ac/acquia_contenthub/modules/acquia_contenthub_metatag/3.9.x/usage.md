Metatag handling for Acquia Content Hub: when a content entity with a Metatag field is
syndicated, this submodule rewrites the `canonical_url` so the exported CDF carries the
publisher's real absolute node URL instead of the unresolved `[node:url]` token.

---

Content Hub serializes entities to CDF for syndication across sites. A Metatag field storing
`canonical_url` as `[node:url]` would otherwise syndicate the raw token, which each subscriber
would resolve to its own local URL — losing the canonical pointer back to the publishing site.
This submodule adds an event subscriber (`EntityMetatagsSerializer`, on the base module's
`SERIALIZE_CONTENT_ENTITY_FIELD` event at priority 110) that, for `metatag`-type fields, replaces
`[node:url]` in `canonical_url` with the publisher's absolute URL before the value is written to
CDF. The behavior can be disabled per site with the single config flag
`acquia_contenthub_metatag.settings:ach_metatag_node_url_do_not_transform`. It requires the
`acquia_contenthub` and `metatag` modules and defines no routes, permissions, or Drush commands.

---

- Keep the SEO canonical URL pointing at the publisher when syndicating content.
- Rewrite `[node:url]` in the metatag `canonical_url` to an absolute publisher URL on export.
- Preserve canonical metadata across a network of subscriber sites.
- Avoid subscribers resolving the canonical token to their own local URLs.
- Opt a site out of the rewrite with a single config flag.
- Set the opt-out via `drush cset` or `settings.php` without a UI.
- Syndicate SEO metadata consistently alongside content.
- Support editorial teams that rely on canonical URLs for duplicate-content control.
- Explain the transform to editors via updated help text on metatag forms/widgets.
- Integrate Metatag values into the Content Hub CDF payload correctly.
- Maintain canonical-URL integrity in multi-site publishing.
- Ensure syndicated articles credit the originating site's canonical URL.
- Combine with the base module's publisher export pipeline.
- Handle metatag fields on nodes and other content entities during export.
- Keep canonical URLs stable when content is re-syndicated.
