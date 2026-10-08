Pathologic is a text-format input filter that rewrites and corrects URLs and paths in content so links and images keep working even when the site's domain, base path, or protocol changes.

---

Pathologic provides a single filter plugin, `filter_pathologic` ("Correct URLs with Pathologic"), that you enable on a text format. As content is rendered, it inspects the `href`, `src`, `srcset`, `action`, and `longdesc` attributes of the markup and, for URLs it recognizes as local, rebuilds them through Drupal's URL generator into correct, current links. Because it stores links in a normalized form, content authored on one domain or base path keeps working after the site moves to another server, switches between HTTP and HTTPS, or changes clean-URL behaviour. It offers three output formats via the `protocol_style` setting: full absolute URLs (`http://example.com/foo/bar`), protocol-relative URLs (`//example.com/foo/bar`), or paths relative to the server root (`/foo/bar`). A `local_paths` textarea lets you list all the base paths/URLs the site has ever lived at (for example a staging host) so Pathologic recognizes and corrects links that were written against those. Settings can be global (edited at Admin → Configuration → Content authoring → Pathologic, config object `pathologic.settings`) or overridden per text format. When the core Language module is enabled, a "Keep language prefix" option controls whether language prefixes like `/fr` are retained. Because it rewrites finished markup, Pathologic should almost always be the last filter in a format's processing order, and it carries a plugin weight of 50 to encourage this. Developers can adjust or veto individual rewrites through `hook_pathologic_alter()`.

---

- Keep image `src` and link `href` values working after moving the site to a new domain.
- Correct links in content migrated from a staging or development server to production.
- Fix broken images and links in syndicated output (RSS feeds) by emitting full absolute URLs.
- Emit protocol-relative URLs so a site served over both HTTP and HTTPS never mixes schemes.
- Emit root-relative paths (`/foo/bar`) to avoid HTTP/HTTPS issues with no absolute-URL downsides.
- List a former base path (e.g. `http://dev.example.org/staging/`) so old links written against it are corrected.
- Recognize the site's several past base URLs at once via the `local_paths` setting.
- Normalize links that were authored as absolute URLs back into current, correct URLs.
- Correct links after toggling clean URLs or changing the site's base path.
- Apply different URL-correction rules per text format using per-format (local) settings.
- Share one global Pathologic configuration across every text format that opts into it.
- Rewrite `srcset` responsive-image candidate URLs, not just single `src` values.
- Correct `action` attributes on forms and `longdesc` attributes embedded in content.
- Strip or keep a language prefix (`/fr/node/3`) in rewritten URLs on multilingual sites.
- Link back to `<front>` when content references the site root path.
- Turn `files:`-scheme and internal-scheme legacy Path Filter links into real file URLs.
- Preserve query strings and fragments while still correcting the path portion of a URL.
- Prevent Pathologic from touching links to a specific subdirectory via `hook_pathologic_alter()`.
- Rewrite matched image paths to a CDN host from a custom alter hook.
- Add or modify query parameters on rewritten URLs programmatically.
- Ensure Pathologic runs last in the filter order so it operates on fully rendered markup.
- Migrate Drupal 7 `pathologic` filter settings to the D8+ `filter_pathologic` filter automatically.
- Restrict which URL schemes Pathologic will process via the `scheme_allow_list` config value.
- Leave external and non-local URLs untouched while only correcting local ones.
