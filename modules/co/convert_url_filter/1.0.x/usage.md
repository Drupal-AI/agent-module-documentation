Convert URL Filter is a text-format filter that rewrites absolute links pointing at your own (or configured) hosts into relative URLs when content is rendered.

---

Convert URL Filter ships one filter plugin (`convert_url_filter`, "Convert internal absolute URLs to relative") that you enable on a text format. At render time it parses the HTML, walks every `<a href>` element, and — when the link's host matches the current site host or one of the extra domains you configure — strips the `scheme://user@www.host:port` prefix so the href becomes a root-relative path (e.g. `https://example.com/page` → `/page`). The current request host is always treated as internal; additional bare domains (one per line, no `http(s)` and no `www.`) are set in the filter's settings on each text format. It is a display-only, irreversible transform: the stored source text is untouched, and it only rewrites hrefs on existing anchors — it does not create links from plain text. It depends only on core Filter and provides no routes, permissions, services, or Drush commands.

---

- Convert absolute internal links in body content to root-relative URLs on output.
- Enable the filter on a WYSIWYG/full-HTML text format used for node bodies.
- Automatically relativize links pointing at the current site host with no configuration.
- Add extra internal domains (e.g. a legacy or staging domain) so their absolute links are relativized too.
- Keep links portable across environments (dev/stage/prod) without editing content.
- Support domain migrations where old absolute URLs should resolve on the new domain.
- Avoid hard-coded domains baked into editor content.
- Strip `www.` prefixes from matching internal links so `https://www.site.com/x` becomes `/x`.
- Handle links written with or without a scheme, with userinfo, or with an explicit port.
- Leave external links (non-matching hosts) untouched.
- Apply the transform per text format so different formats can opt in or out.
- Preserve stored content unchanged while only altering rendered output.
- Combine with other filters (e.g. limit HTML, URL filter) in a format's filter pipeline.
- Configure one domain per line in the filter's "Hosts" textarea.
- Normalize content copied between multisite instances that share domains.
- Reduce mixed absolute/relative link inconsistencies in migrated content.
- Ensure internal links keep working after a domain rename.
- Serve the same content over multiple hostnames while emitting relative internal links.
- Clean up absolute internal URLs pasted by editors from the browser address bar.
