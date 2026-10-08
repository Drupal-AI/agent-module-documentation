<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Link Purpose Icons adds visual icons and screen-reader hints to links whose behavior differs from a normal in-page link — external links, links that open a new window, downloads, documents, app links, email (`mailto:`) and phone (`tel:`) links — so users know what will happen before they click.

---

The module is a configuration-driven wrapper around the standalone "Link Purpose" JavaScript library (bundled under `library/`). It has one config object, `linkpurpose.settings`, and one settings form at `/admin/config/user-interface/linkpurpose` (route `linkpurpose.settings`, permission `administer linkpurpose`). On every non-admin route, `linkpurpose_page_attachments()` cache-tags `config:linkpurpose.settings`, builds a `drupalSettings.linkpurpose` payload from the (non-empty) config values, computes the internal `domain` (site base URL plus any configured domains) so off-site links are detected, and attaches the appropriate library variant (`linkpurpose/init` or `linkpurpose/library`, with `-noagg` variants when JS aggregation is disabled). The client library then scans links within the configured root regions and, for each of seven "purposes" (`purposeExternal`, `purposeDownload`, `purposeDocument`, `purposeApp`, `purposeMail`, `purposeTel`, `purposeNewWindow`), adds an icon and/or a visually-hidden screen-reader message (e.g. "Link is external"). Each purpose can be toggled on/off and customized with its own selector, screen-reader message, CSS classes, icon type/position and wrapper classes. Global options control which page regions to scan (`roots`), shadow-DOM components, selectors to ignore, conditional run rules (`noRunIfPresent`/`noRunIfAbsent`), and behaviors like opening external links in a new window (`purposeExternalNewWindow`) or adding `rel="noreferrer"` (`purposeExternalNoReferrer`). It never runs on admin routes.

---

- Add an "opens in a new window" icon and screen-reader hint to links with `target="_blank"`.
- Flag off-site links with an external-link icon so users know they're leaving the site.
- Mark document links (PDF, DOCX, etc.) with a document icon and "Link downloads document" hint.
- Add a download icon to file-download links for clearer affordance.
- Announce `mailto:` links to screen readers as "Link sends email".
- Announce `tel:` links as "Link opens phone app".
- Improve WCAG conformance by making link purpose programmatically determinable.
- Customize the screen-reader message text for any link category (e.g. localized wording).
- Restrict link marking to the main content region using the `roots` selector.
- Exclude a menu or widget from marking with the `ignore` selector (default ignores the admin toolbar).
- Automatically add `rel="noreferrer"` to external links for privacy.
- Force external links to open in a new window site-wide.
- Treat additional domains as "internal" so partner sites aren't flagged external.
- Add icons inside shadow-DOM web components via `shadowComponents`.
- Provide screen-reader hints only (hide the visual icon) for specific links via `hideIcon`.
- Skip marking on pages where a certain element is present/absent (`noRunIfPresent`/`noRunIfAbsent`).
- Use custom CSS classes or HTML icons instead of the bundled icon set.
- Position an icon before or after the link text per category.
- Avoid double-marking image links by suppressing icons on links that wrap an image.
- Deploy consistent link-purpose indicators across environments as exported config.
- Give editors accessible links without teaching them to add icons manually.
- Match the icon styling to a design system through wrapper/icon CSS classes.
- Keep marking off the admin UI automatically (module skips admin routes).
- Provide a consistent "external link" experience across every theme without template edits.
- Help low-vision users by visually distinguishing actionable link types.
