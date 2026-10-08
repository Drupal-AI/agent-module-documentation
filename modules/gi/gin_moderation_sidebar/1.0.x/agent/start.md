# Gin Moderation Sidebar — agent index

A CSS-only compatibility bridge: styles the **Moderation Sidebar** tab to fit the **Gin**
admin theme. No plugins, no permissions, no Drush, no services. Its only persistent state is
one config value, `tab_style`, in `gin_moderation_sidebar.settings`.

- **The one setting (`tab_style`: `default` | `contrast`), the settings form, and how the
  CSS/body class get attached** → [configure/settings.md](configure/settings.md)

Key facts:
- Config object: `gin_moderation_sidebar.settings`, key `tab_style` (shipped default `default`).
- Settings route: `gin_moderation_sidebar.settings_form` at
  `/admin/config/user-interface/gin-moderation-sidebar` (perm `administer site configuration`).
- Runtime effect (only when Gin is active): body class `gms--tab-style-<style>` +
  library `gin_moderation_sidebar/main`.
- Hard dependencies: `moderation_sidebar`, `gin_toolbar`.
