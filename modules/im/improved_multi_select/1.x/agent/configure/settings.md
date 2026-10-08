<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Improved Multi Select

Single config object **`improved_multi_select.settings`**, edited at route **`ims.settings`**
(`/admin/config/user-interface/ims`, permission *administer site configuration*). All keys are
flat; there are no config entities and no per-field settings on the base module.

## When the widget is attached to a page

`hook_page_attachments()` activates on the **first** of these that is true:

1. `isall` is TRUE → replace **all** `select[multiple]` on every page.
2. `url` matches the current path (via `path.matcher`, `*` wildcard, `<front>` supported), OR
   `selectors` is non-empty → activate on this page.

If activated, the attached `drupalSettings.improved_multi_select.selectors` is
`['select[multiple]']` when `isall` is on (or when no explicit selectors given), otherwise the
lines of the `selectors` textarea.

## Config keys (with shipped defaults)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `isall` | bool | `false` | Replace all multi-selects site-wide. |
| `url` | string | `''` | Paths (one per line) to activate on; `*` wildcard, `<front>`. |
| `selectors` | string | `''` | jQuery selectors (one per line) to replace, e.g. `select[multiple]`. |
| `placeholder_text` | string | `''` | Placeholder shown in the search box. |
| `filtertype` | string | `'partial'` | Filter mode — see below. |
| `js_regex` | bool | `false` | Allow JS regular expressions in the filter input. |
| `orderable` | bool | `false` | Show Move up / Move down and keep add-order. |
| `groupresetfilter` | bool | `false` | Clear the filter when an optgroup is selected (vs cross-filter). |
| `remove_required_attr` | bool | `false` | Strip HTML5 `required` from hidden selects (server-side validation). |
| `buttontext_add` | string | `'>'` | "Add" button label. |
| `buttontext_addall` | string | `'»'` | "Add all" button label. |
| `buttontext_del` | string | `'<'` | "Remove" button label. |
| `buttontext_delall` | string | `'«'` | "Remove all" button label. |
| `buttontext_moveup` | string | `'Move up'` | "Move up" label (only when `orderable`). |
| `buttontext_movedown` | string | `'Move down'` | "Move down" label (only when `orderable`). |

### `filtertype` values

`partial` (default), `exact`, `anywords`, `anywords_partial`, `allwords`, `allwords_partial`.
Non-partial modes require whole-word matches; the `_partial` variants match substrings.

## Read / write via drush

```bash
drush cget improved_multi_select.settings                 # dump all keys
drush cget improved_multi_select.settings filtertype
```

```php
// Scriptable set (booleans keep real bool type):
$c = \Drupal::configFactory()->getEditable('improved_multi_select.settings');
$c->set('isall', TRUE)->set('placeholder_text', 'Filter options')->save();
```

The form (`Drupal\improved_multi_select\Form\SettingsForm`, form id `ims_admin_settings_form`)
persists exactly the 15 keys above and nothing else.
