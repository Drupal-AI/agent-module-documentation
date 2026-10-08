# CKEditor5 Bootstrap Tabs — agent index

Adds a **`bootstrapTabs`** toolbar button to CKEditor 5 for inserting/managing Bootstrap tabbed
content (nav-tabs + tab panes) in the WYSIWYG. Depends on `ckeditor5`. No settings form, no config
entity, no PHP config (`configure: null`), no permissions, no Drush — you enable it by adding the
button to a text format's CKEditor 5 toolbar.

- **Enable the button on a format, the allowed-tags/markup it produces, and the frontend library** →
  [configure/enable-toolbar-button.md](configure/enable-toolbar-button.md)

Key facts: the CKEditor 5 plugin id is `ckeditor5-bootstrap-tabs.BootstrapTabs`, toolbar item
`bootstrapTabs` (declared in `ckeditor_bootstrap_tabs.ckeditor5.yml`). Enabling it = adding
`bootstrapTabs` to `editor.editor.<format>` → `settings.toolbar.items`. The tab markup
(`ul.nav.nav-tabs`, `div.tab-content > div.tab-pane`, `a.tab-link`) must be permitted by the format's
filters. `hook_page_attachments()` loads the `ckeditor_bootstrap_tabs/tabs` library for front-end
interactivity; your theme provides Bootstrap's own styles.
