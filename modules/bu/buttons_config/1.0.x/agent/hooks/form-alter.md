<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The relabeling mechanism — buttons_config_form_alter()

File: `buttons_config.module` (`buttons_config_form_alter(&$form, FormStateInterface $form_state,
$form_id)`). This is the only runtime code path; there is no service or plugin.

## Algorithm

1. Split `$form_id` on `_` and take the first segment. If it is `node` load
   `buttons_config.node.settings`; if `media` load `buttons_config.media.settings`; if `comment`
   load `buttons_config.comment.settings`; otherwise `$configs = NULL` and the hook returns.
2. Read `$configs = ...->get('form_ids')`. If null, return.
3. For each stored row, read `enabled`, `form_id` (`$ct_name`), `form_type` (`$form_isSave`) and
   `custom_text`. Compute the target form id:
   - `form_type` truthy (Save, index `1`) → `$form_name = $ct_name . "_form"`.
   - `form_type` falsy (Edit, index `0`) → `$form_name = $ct_name . "_edit_form"`.
4. If `enabled == 1` **and** `$form_name == $form_id`, set
   `$form['actions']['submit']['#value'] = t($values['custom_text'])`.

```php
if ($enabled == 1 && $form_name == $form_id) {
  $form['actions']['submit']['#value'] = t($values['custom_text']);
}
```

## Which real form ids match

- **Content types.** Stored `form_id` = `node_{bundle}`. Save → `node_{bundle}_form` (the real add
  form id) and Edit → `node_{bundle}_edit_form` (the real edit form id). Both match core node forms.
- **Media types.** Stored `form_id` = `media_{bundle}_add` (the select options carry a literal `_add`
  suffix — see [../configure/settings.md](../configure/settings.md)). Save →
  `media_{bundle}_add_form`, which matches the real media **add** form id. Edit →
  `media_{bundle}_add_edit_form`, which does **not** match the real media edit form
  (`media_{bundle}_edit_form`), so the media "Edit" option has no effect in practice.
- **Comment types.** Stored `form_id` = `comment_{bundle}`. The comment form offers only "Save"
  (index `0`), which `form_alter` treats as *Edit* (falsy), producing `comment_{bundle}_edit_form`;
  the real comment form id is `comment_{bundle}_form`. So comment relabeling generally does not fire.
  These are functional quirks of the module, not configuration you can fix from the UI.

## Notes for agents

- The label is passed through `t()` with a **variable** as the format string — a Drupal i18n
  antipattern (translatable strings should be literals). It is harmless for output safety: core
  renders the submit `#value` as an HTML-escaped `value` attribute
  (`AttributeString::__toString()` → `Html::escape()`), so button text cannot inject markup.
- Only forms whose `actions.submit` element exists are affected; the hook assumes
  `$form['actions']['submit']` is present.
- The hook runs on **every** form build (it is a global `hook_form_alter`, not
  `hook_form_FORM_ID_alter`), but does nothing unless the first `$form_id` segment is
  `node`/`media`/`comment` and a matching enabled row exists.
