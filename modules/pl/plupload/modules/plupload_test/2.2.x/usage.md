Plupload test is a tiny support/demo module that exposes a working example form at `/plupload-test` demonstrating how to use the `plupload` upload element and process its result.

---

The submodule ships one form, `\Drupal\plupload_test\PluploadTestForm` (form id `_plupload_test_form`), mapped to the route `plupload.test` at path `/plupload-test` with `_access: 'TRUE'` (its routing file explicitly warns "Do not enable in production"). The form renders a single `#type => 'plupload'` element restricted to the `zip` extension, plus a normal Submit button and an Ajax submit button. Its `validateForm()` checks each uploaded descriptor's `status === 'done'`, and its `submitForm()` shows the canonical pattern for handling plupload output: prepare a destination directory under the site's default scheme (`<scheme>://plupload-test`), then move each finished temp file (`$uploaded_file['tmppath']`/`name`) into place with the file system and stream-wrapper managers — without creating `file` entities. It exists purely as living documentation and as the fixture used by Plupload's automated tests; it adds no config, no permissions, no services, and no plugins of its own.

---

- Manually verify that Plupload uploads work on a site by visiting `/plupload-test` and uploading a `.zip`.
- Copy `PluploadTestForm` as a starting template when building your own plupload-based upload form.
- See the correct submit-handler pattern for moving finished plupload temp files into a destination directory.
- Learn how to restrict a plupload element to a single extension (`zip`) via `#upload_validators`.
- Observe how to validate that each uploaded descriptor has `status === 'done'` before saving.
- Reproduce and debug plupload chunking / large-file behavior in a minimal, isolated form.
- Confirm a site's `temporary_uri` and destination stream are writable end-to-end.
- Demonstrate both a standard submit and an Ajax submit button alongside a plupload element.
- Use as the fixture module for Plupload's functional/JS test coverage.
- Smoke-test a new Drupal environment's file-upload configuration (limits, permissions, streams).
- Show colleagues how the descriptor array (`name`/`tmpname`/`status`/`tmppath`) looks in practice.
- Provide a quick QA target after upgrading the Plupload JS library.
- Validate CSRF-protected upload flow works for the current user.
- Serve as a reference for moving files with `FileSystem::move()` and `StreamWrapperManager::normalizeUri()`.
- Prototype extension restrictions before wiring them into a real feature.
