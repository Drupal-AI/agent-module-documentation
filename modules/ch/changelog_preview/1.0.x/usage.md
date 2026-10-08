Changelog Preview renders admin-configured Markdown changelog files as HTML pages inside a Drupal site.

---

Changelog Preview lets a site administrator publish one or more Markdown changelog files as browsable pages within Drupal. On the settings form at `/admin/changelog_manage` the admin builds a repeatable list of "changelog items", each pairing a server-relative file path, a display name, and a browser path (the URL where the page appears). For every configured item the module registers a dynamic route, reads the file from disk on request, converts it from Markdown to HTML with the bundled `michelf/php-markdown` library, and outputs the result. An index page at `/changelog/base` lists all configured changelogs, a toolbar tab links to that index, and dynamic local tasks (tabs) appear for each item. Everything is gated by a single `view changelog` permission, while managing the configuration requires `administer site configuration`. The module has no config schema, no submodules, and no dependencies on other Drupal modules; it only pulls in the PHP-Markdown and Symfony Routing libraries via Composer.

---

- Display a project's `CHANGELOG.md` as a formatted page inside the Drupal admin or front end.
- Publish release notes for editors so they can see what changed between deployments.
- Surface multiple changelog files (e.g. one per subsystem or module) from a single site.
- Give content editors a human-readable "What's new" page without touching code.
- Point the viewer at a Markdown file that lives anywhere under the Drupal root via a relative path.
- Configure a custom URL (browser path) for each changelog, e.g. `/changelog/frontend`.
- Provide a toolbar "Changelog" tab that jumps to the changelog index at `/changelog/base`.
- Add tabs (local tasks) for each changelog under the changelog section.
- Grant the `view changelog` permission to editors or authenticated users to let them read release notes.
- Expose a public changelog to anonymous visitors by granting `view changelog` to the anonymous role.
- Render fenced/indented code blocks in changelogs with the module's grey code styling.
- Add new changelog entries incrementally with the "Add another changelog" AJAX button on the settings form.
- Keep release documentation in Markdown in the repository and preview it live on the running site.
- Show migration or deployment notes to a release-management team from within Drupal.
- Convert internal Markdown docs to HTML for viewing without a separate documentation site.
- Maintain separate "current" and "archive" changelog pages by configuring two items.
- Provide a lightweight in-site documentation viewer for any Markdown file the admin controls.
- Let a QA team browse the changelog for a specific environment via a dedicated URL.
- Replace a hand-maintained HTML "updates" page with an auto-rendered Markdown source.
