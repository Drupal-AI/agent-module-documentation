Account Name rewrites the core "My account" menu link to show a greeting label, the current user's username, and optionally their user picture.

---

Account Name is a small display-only module that alters the "My account" link in Drupal's user menu. Via a single admin settings form it lets you turn the feature on, add a greeting label (e.g. "Welcome", "Hi", "Hello") in front of the logged-in user's username, render the user's picture through any configured image style, and choose whether the picture appears before or after the name. It works through a `hook_link_alter` implementation (`account_name_link_alter`) that matches links pointing at the `user.page` route whose text reads "my account", so it needs no theme changes and no dependencies beyond Drupal core. It only ever affects the current viewer's own menu link.

---

- Show a friendly greeting like "Welcome jdoe" in the account menu instead of the generic "My account" text.
- Display the logged-in user's avatar next to their name in the primary user/account menu.
- Give members a more personalized header by surfacing their own username where core shows static text.
- Add a "Hi", "Hello", or "Welcome" prefix to the account link without editing any Twig template.
- Render the user picture through a specific image style (e.g. `thumbnail`) so avatars stay a consistent size in the menu.
- Flip the layout so the username appears before the avatar (or the avatar before the name) to match a header design.
- Turn the whole enhancement on or off site-wide from one checkbox during theming iterations.
- Provide a lightweight "logged-in as" cue in the navigation for community or membership sites.
- Improve wayfinding on intranets where users benefit from seeing their own name in the menu.
- Reinforce brand tone by customizing the greeting wording per site (formal vs. casual).
- Add avatar-in-menu behavior on themes that don't ship it, without a custom module.
- Keep the account link consistent across themes since the change happens in a link alter, not a template override.
- Use it on decoupled-lite or admin-heavy sites to make the account menu more recognizable at a glance.
- Configure everything from `/admin/config/user-interface/account-name` with no code.
- Ship the configuration between environments as part of a config export (`account_name.settings`).
- Pair with a custom image style to crop avatars to a circle/square for the menu display.
- Give editors and admins a quick visual confirmation of which account they're currently signed in as.
- Personalize the account menu for logged-in users while anonymous visitors are unaffected.
- Adjust the greeting label seasonally or for campaigns without touching theme code.
- Enable it on multilingual sites where the label can be translated through the config translation UI.
- Use as a simple example of altering menu link text and rendering a user field via `hook_link_alter`.
