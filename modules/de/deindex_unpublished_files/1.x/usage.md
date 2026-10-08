Deindex Unpublished Files relocates the file behind an unpublished media entity — moving it to private storage or renaming it .ht_ — so unpublished files stop being publicly downloadable, and restores them when the media is republished.

---

Unpublishing a media entity in Drupal hides the media, but the file it wraps, if kept in public://, is still directly fetchable at its URL — so "unpublished" attachments remain reachable by anyone with the link. Deindex Unpublished Files closes that gap. It reacts to a media entity's publish-state change on save (hook_media_presave) and physically relocates each file the media references. In "move" mode it relocates unpublished public:// files into private://unpublishedfiles/ (which Drupal serves only through file-access checks) and moves them back to public:// on republish; in "prefix" mode it renames the file with a leading .ht_ (a dotfile that Drupal's default .htaccess and recommended nginx config deny) and strips the prefix on republish. The rule applies only to media types whose bundle includes a file, image, or svg_image field. The project also ships a "Media usage overview" admin page (Content > Unpublish media by usage) driven by a MediaUsageInspector service that walks nodes and other content entities — including CKEditor drupal-media embeds, paragraphs, and revision references — to surface media used only by unpublished content, with filters, paging, and a bulk-unpublish action. Note that the deindexing is achieved by moving/renaming the file, not by an X-Robots-Tag header, and the module does not implement hook_file_download, so it never itself grants or denies file access. Operationally, "move" mode requires the private:// stream to be configured and the private://unpublishedfiles/ directory to exist; the ".ht_" fallback relies on the web server honouring Drupal's dotfile-deny rules (Apache does by default; nginx needs the equivalent). Because files change URI on each transition, confirm references still resolve after a publish/unpublish cycle.

---

- Stop unpublished media files from being publicly downloadable.
- Move an unpublished media's public:// file into private://unpublishedfiles/.
- Automatically restore the file to public:// when the media is republished.
- Use the .ht_ prefix mode when a private move is not available.
- Protect draft or embargoed attachments (PDFs, images, documents) behind media.
- Close the "unpublished content is still fetchable" gap for media-managed files.
- Keep files inaccessible without writing custom hook_media_presave code.
- Apply protection only to media types that actually hold a file/image field.
- Choose the enforcement method (private move vs. .ht_ rename) per site policy.
- Warn admins to create and protect the private://unpublishedfiles/ folder.
- Review which media are used only in unpublished nodes via the usage overview page.
- Bulk-unpublish media that are no longer used on any published content.
- Filter the usage overview by media type and "not used on published nodes".
- Detect media referenced only through CKEditor drupal-media embeds in unpublished bodies.
- Trace media usage through paragraphs and entity-reference-revisions fields.
- Identify orphaned media that should be unpublished before a content cleanup.
- Enforce that unpublishing a media takes its file offline for search engines.
- Pair with content moderation to take files offline when the latest revision is a draft.
- Provide an admin-only audit of media-to-content usage across the site.
- Roll files back to their original public path automatically on republish.
- Configure the private file system before switching to "move" mode.
- Restrict the settings page to trusted administrators (administer site configuration).
- Restrict the usage/bulk page to media administrators (administer media).
