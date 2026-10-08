<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
URL Replace Filter is a text-format `@Filter` plugin that rewrites the leading URL of `href` attributes on `<a>` and `src` attributes on `<img>` at render time, turning old/absolute base URLs in stored content into ones that resolve against the current site.

---

This is the archetypal migration-cleanup filter. A site moves, or a staging copy is taken, and every image and link in every body field still points at `https://old.example.org/...` — often the assets even still load, which is worse than breaking, because production quietly serves files from a host that is about to be switched off. Rewriting the stored HTML is the durable fix but frequently cannot happen at once: content is re-imported from the old system, or the same database is used in an environment where the old URL is still correct, or a bulk edit needs sign-off. A render-time filter covers all three — stored content is untouched, output is corrected, and rules are per text format so different formats can behave differently. The mechanism is deliberately narrow and worth understanding precisely: enable the `url_replace_filter` plugin on a format, then in its vertical settings tab enter rows of an **original** base-URL string and a **replacement**. On render, `process()` builds a case-insensitive, ungreedy regex per rule — `!((<a\s[^>]*href)|(<img\s[^>]*src))\s*=\s*"ORIGINAL!iU` — and rewrites only the matched attribute-and-leading-URL span, leaving the remainder of the URL and the rest of the tag intact. It is a **regex over the raw markup string**, not a DOM parse, and it touches **only** `<a href>` and `<img src>` — never `<script>`, `<link>`, CSS `url()`, inline styles, or link text. The replacement may contain `%baseurl`, expanded to `rtrim(base_path(), '/')` (usually empty on a root install). Rules run top-to-bottom, so the most specific original must come first (`http://example.com/somepath/` before `http://example.com/`), and both original and replacement should carry matching trailing slashes to avoid partial matches. Settings are stored per format as a PHP-serialized string in the filter's `replacements` setting (unserialized with `allowed_classes => FALSE`). Two things to check: **filter order** — place it so the target elements are still present and any HTML-restricting filter has already run; and whether the durable fix (core `base_url`, or an actual content rewrite / re-migration) is available instead, since a render-time workaround tends to outlive the situation that justified it. Configuration requires the core `administer filters` permission (trusted-roles-only). Version **8.x-1.2**, core `^10 || ^11`, depends on core `filter`, declares `php: 8.2`.

---

- Fix `<img>` src URLs after a domain move so assets load from the current host.
- Rewrite `<a>` links that still point at an old/retired site.
- Correct absolute URLs in a staging or QA copy of production content.
- Stop production quietly serving files from a host about to be decommissioned.
- Repair body-field images after a content migration from another CMS.
- Rewrite a `http://dev.example.com/` prefix to `%baseurl/` per text format.
- Collapse an old subdirectory install (`example.com/somepath/`) to site root.
- Fix links and images after a site rebrand or hostname change.
- Support a phased/parallel domain migration where both URLs are valid for a time.
- Rewrite legacy `http://` references toward the current base path to reduce mixed content.
- Swap an old CDN or image hostname baked into stored markup.
- Serve the same shared database under different hostnames per environment.
- Avoid a risky bulk `UPDATE`/re-save of every node's body field.
- Clean imported news or blog archives whose links are absolute.
- Consolidate content from several merged sites onto one domain.
- Correct rendered output without altering the stored source content.
- Apply different rewrite rules to a "full HTML" format vs a "restricted" one.
- Chain several ordered rules (specific-first) to remap multiple old hosts at once.
- Point authenticated-proxy content at the public base URL via `%baseurl`.
- Provide a temporary, reversible fix while a proper re-migration is scheduled.
