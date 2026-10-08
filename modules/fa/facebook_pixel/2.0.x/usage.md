<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Facebook Pixel injects the Meta/Facebook tracking pixel into your Drupal pages, with page- and role-based visibility rules, several privacy opt-outs, and a service that lets any module push extra pixel events.

---

Everything lives in one config object, `facebook_pixel.settings`: `facebook_id`, a `visibility` group (`request_path_mode` = `all_pages`/`listed_pages`, `request_path_pages` as a newline-separated path list, `user_role_mode` = `all_roles`/`listed_roles`, `user_role_roles`) and a `privacy` group (`donottrack`, `fb_disable_advanced`, `eu_cookie_compliance`, `disable_noscript_img`). `hook_page_attachments()` checks that a pixel id is set and that the current path and the current user's roles pass the visibility tests, then attaches the `facebook_pixel/facebook_pixel` library and hands `drupalSettings.facebook_pixel` the id, the queued events and the three JS-side privacy flags; `js/facebook_pixel.js` bootstraps `fbq` and fires them. `hook_page_top()` separately emits the `<noscript><img src="https://www.facebook.com/tr?id=…&ev=PageView&noscript=1">` fallback unless `privacy.disable_noscript_img` is on — note that this fallback ignores the visibility rules and the JS privacy flags. Events are collected through the `facebook_pixel.facebook_event` service (`FacebookEvent::addEvent($event, $data, $start_session)` / `getEvents()`), which stores them in a static array for anonymous requests and in the `user` private tempstore once a session exists, invoking `hook_facebook_pixel_event_data_alter($data, $event)` on the way in. The module itself registers `ViewContent` for every node rendered in the `default`/`full` view mode (with `content_name`, `content_type`, `content_ids`) and `CompleteRegistration` on user insert; `PageView` is fired by the JS. An Ajax command class, `FacebookPixelTrackCommand`, lets a controller push an event from an Ajax response (`Drupal.AjaxCommands.prototype.facebook_pixel_track`). Two permissions are declared (`configure facebook_pixel`, `use php for page_visibility`) and the settings form sits at `/admin/config/facebook_pixel`. A `d7_facebook_pixel_settings` migration carries the Drupal 7 `facebook_pixel_id` variable over. Commerce events (`AddToCart`, `InitiateCheckout`, `Purchase`, product `ViewContent`) come from the bundled `facebook_pixel_commerce` submodule.

---

- Add the Meta/Facebook Pixel to a Drupal site without pasting the snippet into a template.
- Track page views for a marketing campaign landing page.
- Track content views (`ViewContent`) on every full node page automatically.
- Track completed user registrations (`CompleteRegistration`) for a signup funnel.
- Push a custom conversion event (`Lead`, `Contact`, `Subscribe`) from a form submit handler.
- Fire a pixel event from an Ajax response with `FacebookPixelTrackCommand`.
- Enrich an event's payload from another module via `hook_facebook_pixel_event_data_alter()`.
- Replace the product SKU in `content_ids` with a product id for a catalogue feed match.
- Keep tracking off all admin paths, node forms and `system/ajax` (the shipped default list).
- Track only a specific set of landing pages by switching to "the listed pages only".
- Exclude logged-in editors from tracking by listing their roles.
- Track only anonymous visitors, or only members of a "customer" role.
- Honour browser Do-Not-Track headers with the `privacy.donottrack` opt-out.
- Provide a global `fbOptout()` JS function and honour `window['fb-disable']`.
- Delay tracking until EU Cookie Compliance consent has been given.
- Drop the `<noscript>` fallback image so no request is made before consent.
- Roll out the same pixel configuration across environments through exported config.
- Migrate the pixel id from a Drupal 7 site with the bundled migration.
- Restrict who may change the pixel configuration with the `configure facebook_pixel` permission.
- Verify the pixel is present on a page by checking `drupalSettings.facebook_pixel.facebook_id`.
- Swap the pixel id per environment by overriding the config in `settings.php`.
- Temporarily disable tracking site-wide by clearing `facebook_id`.
- Attribute e-commerce revenue by adding the `facebook_pixel_commerce` submodule.
- Debug queued events by dumping `\Drupal::service('facebook_pixel.facebook_event')->getEvents()`.
- Track a multi-step form's completion as a single custom event at the last step.
