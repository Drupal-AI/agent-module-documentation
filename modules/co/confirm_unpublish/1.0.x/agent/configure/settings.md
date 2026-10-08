# Settings form (configure)

Single admin form, `Drupal\confirm_unpublish\Form\ConfirmUnpublishSettingsForm` (extends
`ConfigFormBase`, form id `confirm_unpublish_settings_form`).

- Route: `confirm_unpublish.settings` → `/admin/config/content/confirm-unpublish`.
- Access: `_permission: 'administer confirm unpublish settings'`.
- Menu link: `confirm_unpublish.settings`, under Configuration → Content authoring
  (`system.admin_config_content`).
- Editable config: `confirm_unpublish.settings` (`getEditableConfigNames()`).

## Config keys — `confirm_unpublish.settings`

| Key | Form element | Default (`config/install`) | Meaning |
|---|---|---|---|
| `alert_text` | `text_format` (`#required`) | the built-in "Are you sure…" HTML | The message shown in the dialog body. |
| `alert_text_format` | (format of the above) | `basic_html` | Text-format id used to render `alert_text`. Saved manually in `submitForm()` from the `text_format` element's `format`. |
| `logging` | `checkbox` (`#config_target`) | `1` | When on, a confirmed unpublish is logged (see api/mechanism.md). |
| `allowed_content_types` | `checkboxes` (`#config_target`) | `{ }` (empty) | Node bundles to **exclude** from the dialog. Options come from `node_type` storage (`loadMultiple()`). |

`alert_text` uses manual save because a `text_format` element cannot bind to `#config_target`;
`logging` and `allowed_content_types` use `#config_target` and are saved by `parent::submitForm()`.

## Important behavior of `allowed_content_types` (the exclusion list)

The `.module` reads this key as `$excluded_content_types` and gates the dialog with:

```php
if (!empty($excluded_content_types) && !in_array($node_type, $excluded_content_types)) {
  // ... attach dialog + drupalSettings ...
}
```

Consequences an agent must know (source-verified, not what the UI label implies):

- **Empty list (the shipped default) ⇒ the dialog is attached to NO content type.** The form's help
  text ("All content types are included by default") describes intent, but the code only attaches
  when the list is non-empty. To get a dialog anywhere you must select at least one bundle to exclude.
- A bundle **present** in the list is excluded (no dialog). A bundle **absent** from a **non-empty**
  list gets the dialog. So to protect all types except `article`, tick only `article`.
- The gate is by node **bundle** id; only `node` entities are ever affected (hook is
  `hook_form_node_form_alter`).

## Config schema

No `config/schema/*.yml` ships with the module (only `config/install/confirm_unpublish.settings.yml`).
`allowed_content_types` in the install file is `{ }`. Because there is no typed schema, treat the
key types above as observed-from-code, and expect config-inspection/translation tooling to warn about
the missing schema.

## Set it from the CLI

```bash
# Exclude nothing-but-article from the dialog (i.e. dialog on every type except article):
ddev drush cset confirm_unpublish.settings allowed_content_types.article article -y
# Turn logging off:
ddev drush cset confirm_unpublish.settings logging 0 -y
```
