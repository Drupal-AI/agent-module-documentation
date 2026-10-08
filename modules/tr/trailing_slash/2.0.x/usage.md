Trailing Slash appends a trailing slash (e.g. `/about/`) to the URLs you choose — matched by path patterns and/or by content-entity bundle — as Drupal generates them, primarily for SEO/URL-consistency purposes.

---

The module works entirely on **outbound** URL generation: a low-priority outbound path
processor (`TrailingSlashOutboundPathProcessor`, tag `path_processor_outbound` priority -1, so it
runs last) inspects each generated path and, when the feature is enabled and the path qualifies,
calls a helper that regex-appends a slash to the final segment (only when the last segment has no
dot, so file-like URLs are left alone). A path qualifies if it is not `<front>`, not empty, not an
admin/devel path, and either matches one of the configured path patterns (via `path.matcher`,
wildcards allowed) **or** resolves to a content entity whose bundle is enabled. A service provider
(`TrailingSlashServiceProvider`) additionally swaps the `url_generator.non_bubbling` service for
`TrailingSlashUrlGenerator` to fix the special case of the multilingual `<front>` URL losing its
slash after language prefixing. Configuration lives in `trailing_slash.settings` — a global
`enabled` toggle, a newline-separated `paths` list, and a serialized `enabled_entity_types` map of
per-bundle checkboxes — edited at `/admin/config/trailing-slash/settings` behind the module's own
`administer trailing slash` permission. It depends on the core **language** module (for the
front-page multilingual handling) and adds no Drush, plugins, or entity types.

---

- Add a trailing slash to a specific path such as `/about/` or `/contact/`.
- Add trailing slashes to a whole section using a wildcard pattern like `/blog/*`.
- Force trailing slashes on all URLs of a content type (e.g. every `article` node).
- Enable trailing slashes per content-entity bundle via checkboxes.
- Standardize URL format site-wide for SEO consistency and to avoid duplicate-URL signals.
- Keep the multilingual front-page URL's trailing slash after a language prefix (e.g. `/en/`).
- Leave admin and `/devel` paths untouched (excluded automatically).
- Leave file-like URLs (segments containing a dot) without a slash.
- Turn the whole feature on or off with a single `enabled` toggle.
- Combine path patterns and entity-bundle rules in one configuration.
- Migrate a site to trailing-slash URLs to match a prior CMS's URL scheme.
- Match an external redirect/canonical strategy that expects trailing slashes.
- Apply trailing slashes only to marketing/landing paths while leaving app paths alone.
- Restrict who can change trailing-slash rules with the `administer trailing slash` permission.
- Add trailing slashes to taxonomy term or user pages by enabling those bundles.
- Preserve existing URLs by not slashing paths that already end in a slash (idempotent regex).
- Roll trailing slashes out gradually by adding one path pattern at a time.
- Keep generated menu/link URLs consistent with your redirect rules.
