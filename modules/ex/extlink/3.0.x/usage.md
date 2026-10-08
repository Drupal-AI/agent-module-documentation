External Links (extlink) is a JavaScript module that finds every link pointing off-site (and every `mailto:`/`tel:` link) on a page and decorates it — adding an icon, a "new window" target, `nofollow`/`noreferrer` attributes, or an optional click warning.

---

Out of the box the module attaches a small client-side script to every non-admin page that scans rendered links, compares each href against the current host (subdomains are treated as internal by default), and marks the external ones. For each external link it can append an icon (a bundled image, a Font Awesome class set, or a UI Icons icon), set `target="_blank"` with an accessible "(opens in a new window)" label, add `rel="nofollow"` and/or `rel="noreferrer"`, add custom CSS classes, and pop up a confirmation alert before the user leaves the site. Mailto and tel links get their own icons, labels, and classes. Everything is controlled from a single settings form at Admin → Configuration → User interface → External Links (`/admin/config/user-interface/extlink`) and stored in the `extlink.settings` config object, so the whole configuration is exportable. Which links are processed can be narrowed with regex include/exclude patterns and CSS-selector include/exclude/explicit lists. Settings are normally injected as `drupalSettings`, but the module can instead serve them from a cacheable external `/extlink/settings.js` file for better page caching. Because it is pure JavaScript, decorations only appear for visitors with JS enabled. Modules can alter the settings via two hooks, and themes can override the generated markup by replacing `Drupal.theme.extlink_*` functions.

---

- Add a visual "external link" icon after every off-site link so readers know they are leaving.
- Add a mail icon to every `mailto:` link and a phone icon to every `tel:` link.
- Force external links to open in a new tab with `target="_blank"`.
- Append an accessible "(opens in a new window)" note for screen-reader users.
- Add `rel="nofollow"` to external links to control how search engines treat outbound links.
- Add `rel="noreferrer"` to external links to stop leaking the referring URL.
- Exclude specific links from getting `noreferrer` via a regex pattern.
- Show a confirmation pop-up warning before a visitor follows an external link.
- Treat images wrapped in an anchor tag as external links and decorate them.
- Consider (or stop considering) subdomains of your site as internal links.
- Disable all external-link processing on admin routes to keep the back end clean.
- Restrict processing to links matching an include regex (e.g. only a partner domain).
- Skip links matching an exclude regex (e.g. your own tracking domain).
- Limit or exclude processing by CSS selector (e.g. ignore `.no-extlink a`).
- Add custom CSS classes to every external, mailto, or tel link for theming hooks.
- Use Font Awesome icon classes instead of the bundled PNG icons.
- Use icons from a UI Icons icon pack for external, mailto, and tel links.
- Place the icon before (prepend) or after (append) the link text.
- Hide the decorative icons from screen readers to reduce noise.
- Prevent the icon from orphaning onto its own line by keeping it with the last word.
- Set a whitelist of "allowed domains" that should be treated as internal.
- Serve settings from an external cacheable JS file to improve page cache hit rates.
- Keep existing `target` / `title` / `rel` attributes by enabling the "do not override" options.
- Localize the icon alt text, new-window label, and alert message via config translation.
- Export the entire external-links configuration between environments as `extlink.settings`.
- Override the generated link/icon markup per theme using `Drupal.theme.extlink_*` JS functions.
- Migrate legacy External Links settings from a Drupal 6 or 7 site.
