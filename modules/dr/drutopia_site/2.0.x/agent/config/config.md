<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drutopia Site — shipped configuration, update hooks, and role grants

Everything this module does is exported YAML. There is no PHP `src/`. Two directories:
`config/install/` (imported once on enable) and `config/actions/` (config-action files
processed by Drutopia's config-actions mechanism, which **additively edit existing config**
rather than replacing it).

## Install / enable

`drush en drutopia_site`. It has no settings form (`configure` = null). Manage the results
through core admin pages: `/admin/people/roles`, `/admin/people/permissions`,
`/admin/config/content/formats`, `/admin/structure/block-content/types`.

## `config/install/` — site-level config it ships

Text formats + CKEditor 5 editors (`/admin/config/content/formats`):
- `filter.format.basic_html` — `filter_html` enabled with a safe allow-list (`<p> <h2..h6 id>
  <a hreflang href> <img ...>` etc.), plus `filter_html_image_secure`, `filter_align`,
  `filter_caption`, `editor_file_reference`. Paired editor `editor.editor.basic_html`
  (CKEditor 5, sourceEditing limited to a fixed tag allow-list; image upload to
  `public://inline-images`).
- `filter.format.full_html` — `filter_html` **disabled** (unrestricted markup, core-standard
  Full HTML), with `filter_align`/`filter_caption`/`filter_htmlcorrector`/`editor_file_reference`.
  Paired editor `editor.editor.full_html` (full CKEditor 5 toolbar incl. `sourceEditing`).
- `filter.format.restricted_html` — `filter_html` enabled with a conservative inline allow-list,
  `filter_autop`, `filter_url`. No editor (plain textarea).

Block content (`block_content`) bundles + fields + displays:
- `block_content.type.basic` ("Basic block") and `block_content.type.slide` ("Slide", revisions on).
- `field.storage.block_content.body` (`text_long`, cardinality 1) + `field.field.block_content.basic.body`
  (`text_with_summary`, label "Body").
- `field.field.block_content.slide.field_slide` — an `entity_reference_revisions` field targeting the
  `slide` paragraph type (depends on `paragraphs.paragraphs_type.slide`, supplied elsewhere).
- Form/view displays: `core.entity_form_display.block_content.{basic,slide}.default`,
  `core.entity_view_display.block_content.basic.default`, and
  `core.entity_view_display.block_content.slide.{default,columnar}` (a second `columnar` view mode).

## `config/actions/autosave_form.settings.yml`

One `change` action: sets `allowed_new` = TRUE on `autosave_form.settings`, i.e. enable
auto-saving of content that has not been saved yet. (autosave_form scopes each autosave to the
owning user/entity.)

## `config/actions/` — the SIX role permission grants

Each `user.role.<id>.yml` uses config-action `add` plugins to **append** module deps, config deps,
and `permissions` entries to an existing role. They do not create the roles and do not remove
anything. Exact permission strings added per role:

- **`anonymous`** (minimal):
  - `use text format restricted_html`

- **`authenticated`**:
  - `use text format basic_html`
  - `use workflow_buttons_trash_publishing transition create_new_draft`
  - `use workflow_buttons_trash_publishing transition save_draft_leave_current_published`
  - `use workflow_buttons_trash_publishing transition save_unpublished`

- **`contributor`** (workflow only; no text-format grant here):
  - `use workflow_buttons_trash_publishing transition create_new_draft`
  - `use workflow_buttons_trash_publishing transition save_draft_leave_current_published`
  - `use workflow_buttons_trash_publishing transition save_unpublished`

- **`editor`**:
  - `use text format restricted_html`
  - `use workflow_buttons_trash_publishing transition delete`
  - `use workflow_buttons_trash_publishing transition publish`
  - `use workflow_buttons_trash_publishing transition restore_draft`
  - `use workflow_buttons_trash_publishing transition restore_publish`
  - `use workflow_buttons_trash_publishing transition unpublish`
  - `use workflow_buttons_trash_publishing transition update`

- **`manager`** (superset of the editorial + admin block/menu/role perms):
  - `administer block content`, `administer block types`, `administer blocks`
  - `administer main menu items`
  - `use text format restricted_html`
  - `assign manager role`, `assign editor role`, `assign contributor role`
  - `access block library`
  - `create basic block content`, `create slide block content`
  - `edit any basic block content`, `edit any slide block content`
  - `revert any basic block content revisions`, `revert any slide block content revisions`
  - `view any basic block content history`, `view any slide block content history`
  - `use workflow_buttons_trash_publishing transition delete/publish/restore_draft/restore_publish/unpublish/update`

Note: **no role here is granted `use text format full_html`** — Full HTML remains unassigned by this
module. The `manager` admin permissions and role-delegation grants (`assign * role`) are scoped to the
trusted `manager` role only.

## Update hooks (`drutopia_site.install`)

- `drutopia_site_update_8101()` — `module_installer` uninstall `admin_links_access_filter`, install
  `admin_toolbar_links_access_filter`.
- `drutopia_site_update_8102()` — install `autosave_form`, `menu_admin_per_menu`, `role_delegation`,
  `wysiwyg_linebreaks`.
- `drutopia_site_update_9201()` — install `admin_toolbar_search`.

No `hook_install`/`hook_uninstall`; no other logic in the file.
