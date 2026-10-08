<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Universal File Utils is a developer-oriented module that turns Drupal's `hook_file_download` and `hook_file_access` into dispatched events, letting client modules decide whether a file may be viewed or downloaded, and it exposes helper methods to copy and remove file entities.
---
The module does nothing visible on its own — it provides an event-based decision layer. Its `hook_file_download` implementation (moved to the front of the implementation list via `hook_module_implements_alter`) only handles URIs containing `/system/files/` or the `private://` scheme; for those it loads the matching file entity (with an exact case-sensitive URI match) and dispatches a `UniversalFileDownloadEvent`, returning the subscriber-supplied headers (or `-1` to deny). Its `hook_file_access` dispatches a `UniversalFileAccessEvent` and returns the resulting access result. Client modules subscribe by extending the provided base subscriber and implementing a couple of decision methods.

The `UniversalFileOperations` service (`universal_file_utils.operations`) also offers `fileCopy($fid, $folderName, $subFolderName)` — which copies a loaded file into `private://{folderName}/{subFolderName}` and marks it permanent — and `fileRemove($fid)`, which loads and deletes a file (also clearing usage). These are PHP API methods with no routes, forms, or permissions of their own; they are only reachable from other code, so gating and input validation are the responsibility of the calling module. There is no HTTP-facing endpoint that takes a request-supplied path, so there is no direct traversal surface exposed by this module; however, a caller that passes unsanitized user input as `folderName`/`subFolderName` could influence the destination path, so callers should validate those.

Setup: enable the module as a dependency of a client module, then implement event subscribers for `UniversalFileDownloadEvent` and/or `UniversalFileAccessEvent`, and call the operations service where file copy/remove helpers are useful.
---
- Decide file downloadability through a dispatched event.
- Decide file view/download access through an access event.
- Deny a download by calling `$event->denyDownload()`.
- Add custom response headers to a file download.
- Handle only `/system/files/` and `private://` download URIs.
- Match the exact file entity by case-sensitive URI.
- Copy a file entity into a private subfolder and mark it permanent.
- Remove a file entity and its usage records by fid.
- Provide file access logic without writing hook boilerplate.
- Extend the base access subscriber with two decision methods.
- Move the module's `hook_file_download` to run first.
- Centralize private-file access decisions across modules.
- Reuse file copy/remove helpers from custom code.
- Return `-1` to block a private file download.
- Auto-name copy subfolders by year-month when omitted.
- Log download mismatches when no exact file matches.