Gin Moderation Sidebar is a tiny CSS bridge that makes the Moderation Sidebar toolbar tab look right when the Gin admin theme (via Gin Toolbar) is active.

---

The module carries no logic beyond attaching a stylesheet and a body class. When Gin is the active admin theme (detected with `_gin_toolbar_gin_is_active()`), `hook_preprocess_page()` attaches the `gin_moderation_sidebar/main` library (`css/gin_moderation_sidebar.css`) and `hook_preprocess_html()` adds a `gms--tab-style-<style>` class to the `<body>` element. The `<style>` comes from a single configuration value, `tab_style`, stored in `gin_moderation_sidebar.settings` and editable at a small settings form (route `gin_moderation_sidebar.settings_form`, path `/admin/config/user-interface/gin-moderation-sidebar`, guarded by `administer site configuration`). Two styles ship: `default` and `contrast` (High contrast); the shipped default is `default`, and Gin's own high-contrast mode also triggers the contrast look. It has no permissions, services, plugins, or Drush commands of its own, and it hard-depends on both `moderation_sidebar` and `gin_toolbar`. If Gin is not active, both hooks return early and the module does nothing.

---

- Make the Moderation Sidebar workflow tab visually consistent with the Gin admin theme.
- Switch the moderation tab to a High contrast style for better visibility.
- Pair Moderation Sidebar with Gin Toolbar without leaving the tab looking broken.
- Add a `gms--tab-style-contrast` body class so a subtheme can hook further CSS onto it.
- Provide editors a clearer "Tasks" moderation control on Gin-themed edit screens.
- Keep the moderation tab styling in sync when Gin's high-contrast mode is enabled.
- Configure the tab appearance from a single admin form under User Interface.
- Standardise moderation-sidebar look across a multi-site editorial platform using Gin.
- Ship the tab-style choice as exported config (`tab_style: contrast`) for deployment.
- Remove custom one-off CSS overrides editors previously used to fix the tab under Gin.
- Give a content-moderation workflow a polished editor experience on the Gin theme.
- Toggle between the default and high-contrast tab presentation per environment.
- Ensure the moderation tab respects Gin's spacing and color tokens.
- Improve accessibility of the moderation tab via the high-contrast option.
- Add the styling only on admin/Gin routes, leaving the front-end theme untouched.
- Bundle with a Gin-based editorial install profile so moderation looks native out of the box.
- Let a themer target `body.gms--tab-style-default` vs `body.gms--tab-style-contrast` for overrides.
- Keep moderation controls legible for editors on dark or dense Gin layouts.
- Roll out consistent moderation-tab styling to an editorial team through one setting.
- Fix the "floating unstyled tab" problem when Gin Toolbar is enabled with Moderation Sidebar.
