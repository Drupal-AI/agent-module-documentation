# Configure Protected Forms

## Admin UI & permissions

- Route `protected_forms.admin` → `/admin/config/content/protected_forms`.
- Permission to configure: **`administer protected forms`**.
- Permission to skip all checks: **`bypass protected forms validation`**.

## Config object

`protected_forms.settings` — note everything is nested under a `protected_forms` mapping key:

```yaml
protected_forms:
  allowed_scripts:            # sequence of Unicode script names that ARE allowed
    - 'Currency Symbols'
    - 'Latin'
    - 'Miscellaneous Symbols'
  check_quantity: 50          # integer: number of random characters sampled for the script check
  reject_message: 'Oops! It looks like your post contains spam content. ...'   # shown on rejection
  reject_patterns: "http://, https://, www, ... viagra, casino, ..."           # comma/newline list
  log_rejected: true          # boolean: log rejected submissions to dblog
  allowed_patterns: ''        # string: strings stripped from input before checking (whitelist)
  excluded_forms:             # sequence of form ids to skip entirely
    - 'user_login_form'
    - 'user_register_form'
    - 'user_pass'
```

Script names for `allowed_scripts` come from `unicode_character_ranges.inc` (e.g. `Latin`,
`Cyrillic`, `Greek and Coptic`, `Arabic`, ...). `reject_patterns` is parsed by splitting on commas
and newlines; a submission is rejected if any pattern matches (word-boundary or substring, case
-insensitive).

### Read / write with drush

```bash
drush cget protected_forms.settings
drush cset protected_forms.settings protected_forms.check_quantity 100 -y
```

```php
$c = \Drupal::configFactory()->getEditable('protected_forms.settings');
$pf = $c->get('protected_forms');
$pf['reject_patterns'] .= ", newspamword";
$pf['excluded_forms'][] = 'webform_contact';
$c->set('protected_forms', $pf)->save();
```

## Which forms are protected

`protected_forms_form_alter()` adds `_protected_forms_validate` to a form when ALL of:
- it is NOT an admin route and the form id does NOT contain `delete_form`;
- the form id is NOT in `excluded_forms`;
- the current user lacks `bypass protected forms validation`;
- the form id contains `user_`, `node_`, `comment_`, `contact_message_`, or `webform_`,
  OR equals `private_message_add_form`.

## What validation does

1. Concatenates submitted textfield/textarea values (and known webform composite fields).
2. Strips `allowed_patterns`, digits, punctuation, whitespace; samples up to `check_quantity`
   random characters and rejects if any character's Unicode range is not in an `allowed_scripts`
   range.
3. If the script check passed, scans the text for `reject_patterns`; rejects on the first match.
4. On rejection: sets a form error with `reject_message`, increments State
   `protected_forms.rejected`, and (if `log_rejected`) logs to the `protected forms` dblog channel.

## Runtime state

- `\Drupal::state()->get('protected_forms.rejected')` — running count of rejected submissions
  (shown on `/admin/reports/status`). This is State, not config.
