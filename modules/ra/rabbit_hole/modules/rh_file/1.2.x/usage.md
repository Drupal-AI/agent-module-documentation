Registers File entities (via the File Entity module) with Rabbit Hole so you can control what happens when a file is viewed at its canonical page — display, access denied, page not found, or redirect — per file type or per file.

---

`rh_file` is the Rabbit Hole submodule for the contributed File Entity module. Enabling it registers a Rabbit Hole entity plugin for the `file` entity type, adding the "Rabbit Hole settings" vertical tab to file type edit forms and (when overrides are allowed) individual file edit forms. File entity pages are almost never intended as browsable destinations, so this submodule is used to 404, deny access to, or redirect them — useful for privacy and to avoid exposing standalone file landing pages. All behavior logic, redirect codes, tokens, and fallbacks come from the base `rabbit_hole` module; this submodule only wires up file support. It depends on `rabbit_hole` and `file_entity`.

---

- Return access denied on file canonical pages to keep them private.
- Return 404 for file entity pages that shouldn't be browsable.
- Redirect a file page to the node that references it.
- Set a per-file-type default behavior, overridable per file.
- Deny access to document file types on their standalone page.
- Redirect using a token such as `[file:field_source]`.
- Return "page not found" instead of "access denied" to hide existence.
- Override the file-type default on a specific file.
- Configure a fallback action for empty/invalid redirect targets.
- Redirect legacy file landing URLs to new locations with a 301.
- Let admins bypass the action to view real file pages.
- Grant a role permission to administer Rabbit Hole on files only.
- Redirect image file pages to their usage context.
- Redirect a file page to `<front>`.
- Hide file pages from crawlers for SEO cleanup.
- Prevent audio/video file pages from rendering standalone.
- Route file pages to a download handler.
- Stop file pages from resolving on a headless site.
