<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the submit-button labels

All configuration is done in the UI; there is no drush command and no config schema. You need the
`admin buttons config` permission.

## Where

- Landing page: `/admin/config/content/buttons-config` (route `buttons_config.admin_config_page`).
  It is just a menu-block page (`SystemController::systemAdminMenuBlockPage`) listing the three
  editable forms. Menu location: Administration → Configuration → Content authoring.
- Content types: `/admin/config/content/buttons-config/content-type`
  (`buttons_config.config_content_type.form` → `ButtonsConfigContentTypeForm`).
- Media types: `/admin/config/content/buttons-config/media-type`
  (`buttons_config.config_media_type.form` → `ButtonsConfigMediaTypeForm`).
- Comment types: `/admin/config/content/buttons-config/comment-type`
  (`buttons_config.config_comment_type.form` → `ButtonsConfigCommentTypeForm`).

## Each form

Each of the three forms extends `ConfigFormBase` and renders one `#type => 'table'` (`form_ids`) with
four columns, one always-empty "add" row plus one row per already-saved entry:

- **Content Type / Media Type / Comment Type** (`form_id`): a `select` of the bundles of the relevant
  entity type. Options are keyed:
  - content: `node_{bundle}` (label = node type label) — from `node_type` storage.
  - media: `media_{bundle}_add` (note the literal `_add` suffix) — from `media_type` storage.
  - comment: `comment_{bundle}` — from `comment_type` storage.
- **Form** (`form_type`): a `select`. Content and media offer `["Edit", "Save"]` → stored index
  `0 = Edit`, `1 = Save`. Comment offers only `["Save"]` → stored index `0`.
- **Enabled** (`enabled`): a `checkbox` (0/1). A row is only applied when enabled.
- **Custom Text** (`custom_text`): a `textfield`, `#maxlength => 50`. The text shown on the button.

Save writes to the form's config object (`ButtonsConfigContentTypeForm::SETTINGS`
= `buttons_config.node.settings`; media = `buttons_config.media.settings`; comment =
`buttons_config.comment.settings`) under key `form_ids` (`FORM_TABLE`). See
`submitForm()` in each form class (e.g. `ButtonsConfigContentTypeForm.php:204`).

## Stored shape (what submitForm writes)

`submitForm()` rebuilds `form_ids` keyed by `{form_id}{_save|_edit}`, dropping any row with an empty
`custom_text`:

```yaml
# config: buttons_config.node.settings
form_ids:
  node_article_save:
    form_type: 1          # 1 = Save, 0 = Edit
    form_id: node_article
    enabled: 1
    custom_text: 'Publish article'
```

The relabeling itself happens in `buttons_config_form_alter()` — see
[../hooks/form-alter.md](../hooks/form-alter.md) for the exact form-id matching (and the media/comment
suffix quirks).

## Editing config directly

Because there is no schema, you can set these with drush, e.g.:

```bash
ddev drush config:set buttons_config.node.settings \
  form_ids.node_article_save.form_id node_article
# ...plus form_type, enabled, custom_text keys for that row.
```

Prefer the UI forms — they enforce the `{form_id}{_save|_edit}` keying that `form_alter` relies on.
