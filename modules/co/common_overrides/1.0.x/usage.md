<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Common Overrides provides a small admin config surface for overriding items that are hard-coded in Drupal core; currently it customizes the node search results heading.

---

A `RouteSubscriber` swaps the controller of the dynamic `search.view_node_search` route for `CommonOverridesSearchController`, which extends core's `SearchController::view` and, using `common_overrides.settings`, wraps the search results title in a configurable heading tag (`h1`–`h6`) with configurable text. Configuration lives at `/admin/config/common_overrides` behind the `administer site configuration` permission.

Operational note: the search controller builds the title markup by string-concatenating the configured tag and title (`"<$tag>$title</$tag>"`) into `#markup`; the tag comes from a fixed select list and the title is admin-entered, so exposure is limited to users who already hold `administer site configuration`. The info.yml `configure` key (`common_overrides.admin.config`) does not match the defined route name (`common_overrides.admin_settings`), so the settings link may be dead until corrected.

---
- Enable the module.
- Visit /admin/config/common_overrides to configure overrides.
- Set the text shown above node search results.
- Choose the heading tag (h1–h6) for the search results title.
- Confirm the node search page reflects the new heading.
- Grant `administer site configuration` to editors who manage the override.
- Use it to standardize the search results heading across a site.
- Review `common_overrides.settings` config for exported values.
- Extend the RouteSubscriber pattern to override other core routes.
- Verify the swapped controller still returns core search results.
- Wrap search results heading in an SEO-friendly h1.
- Adjust the heading tag without a custom theme override.
- Keep the override in code via exported config.
- Audit which core routes the module currently overrides.
- Fix the info.yml configure route mismatch before relying on the menu link.
- Document the override for other site builders.
- Disable the module to restore core search behavior.
