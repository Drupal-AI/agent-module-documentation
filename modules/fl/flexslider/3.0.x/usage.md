FlexSlider integrates the FlexSlider 2 jQuery slider/carousel library with Drupal, letting you turn multi-value image fields or Views results into responsive, touch-enabled sliders driven by reusable "optionset" configuration.

---

FlexSlider wraps the FlexSlider 2 jQuery library (a lightweight image gallery/carousel plugin) and exposes it to Drupal through configuration and display plugins. The core building block is the `flexslider` config entity — an "optionset" (config prefix `optionset`, so config objects are named `flexslider.optionset.{id}`) that captures every library setting: animation type, speed, direction, slideshow behavior, navigation controls, carousel item width/margin, keyboard/touch/mousewheel options and an advanced CSS namespace. A ships-with-the-module `default` optionset is installed, and you define as many more as you like; because they are config entities they export and deploy between environments. Two bundled submodules provide the display integration: **FlexSlider Fields** adds a `flexslider` image field formatter (plus a responsive variant when core Responsive Image is enabled) that only applies to multi-value image fields, and **FlexSlider Views Style** adds a "FlexSlider" Views style plugin where you pick an optionset, an optional caption field and a container element ID. The actual JavaScript library is an external dependency that must be placed at `[DRUPAL ROOT]/libraries/flexslider` (suggested via Composer as `woothemes/flexslider:~2.0`); the module attaches it via the `flexslider/integration` library, which depends on the `flexslider/flexslider` library plus core jQuery/Drupal/once. An advanced settings form (`/admin/config/media/flexslider/advanced`) toggles debug/unminified JS and whether the library and module CSS load. Developers can also attach a slider to any render array manually with `flexslider_add($id, $optionset)`, which returns an `#attached` array. All admin routes are gated by the single `administer flexslider` permission.

---

- Turn a multi-value image field into a slideshow by setting its display formatter to "FlexSlider".
- Build an image carousel by choosing an optionset with a non-zero item width and item margin.
- Display Views results as a slider by selecting the "FlexSlider" Views style format.
- Create a named optionset for a hero banner (fade animation, 7s slideshow) and reuse it site-wide.
- Define a second optionset for a thumbnail-navigation gallery (`controlNav: thumbnails`).
- Switch a slider between horizontal and vertical sliding via the `direction` option.
- Use slide vs. fade animation by changing the `animation` option per optionset.
- Enable or disable auto-advancing via the `slideshow` option and tune `slideshowSpeed`.
- Loop the slideshow continuously or randomize slide order (`animationLoop`, `randomize`).
- Add previous/next arrows and paging dots, or hide them (`directionNav`, `controlNav`).
- Turn on hardware-accelerated touch swipe and keyboard/mousewheel navigation.
- Add a pause/play indicator and pause-on-hover behavior for accessibility.
- Set a caption field on a Views slider so each slide shows descriptive text.
- Give a slider a custom container element ID to run multiple sliders on one page.
- Namespace an optionset's CSS classes to build per-slider custom styling from `flexslider_img.css`.
- Deliver responsive slider images with the Responsive FlexSlider formatter (core Responsive Image enabled).
- Export optionsets as configuration and deploy them between dev/stage/prod.
- Attach a slider to a custom block or page render array in code with `flexslider_add()`.
- List available optionsets in a custom form using `flexslider_optionset_list()`.
- Load the unminified library for debugging by toggling debug mode in advanced settings.
- Opt out of loading the library CSS or the module's fix-up CSS on the settings form.
- Point the module at the JS library placed under `/libraries/flexslider`.
- Restrict slider administration to trusted users via the `administer flexslider` permission.
- Set a starting slide, initialization delay or smooth-height transition per optionset.
- Sync two sliders (e.g. a main slider driven by a thumbnail nav slider) with `sync`/`asNavFor`.
