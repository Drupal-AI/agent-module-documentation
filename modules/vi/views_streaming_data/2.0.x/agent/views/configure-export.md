<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a streaming export display

There is no admin settings page — everything is configured on an individual view.

## Steps

1. Edit (or create) a view at `/admin/structure/views`.
2. **Add** a new display of type **Streaming data export**.
3. Set a **Path** for the display (this becomes the download URL, GET-only).
4. **Format → Style**: choose **CSV streaming Serializer** or **JSON streaming Serializer**
   (CSV is the default). The **Row style is locked to `data_field`** (core REST's field row plugin) —
   add the fields you want as columns under *Fields*.
5. Optional format settings:
   - **CSV**: delimiter (Comma / Pipe `|` / Tab), Strip tags, Decode HTML entities, Trim whitespace.
     Pipe produces a `.txt` (`text/plain`); Tab produces a `.tsv`.
   - **Chunk size**: 5–200 (default 50) — rows fetched + rendered per batch. Lower it if rows are
     entity-heavy and memory is still tight; raise it to reduce per-batch overhead.
   - **File name**: derive from the path, set a custom name, or leave blank for `{view}-{display}`.
     The extension is added from the serializer.
6. **Authentication** (optional): tick the providers to require (e.g. `basic_auth`, `cookie`). This sets
   `_auth` on the route. Per the module's own help text, also set the **Access** section appropriately
   (e.g. Access: Role → Authenticated user), because the auth system falls back to anonymous if
   authentication fails.
7. **Access**: set the view's Access plugin (permission/role/custom) exactly as you would for a page
   display — it is enforced on the stream.
8. Save. Visit the path to download; there is no live preview for this display.

## Example test view

The bundled `views_streaming_data_test` module ships
`tests/module/views_streaming_data_test/config/install/views.view.test_basic_content_export.yml`, a
`test_basic_content_export` view over `basic_content` nodes with a streaming CSV display — a working
reference for the display/style/row/field configuration.

## Behavioural notes for callers

- The download begins before the query completes; a mid-stream failure yields a truncated file, not an
  error page.
- Disable output buffering/gzip on this route in any reverse proxy, or the memory benefit is lost on the
  proxy.
- Modules that post-process `$view->result` after execution may not work here — the streaming executable
  keeps `$view->result` empty and iterates the raw statement instead.
