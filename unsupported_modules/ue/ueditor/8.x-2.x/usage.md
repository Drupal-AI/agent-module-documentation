<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
UEditor plugs Baidu's UEditor rich-text editor into Drupal as an editor plugin, together with the endpoints it expects for image, video, file and scrawl uploads, a file manager and remote-image fetching.

---

UEditor is widely used on Chinese-language sites and this module is the Drupal 8+ bridge for it: a `Plugin/Editor/UEditor` so it can be selected per text format, a settings form, an upload controller, and a watermarking option. Configuration comes partly from Drupal config and partly from the editor's own `lib/config.json`.

**Do not deploy this without reading the security notes; two of the three findings are serious, and both were executed on a clean install.** The `catchimage` action is a **server-side request forgery with response exfiltration**: an account holding only the non-restricted `upload file with ueditor` permission caused the server to fetch an arbitrary URL — internal hostnames included — and the response body was written into the public files directory and then read back **anonymously**. The URL only has to start with `http` and carry an allowed extension anywhere in the string, so `?x=.png` appended to any address passes; and the Content-Type check is written with the negation missing, so responses that *are* images are rejected while everything else is accepted. Separately, all four upload actions write through `FileSystem::saveData()` rather than Drupal's managed-file pipeline, so no upload validator, no extension munging, no file entity and no tracking apply.

There is also an environmental catch: composer resolves `drupal/ueditor` to a **dev branch** — the checkout here is `1.x-dev` at tag 8.x-2.62 (October 2024) — so a site adopting it gets unreleased code by default and no `version:` in the info file.

If you need UEditor specifically, treat the module as needing a patch before use: constrain the catcher to an allow-list of hosts, fix the inverted Content-Type test, and route uploads through core's file validators.

---

- Offer UEditor as an alternative WYSIWYG for a text format.
- Give Chinese-language editors a familiar editing interface.
- Upload images from the editor toolbar.
- Upload video and other files from the editor.
- Save a hand-drawn "scrawl" image.
- Browse previously uploaded images from the editor.
- Apply a watermark to uploaded images.
- Configure upload paths per media type.
- Set maximum upload sizes per type.
- Restrict which text formats offer UEditor.
- Restrict who may upload through the editor.
- Audit an inherited site that already uses UEditor.
- Constrain the remote-image catcher before going live.
- Review what the public files directory has accumulated.
- Decide between UEditor and CKEditor 5 for a new site.