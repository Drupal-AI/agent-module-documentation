IFrame Removing Filter provides a single text-format filter (`iframeremove_filter`) that strips `<iframe>` elements from rendered content unless their `src` hostname matches an admin-configured domain allowlist.

---

The module registers one filter plugin, `iframeremove_filter` (`TYPE_TRANSFORM_IRREVERSIBLE`), that you enable on a text format at *Configuration → Content authoring → Text formats and editors*. Its only setting is a newline-separated **whitelist** of domains (wildcards with `*` allowed). On render, `process()` short-circuits unless the text contains `<iframe`, then loads the HTML into a DOM (`Html::load`), reads each iframe's `src`, extracts the host with `parse_url`, and removes any iframe whose host is empty or does not match a whitelist entry (each entry is turned into an anchored regex via `preg_quote` with `*` → `.*?`). It is aimed at formats that allow Full HTML, where authors (or pasted content) could otherwise embed arbitrary third-party iframes; the filter lets you permit only trusted embed providers (YouTube, Vimeo, your own domains). Because it is `IRREVERSIBLE`, it transforms the stored markup on display and is not meant to round-trip. There is no global config page (`configure` null) and no permissions; configuration is per text format and stored in `filter.format.*` config (schema `filter_settings.iframeremove_filter`).

---

- Allow only whitelisted domains' iframes in a Full HTML text format, stripping all others on display.
- Permit YouTube/Vimeo embeds while removing iframes pointing at arbitrary sites.
- Harden a rich-text format that trusted-but-not-fully-trusted authors use, against unwanted iframe embeds.
- Remove iframes that have no `src` or a malformed `src` (no parseable host).
- Whitelist your own subdomains for internal embeds (dashboards, maps) while blocking external ones.
- Use wildcards to allow an entire domain and its subdomains (e.g. `*.example.com`).
- Clean up legacy content that contains outdated or unwanted iframe embeds when it is re-rendered.
- Provide a lightweight alternative to a full HTML sanitizer when the only concern is rogue iframes.
- Prevent clickjacking/unwanted third-party framing introduced through pasted WYSIWYG content.
- Enforce an embed policy centrally by editing one filter's domain list.
- Layer the filter after the WYSIWYG/limit-HTML filters in a format's processing order.
- Block iframes to ad or tracking domains in user-submitted or imported content.
- Allow a marketing team to embed from an approved list of providers only.
- Keep an "Allowed HTML" format that includes `<iframe>` but constrains which iframes actually render.
- Sanitize content migrated from another CMS that may contain untrusted iframes.
- Restrict map/embeds to a single provider domain across the whole site.
- Give editors freedom to paste embed code while the site controls which hosts survive rendering.
- Combine with core filters so only your allowlisted iframe hosts are ever shown to visitors.
- Audit and tighten embed sources by adjusting the whitelist without touching content.
- Disable arbitrary iframe embedding on comment or forum formats where full HTML is risky.
