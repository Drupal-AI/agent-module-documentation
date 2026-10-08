Book module content type is a small bundled module that registers a dedicated "book" content type and marks it as an allowed book outline type, giving you a ready-made content type for building books.

---

On install (`book_content_type_install()`), this module sets `book.settings.allowed_types` so the `book` content type is both an allowed book type and its own allowed child type — meaning nodes of type `book` can be placed into outlines and nest under one another. It ships inside the project under `tests/modules/` and is declared `package: Testing`, so it exists primarily as a test fixture / convenience for spinning up a book content type quickly rather than as a production feature; it has no configuration form, permissions, services or plugins of its own. Use it (or copy its one install hook) when you want a distinct "Book" content type instead of reusing an existing type like Page or Article.

---

- Get a ready-made "book" content type for building book outlines.
- Pre-populate `book.settings.allowed_types` so `book` nodes can join outlines.
- Allow `book` nodes to nest as children of other `book` nodes out of the box.
- Skip manually configuring allowed book types after enabling Book.
- Spin up a demo/documentation site with a dedicated Book content type fast.
- Serve as a fixture for automated tests that need a book-enabled content type.
- Provide a copy-paste example of setting `allowed_types` from `hook_install()`.
- Separate book pages from your other content types (Page, Article) by using a distinct type.
- Bootstrap a curriculum/manual site where every page is a "book" node.
- Reference implementation for wiring a content type into the Book module programmatically.
- Quickly reset a test environment to a known book-content-type configuration.
- Avoid hand-editing config when prototyping book hierarchies.
- Guarantee child pages share the same `book` type via the child_type setting.
- Use as a starting scaffold you adapt into a custom production book content type.
- Demonstrate the content_type/child_type pairing structure of allowed_types.
