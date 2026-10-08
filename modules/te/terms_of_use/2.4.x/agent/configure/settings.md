# Configure Terms of Use

Settings form: `\Drupal\terms_of_use\Form\TermsOfUseSettingsForm` at
`/admin/config/people/terms-of-use` (route `terms_of_use.settings_form`, permission
**`administer account settings`**). All values persist in config object `terms_of_use.settings`.

## Settings keys

| Key | Type | Form widget | Meaning |
|---|---|---|---|
| `terms_of_use_node` | integer (nid) | entity_autocomplete (node), `#required` | The node whose content is the Terms of Use. |
| `terms_of_use_label_name` | label | textfield | Title of the `details` fieldset wrapping the terms. Empty = still wrapped, no title. |
| `terms_of_use_label_checkbox` | label | textfield | The required checkbox label. May contain the `@link` token. |
| `terms_of_use_open_link_in_new_window` | boolean | checkbox | If the `@link` token is used, open the terms link with `target="_blank"`. |
| `terms_of_use_collapsed` | boolean | checkbox | If TRUE the `details` starts collapsed; the module inverts this into `#open`. |

`terms_of_use_label_name` and `terms_of_use_label_checkbox` are `translatable: true` (config
translation via `terms_of_use.config_translation.yml`).

## How it renders (`hook_form_user_register_form_alter`)

- **Skipped entirely** when the current user has `administer users` — admin-created accounts at
  `/admin/people/create` never see the terms.
- Builds `$form['terms_of_use']` as `#type => details` titled `terms_of_use_label_name`. `#open` is
  the inverse of `terms_of_use_collapsed`.
- Loads `terms_of_use_node`; if it has a translation for the current interface language, uses it.
- If `terms_of_use_label_checkbox` contains `@link`: replaces `@link` with a link to the node
  (`Link::fromTextAndUrl`), optionally `target=_blank`; the **body text is not shown**.
- Else: emits the node body raw as `#markup`: `<div class='terms-of-use'>{body[0]['value']}</div>`
  (the raw stored value, i.e. NOT re-run through the field's text-format filters — the terms node
  is admin-authored trusted content).
- Adds `$form['terms_of_use']['terms_of_use_checkbox']` = `#type => checkbox`, `#required => TRUE`,
  titled by the checkbox label (fallback `t('I agree with these terms')`).

## Drush / set programmatically

```php
\Drupal::configFactory()->getEditable('terms_of_use.settings')
  ->set('terms_of_use_node', 123)
  ->set('terms_of_use_label_name', 'Terms of Use')
  ->set('terms_of_use_label_checkbox', 'I agree with the @link.')
  ->set('terms_of_use_open_link_in_new_window', TRUE)
  ->set('terms_of_use_collapsed', FALSE)
  ->save();
```

## Setup checklist

1. Create a node holding the terms text (do not promote it).
2. Enable public registration (core: *People → Account settings → Who can register accounts → Visitors*).
3. Point `terms_of_use_node` at the node and set your labels here.
4. Clear cache. The checkbox now appears (and is required) at `/user/register`.
