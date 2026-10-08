Background Wallpaper lets an administrator upload a single image and have it applied as a CSS background on selected content types and/or the front page.

---

Background Wallpaper is a small theming convenience module. It adds one settings form at `/admin/config/background-wallpaper` where an administrator uploads a background image (a `managed_file`, stored under `public://background_wallpaper/`) and selects one or more targets: any node content type and/or the special "Front Page" target. On every page request, `hook_page_attachments()` checks whether the current page matches a selected target (front page, or a node whose type is selected) and, if so, attaches an inline `<style>` element that sets `#main { background-image: url(<uploaded image>) !important; background-size: cover; background-position: center; }`. There is no per-page override, no image style/derivative handling, no block or field — it is a single site-wide image driven entirely by the `background_wallpaper.settings` config object. It targets the `#main` CSS selector, so it assumes the active theme renders a `#main` element. Requires only core `system` and `config`; supports Drupal 10 and 11.

---

- Apply a single uploaded image as the page background without editing theme CSS.
- Brand a site quickly by setting a corporate wallpaper on key pages.
- Show the wallpaper only on the front page by selecting the "Front Page" target.
- Show the wallpaper on all nodes of one content type (e.g. every `landing_page`).
- Show the wallpaper on several content types at once (the target select is multi-value).
- Combine front page + one or more content types in a single configuration.
- Swap the site background centrally by uploading a new image in one place.
- Restrict the background to editorial content types while leaving admin/system pages plain.
- Provide a cover-fit, centered background that scales to the viewport (`background-size: cover`).
- Force the background over theme styles using the emitted `!important` rule.
- Store the chosen image and targets as exportable configuration (`background_wallpaper.settings`).
- Deploy the same wallpaper configuration across environments via config sync.
- Give administrators (holders of `administer site configuration`) a self-service background control.
- Keep the footprint minimal: no external dependencies, libraries, or services.
- Use it as a lightweight alternative to a custom theme template just for a background image.
- Turn the wallpaper off by clearing the image or deselecting all targets.
- Limit uploads to raster image types (jpg, jpeg, png, gif) via the form's file constraint.
- Support seasonal or campaign rebranding by re-uploading the image on the settings form.
- Apply a consistent background across all matching pages site-wide.
- Pair with a theme that renders a `#main` wrapper so the rule takes effect.
