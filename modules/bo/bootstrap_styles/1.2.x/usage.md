Bootstrap Styles adds a reusable style builder plus a library of style plugins (background, spacing, colors, borders, shadow, typography, animations) to Drupal's Layout Builder, applying CSS classes to sections and blocks.

---

Bootstrap Styles is a foundation module that provides two plugin types — `StylesGroup` (a group tab such as Background, Spacing, Border, Shadow, Typography, Animation) and `Style` (an individual control such as Background Color, Padding, Margin, Box Shadow, Text Color, Scroll Effects) — together with two plugin managers (`plugin.manager.bootstrap_styles`, `plugin.manager.bootstrap_styles_group`) and the `StylesGroupManager` service. `StylesGroupManager` builds the style form elements, saves the chosen values into a per-element storage array, and on render calls each plugin's `build()` to attach the corresponding CSS classes (and libraries) to the element build. It does not add UI to Layout Builder on its own; consumer modules — chiefly **bootstrap_layout_builder** — call `buildStylesFormElements()`, `submitStylesFormElements()` and `buildStyles()` to expose those controls on Layout Builder sections and blocks and to render the result. The available option classes (e.g. `bs-bg-success|Green`, `bs-p-3|Padding 3`) are defined as editable text in the single config object `bootstrap_styles.settings`, edited at the settings form at **Admin → Configuration → Content authoring → Bootstrap Styles** (`/admin/config/bootstrap-styles/settings`, permission `configure bootstrap styles`), where you also pick the off-canvas builder theme (dark/light), the background image/video media bundles and fields, and the scroll-effects (AOS) library settings. Background media relies on the `media_library_form_element` dependency, and scroll effects use the AOS library (loaded remotely, or locally if placed in `libraries/aos`). Developers extend it by adding their own `@Style` / `@StylesGroup` plugins, and the `bootstrap_styles_info` alter hook lets other modules alter plugin definitions.

---

- Add background color, image, or video controls to Layout Builder sections via the Background group.
- Apply responsive spacing (padding/margin, all sides, per breakpoint) to sections and blocks.
- Set text color and text alignment on Layout Builder content, including per-breakpoint variants.
- Add borders (style, width, color, rounded corners) to a section or block.
- Apply a box shadow (small/regular/large) to an element.
- Add scroll-in animations (fade, flip, zoom via AOS) to sections through the Animation group.
- Configure the CSS class list for each style (e.g. `bs-bg-success|Green`) at the settings form.
- Switch the Layout Builder off-canvas styling UI between the dark and light theme.
- Choose which media bundle/field supplies background images and local background videos.
- Restrict which style groups/plugins are offered in a given context via a filter config and `getAllowedPlugins()`.
- Build a custom style tool on top of Layout Builder by consuming `StylesGroupManager` in your own module.
- Render stored styles onto an element build with `buildStyles()` so the right CSS classes are attached.
- Provide the styling engine that bootstrap_layout_builder uses for section/block appearance.
- Define a brand-new style control by adding a `@Style` plugin extending `StylePluginBase`.
- Define a new grouping tab in the style UI by adding a `@StylesGroup` plugin extending `StylesGroupPluginBase`.
- Alter or remove existing style/group plugin definitions with `hook_bootstrap_styles_info_alter()`.
- Attach the style option classes to either an element or its theme wrapper via `addClassesToBuild()`.
- Deploy the style option lists and settings across environments as `bootstrap_styles.settings` config.
- Map option classes to human labels for radio/tooltip UIs using `getStyleOptions()`.
- Serve background videos through the `bs_video_background` render element / theme.
- Use the AOS library locally by dropping it into `libraries/aos` (auto-detected via `hook_library_info_alter`).
- Gate access to the style configuration UI with the `configure bootstrap styles` permission.
- Enable a Bootstrap-class-driven design system for editors building pages in Layout Builder.
