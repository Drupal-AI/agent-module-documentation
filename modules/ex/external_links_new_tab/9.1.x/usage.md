<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
External Links In New Tab automatically makes every external link render with `target="_blank"` and `rel="noopener"` so links to other sites open in a new browser tab, with no configuration required.

---

The module implements a single hook, `hook_link_alter()`, in `src/Hook/ExternalLinksNewTabHooks.php`. For every link Drupal builds through the link generator / `Link` API, it checks `$variables['url']->isExternal()`; when true it sets `options.attributes.target` to `_blank` and `options.attributes.rel` to `noopener`. This covers links routed through Drupal's theme/link layer — menu links, `#type => 'link'` render elements, field-rendered link items, and `Link::toString()` output — because they all pass through `hook_link_alter()`. It does **not** rewrite raw `<a>` tags hard-coded in body text, block markup, or Twig templates, since those never reach the hook. There is no settings form (`configure` is null), no permissions, no config, and no external library; the whole module is the one alter hook plus a help page. The `noopener` relation is a security/privacy hardening: it stops the newly opened page from gaining a reference to `window.opener`, preventing reverse-tabnabbing.

---

- Open every external link on the site in a new browser tab without editing content.
- Add `rel="noopener"` to external links to prevent reverse-tabnabbing / `window.opener` hijacking.
- Ensure external menu links open in a new tab.
- Make external links inside a menu block open away from the current site.
- Force `#type => 'link'` render-array links to external URLs to open in a new tab.
- Have field-formatted link fields pointing off-site open in a new tab.
- Keep users on your site when they click an external reference.
- Apply consistent external-link behavior site-wide instead of per-link `target` attributes.
- Retrofit new-tab behavior onto an existing site with many external links.
- Improve privacy of outbound links by suppressing the referrer window handle.
- Standardize external-link handling across multiple themes on one site.
- Avoid manually adding `target="_blank"` in the WYSIWYG for linked references.
- Guarantee external links added via the Link API (e.g. by other modules) open in a new tab.
- Provide safer external-link defaults for editors who lack HTML knowledge.
- Combine with content that aggregates third-party URLs so they all open externally.
- Use on documentation or link-directory sites where every outbound link should open separately.
