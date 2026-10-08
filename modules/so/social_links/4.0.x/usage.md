<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
**Social Links** exposes a *Social Links* pseudo-field (`hook_entity_extra_field_info`) on every entity bundle's display. Enable it on a view display and each rendered entity gets share links (Twitter/X, Facebook, email by default) whose target URL is the current page and whose text is the page title. Providers are extensible in code — there is no admin UI.

---

`hook_entity_view()` renders the field by calling the `social_links.factory` service (`SocialLinkFactory`), which holds a registry of providers keyed by name. Defaults (`getDefaults()`): `twitter` → `https://twitter.com/intent/tweet?url=%s&text=%s`, `facebook` → `https://www.facebook.com/sharer/sharer.php?u=%s&quote=%s`, `email` → `mailto:?body=%s&subject=%s`. For each provider the factory instantiates a link class (default `SocialLink`, or `SocialLinkPopUp` for popup-window links) and calls `render($entity)`, which `sprintf`s the provider path with the URL-encoded current request URI and page title and returns a `Drupal\Core\Link`. Output is themed as an `item_list` with class `social-links` and attaches the `social_links/social_links` library. Other modules register or replace providers via `hook_social_links_alter()` (see `social_links.api.php`) — e.g. to add LinkedIn/WhatsApp or supply an inline-SVG icon per provider (the `svg` config key renders a `<use xlink:href>` sprite reference). No routes, permissions, config entities or forms; configuration is entirely code/hook driven.

---

- Show Twitter/X, Facebook and email share links on article nodes.
- Enable share links per view mode (teaser vs full) on any entity type.
- Add share links to taxonomy terms, users or custom entities.
- Register a custom provider (LinkedIn, WhatsApp, Telegram) via a hook.
- Replace the default provider set entirely with `hook_social_links_alter`.
- Open Twitter/Facebook shares in a popup window (`SocialLinkPopUp`).
- Use an inline-SVG sprite icon per provider via the `svg` config key.
- Share the current page URL with its page title pre-filled.
- Position the share links via the display's pseudo-field weight.
- Theme the links through the `item_list` / social-links markup.
- Provide an email-this-page link with subject and body prefilled.
- Add provider-specific CSS classes (`twitter-social-link`, etc.) for styling.
- Attach the module's front-end library for popup behavior.
- Build a fully custom share provider by extending `SocialLink`.
- Localize provider labels through Drupal translation.
- Log provider render failures to the `social_links` channel.
- Expose share links on search-result or listing view modes.
- Keep share configuration in code for reproducible deployments.
