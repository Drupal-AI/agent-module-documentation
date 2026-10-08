Web Admin is a recipe-driven meta-bundle that installs and pre-configures a curated set of core and contrib administration tools for a Drupal site.

---

Web Admin (part of the Webship suite) ships almost no code of its own: a thin `webadmin.install` applies the bundled `recipes/default` recipe on install. That recipe enables a batch of core admin modules (Announcements Feed, Configuration Manager, Contextual Links, Database Logging, Field UI, Help, Update Manager, Views UI, Toolbar, Shortcut, Content Moderation, Workflows, Package Manager) plus contrib tools (Automatic Updates, Coffee, Drupical, Project Browser, Simple Add More, Tagify, View Password, Views Bulk Operations, Views Bulk Edit, Masquerade), installs the Claro and Default Admin core admin themes, and sets Default Admin as the site administration theme. It also applies config actions: content is edited/added in the admin theme, users self-register only by admin approval with mail verification, the content_editor role (when present) gets toolbar/contextual-links/admin-theme access, trusted Composer plugins are registered so Automatic Updates readiness checks pass, and defaults are set for Announcements, Drupical, Project Browser, Tagify and Update. The result is a ready-to-use administration environment on core's Default Admin theme without hand-enabling each module. It does not install Layout Builder, Navigation or dashboards (those come from the separate Web Dashboard recipe).

---

- Stand up a full administration toolset on a fresh site with a single module install.
- Enable core admin modules (Field UI, Views UI, DB Log, Update, Help, Contextual, Toolbar, Shortcut) in one step.
- Turn on Content Moderation and Workflows as part of the baseline admin stack.
- Add Automatic Updates plus Package Manager for in-place core and readiness-checked updates.
- Register `cweagans/composer-patches` and `webship/patches` as trusted Composer plugins for update readiness.
- Allow automatic core minor updates via `automatic_updates.settings`.
- Install Project Browser and enable its in-UI module install flow (`allow_ui_install`, `max_selections: 1`).
- Provide Coffee ("Spotlight"-style) keyboard-driven navigation to admin pages.
- Add Drupical to surface upcoming Drupal community events in the admin UI.
- Give editors View Password to reveal masked password fields.
- Add Tagify autocomplete/tagging widgets and set it as the default widget for reference fields.
- Enable Tagify User List for user reference tagging.
- Add Simple Add More (SAM) to streamline multi-value field "add another" UX.
- Provide Views Bulk Operations (VBO) for running actions on selected view rows.
- Provide Views Bulk Edit (VBE) to edit multiple entities' field values at once.
- Add Masquerade so admins can switch into another user's session for support/testing.
- Set core's Default Admin theme as the site administration theme.
- Place Claro and Default Admin admin blocks (breadcrumbs, content, help, local actions, messages, page title, primary/secondary local tasks).
- Edit and create content using the admin theme (`node.settings.use_admin_theme`).
- Harden user registration to admin-approval only with mail verification and block-on-cancel.
- Grant the content_editor role toolbar, contextual links and admin-theme access when that role exists.
- Import a default shortcut set so the toolbar's shortcuts have a set to display.
- Limit Announcements Feed to 2 items and hide its admin announcement menu link.
- Provide a consistent, pre-wired admin experience across Webship-based sites.
