<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drutopia User is a configuration-only Drutopia base feature that standardizes how the core User entity's account form and public profile are displayed, and adds a reusable compact user view mode.

---

Drutopia User ships no PHP code, routes, services, permissions, or plugins. It contains only three exported core configuration objects in `config/install`: an entity form display (`user.user.default`), an entity view display (`user.user.default`), and a second entity view display for a `compact` view mode (`user.user.compact`). Enabling the module imports those objects so a new Drutopia site gets a consistent user account form (with account, contact, language, and timezone fields arranged, and the Path/alias widget hidden) and a deliberately minimal profile display (member-for and search-excerpt pseudo-fields hidden). It is a "features" module (`bundle: drutopia`) intended as part of the wider Drutopia distribution and depends only on core (`field`, `file`, `image`, `path`, `user`). There is no settings page; after install, any further tuning happens through Drupal's standard Manage display / Manage form display screens for the user entity.

---

- Give a fresh Drupal site a ready-made, consistent user account form layout without hand-configuring Manage form display.
- Standardize the user profile (default view mode) presentation across sites built on Drutopia.
- Add a reusable `compact` user view mode for terse contexts such as teasers, author bylines, and listings.
- Bootstrap a Drutopia distribution install as one of its base feature modules alongside drutopia_core, drutopia_people, drutopia_site, etc.
- Arrange the account edit/registration form so the account, contact, language, and timezone sections appear in a defined order.
- Hide the URL-alias (Path) widget from the user form so editors are not prompted for a user path alias.
- Keep the default user profile display minimal by hiding the "Member for" pseudo-field.
- Hide the Search API excerpt pseudo-field from user displays where Search API is present.
- Provide a baseline you can override per-site through Manage display and Manage form display.
- Reset a site's user display configuration back to a known baseline by reinstalling the feature.
- Serve as a config example of exporting `core.entity_form_display.*` / `core.entity_view_display.*` objects in a features module.
- Ensure a second (compact) user view mode is registered and configured, ready to select in views, references, or entity embeds.
- Ship user display config as code so it can be version-controlled and deployed via config import.
- Establish predictable field weights on the user form so contributed fields slot in around a known layout.
- Use as a lightweight dependency for higher-level Drutopia features that assume the standard user displays exist.
- Provide a starting point for theming user profiles, since the default and compact view modes are already defined.
- Avoid shipping ad-hoc, per-developer user display tweaks by centralizing them in one enable-and-forget module.
