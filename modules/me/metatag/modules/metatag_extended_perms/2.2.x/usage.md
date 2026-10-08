Adds a separate permission for every individual meta tag, so you can control which roles may edit which tags on content forms.

---

By default Metatag exposes all tags to anyone who can edit the Metatag field. This submodule replaces that all-or-nothing access with one dynamically generated permission per meta tag (via a `permission_callback` in `MetatagPermissions`). Site builders can then grant, for example, only the "description" and "title" tags to editors while reserving Open Graph or robots tags for SEO specialists. Because it generates one permission per tag, the permissions admin page can grow large on sites with many tags (see the module's README). Depends on the main Metatag module. Best on sites with many editor roles and a need to lock down advanced or risky tags.

---

- Allow editors to edit only the page title and description tags.
- Reserve `robots` (noindex/nofollow) editing for administrators.
- Let a social team edit Open Graph and Twitter Card tags only.
- Hide advanced tags (canonical, referrer) from basic editors.
- Grant per-tag access to different content-editor roles.
- Prevent accidental changes to canonical URLs by most users.
- Delegate favicon/mobile tag editing to a theming role.
- Lock verification tags to trusted administrators.
- Give a marketing role access to keywords and description only.
- Audit which role can change each SEO-critical tag.
- Combine with core Field Permissions for layered control.
- Expose only the tags relevant to a given workflow.
- Reduce editor confusion by hiding unused tags.
- Enforce governance over high-impact meta tags.
- Progressively open up tags to roles as they gain expertise.
- Keep the Metatag field visible while restricting specific tags.
- Protect structured-data tags from unauthorized edits.
