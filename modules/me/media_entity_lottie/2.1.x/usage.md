Media entity Lottie adds a "Lottie file" media source and a matching field formatter so Drupal Media can store `.json` Lottie animations and render them with the LottieFiles `<lottie-player>` web component.

---

The module plugs into core Media. Its `lottie_file` media source (extending core's `File` source) accepts a `file` field restricted to the `json` extension, extracts Lottie metadata (width, height, name, version, frame rate) from the animation JSON, and validates on upload via a `lottie_file` constraint that checks the file is non-empty, valid JSON, and contains the required Lottie keys (`fr`, `ip`, `op`, `w`, `h`, `ddd`). The `file_lottie_player` field formatter (extending `FileMediaFormatterBase`) renders each file as a `<lottie-player>` element and attaches the external `lottie-player` JS library from unpkg; settings expose background color/transparency, hover-to-play, loop mode (normal/bounce), speed, count, and a "play when visible" option backed by a small IntersectionObserver-style script using lottie-interactivity. On install the module copies a `lottie.png` thumbnail icon into the media icon directory. Configuration is done entirely through the standard Media UI (create a media type using the Lottie source, then set the source field's display to the Lottie player) — there is no dedicated settings form (`configure: null`). Note the JS libraries are loaded from a remote CDN (unpkg), so the player needs outbound network access or a local library override.

---

- Add animated Lottie illustrations to a site as reusable Media entities.
- Create a "Lottie animation" media type editors can upload `.json` files into.
- Render marketing hero animations with the `<lottie-player>` web component.
- Validate on upload that an uploaded JSON file is actually a valid Lottie animation.
- Show a looping animated icon set managed through the Media library.
- Play an animation only when it scrolls into view (the "play when visible" setting).
- Play an animation on mouse hover and pause otherwise.
- Loop an animation a fixed number of times, or infinitely.
- Reverse/bounce an animation with the "bounce" play mode.
- Set a transparent background so an animation blends into the page.
- Control animation playback speed per display.
- Embed Lottie animations into content via the Media library / entity reference.
- Reuse one animation across many pages by referencing the same media entity.
- Expose Lottie animation metadata (width/height/frames/version) as media fields.
- Provide a lightweight vector animation alternative to heavy GIF/MP4 files.
- Store brand micro-interactions (button/loader animations) as governed media.
- Let editors swap an animation without a developer by editing the media entity.
- Build an animated onboarding or feature-tour section from Lottie files.
- Use Lottie animations in Layout Builder via a media reference field.
- Display an animated 404 / empty-state illustration.
- Attach the play-when-visible behavior to reduce jank on long pages.
- Map the source `field_media_lottie_file` to the Lottie player formatter automatically.
- Serve animations from a local library override instead of the unpkg CDN.
- Add animated seasonal decorations that editors control as media.
- Present decorative loops with hover interactivity in a card grid.
