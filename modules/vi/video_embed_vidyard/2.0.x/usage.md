<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Video Embed Vidyard adds a Vidyard provider to Video Embed Field. Editors paste a Vidyard share/embed URL; the field emits Vidyard's inline embed `<script>` (`play.vidyard.com/{id}.js`). A settings form lets admins add a custom Vidyard domain and extra URL path patterns.

---

`getIdFromInput()` parses the URL, requires the host to contain `vidyard.com` (or the admin-configured custom domain), and extracts the ID via a regex whose captured group is restricted to `[_\-a-zA-Z0-9]+`, so the ID is constrained. The admin-supplied `additional_pattern` is run through `Html::escape()` before being placed into the regex. The embed is a Drupal `html_tag` `script` element whose `src`/`id` are built with `sprintf` from the constrained ID, with render-array attribute escaping — not a raw-HTML XSS sink; there is no server-side fetch of the pasted URL (no SSRF). The custom-domain/pattern settings are admin-only (`administer video_embed_vidyard`). Because Vidyard embeds load remote JS from `play.vidyard.com`, the usual third-party-script trust applies.

---

- Embed Vidyard videos in Video Embed Field fields.
- Emit Vidyard's inline JS embed for a share URL.
- Support a custom Vidyard sharing domain.
- Add extra URL path patterns (e.g. `watch`) for parsing.
- Constrain the parsed Vidyard ID to a safe character set.
- Escape admin-supplied patterns before regex use.
- Reuse VEF widgets and formatters for Vidyard.
- Provide a Vidyard thumbnail via `play.vidyard.com`.
- Toggle autoplay through formatter options.
- Mix Vidyard with other VEF providers in one field.
- Restrict domain/pattern settings to an admin permission.
- Serve marketing video hosted on Vidyard.
- Attach the module's inline-player CSS library.
- Accept both default (`share`/`embed_select`/`watch`) and custom patterns.
- Review third-party JS trust for `play.vidyard.com`.
- Use on standard or media-source VEF fields.
- Configure settings at the module's admin route.
