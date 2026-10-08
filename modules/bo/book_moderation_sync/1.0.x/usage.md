<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Book Moderation Sync pushes a book page's content-moderation state down onto its direct child pages whenever the parent book node is saved.

---

Book Moderation Sync is a small glue module between core Content Moderation and core Book. On every save of a moderated node of type `book`, it reads that node's new `moderation_state` and applies the same state to each of the book's direct child pages (via the book outline), saving any child whose state differs. It also offers one optional setting — off by default — to delete all of a book's children when the parent book node is deleted. It provides no entities, plugins, permissions or Drush commands of its own; its only route is a single admin settings form. Supports Drupal 10.3+ and 11, and requires the `book` and `content_moderation` modules (and the contrib Book 2.x package).

---

- Keep a book and its chapter/page children at the same content-moderation state without moderating each page by hand.
- Publish a whole book at once: set the book node to a published state and its direct children follow.
- Archive a book and have its direct children move to the archived state together.
- Move a book's children back to draft by transitioning the parent book node to a draft state.
- Maintain a consistent editorial-workflow status across a book outline.
- Reduce the click-through of transitioning each child page individually in the moderation UI.
- Use with any content-moderation workflow applied to the `book` content type (published/archived/draft or custom states).
- Automatically clean up orphaned child pages by enabling "Delete children when a book is deleted" before removing a book.
- Turn the delete-children behavior on or off at `/admin/config/content/book-moderation-sync`.
- Apply to editorial teams that publish documentation or handbooks organized as Drupal books.
- Fit sites where a book's top page acts as the single control point for the book's visibility.
- Combine with core Book's hierarchy so state changes ride the existing parent/child outline.
- Keep the module dormant when no workflow is attached to the `book` type (sync only runs on moderated book nodes).
- Log a warning when a child's book-outline row is missing a depth key, and an error if a child save fails, on channel `book_moderation_sync`.
- Deploy the single boolean setting through configuration management (`book_moderation_sync.settings`).
- Roll out book-wide publish/unpublish as part of a scheduled content release.
- Support multilingual or large documentation books where per-page moderation is tedious.
- Provide a predictable "parent decides state" model for content teams.
- Serve as a lightweight alternative to custom workflow automation for book content.
