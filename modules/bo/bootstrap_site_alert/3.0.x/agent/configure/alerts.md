# Configure alerts

One admin form drives everything: route `bootstrap_site_alert.admin` at
`/admin/config/system/bootstrap-site-alert`, permission `administer bootstrap site alerts`, built by
`\Drupal\bootstrap_site_alert\Form\BootstrapSiteAlertAdmin` (form id `bootstrap_site_alert_admin`).
All data is written to the **State API** (`\Drupal::state()`), i.e. the `key_value` table — there is
no config entity and no block.

## Two-step form

1. First save only asks for **Select Bootstrap Version** (`3` or `4`, required). Until
   `bootstrap_site_alert_version` is set in state, the alert fieldsets are hidden and the button reads
   "Save Bootstrap Version".
2. Once a version exists, the form shows one or more alert fieldsets plus AJAX buttons
   **Add Another Alert** (`::addOne`) and **Remove Last Alert** (`::removeCallback`), and the submit
   reads "Save Alert Message(s)". The chosen version decides the severity options (see below).

## Per-alert fields

Each fieldset `#i` (0-based) maps to state keys `bootstrap_site_alert_<field><i>`:

| Form field | State key | Type | Meaning |
|---|---|---|---|
| If Checked, Bootstrap Site Alert is Active. | `bootstrap_site_alert_active<i>` | checkbox | Master on/off for this alert. |
| Severity | `bootstrap_site_alert_severity<i>` | select (required) | Bootstrap CSS class, e.g. `alert-warning` (options depend on version). |
| Make this alert dismissable? | `bootstrap_site_alert_dismiss<i>` | checkbox | Adds a close button and the dismiss JS/cookie. |
| Hide this alert on admin pages? | `bootstrap_site_alert_no_admin<i>` | checkbox | Suppress on admin routes (`router.admin_context`). |
| Only Show On Certain Pages? | `bootstrap_site_alert_exclude<i>` | checkbox | Turn on path-based restriction. |
| Path(s) to show on | `bootstrap_site_alert_only_paths<i>` | textarea | One path per line, `*` wildcard, `<front>` token. Only shown when the checkbox above is ticked. |
| Negate for the listed pages? | `bootstrap_site_alert_negate<i>` | checkbox | Invert the match: show everywhere **except** the listed paths. |
| Alert Message | `bootstrap_site_alert_message<i>` | text_format (required) | WYSIWYG body, stored as `{value, format}` and rendered through that text format. |

Severity options by version:
- **Bootstrap 3**: `alert-success`, `alert-info`, `alert-warning`, `alert-danger`.
- **Bootstrap 4**: `alert-primary`, `alert-secondary`, `alert-success`, `alert-danger`, `alert-warning`, `alert-info`, `alert-light`, `alert-dark`.

Non-indexed state keys: `bootstrap_site_alert_version` (`3`|`4`), `bootstrap_site_alert_count` (how many
alerts to loop over when rendering), `bootstrap_site_alert_key` (random 16-char string).

## What submit does

`submitForm()`:
1. Deletes **every** `key_value` row named `bootstrap_site_alert%` (via `escapeLike` + `LIKE`) so stale
   per-alert keys from removed fieldsets do not linger.
2. Re-writes each fieldset value with `state->set($inner_key . $index, $value)` (that string
   concatenation is why keys end in the 0-based index).
3. Saves `bootstrap_site_alert_version` and `bootstrap_site_alert_count` (= number of fieldsets).
4. Regenerates `bootstrap_site_alert_key` with `(new Random())->string(16, TRUE)` — a fresh token that
   makes previously-dismissed visitors see edited alerts again (see hooks/page_top.md).
5. Invalidates the `rendered` cache tag so pages pick up the change immediately.

## Set it with PHP / Drush

```php
$state = \Drupal::state();
$state->set('bootstrap_site_alert_version', '4');
$state->set('bootstrap_site_alert_count', 1);

// Alert #0.
$state->set('bootstrap_site_alert_active0', 1);
$state->set('bootstrap_site_alert_severity0', 'alert-warning');
$state->set('bootstrap_site_alert_dismiss0', 1);
$state->set('bootstrap_site_alert_no_admin0', 1);
$state->set('bootstrap_site_alert_exclude0', 0);
$state->set('bootstrap_site_alert_only_paths0', '');
$state->set('bootstrap_site_alert_negate0', 0);
$state->set('bootstrap_site_alert_message0', [
  'value' => '<strong>Scheduled maintenance tonight 10pm–11pm.</strong>',
  'format' => 'basic_html',
]);

// Required for dismiss freshness (regenerate to re-show after edits).
$state->set('bootstrap_site_alert_key', (new \Drupal\Component\Utility\Random())->string(16, TRUE));

\Drupal\Core\Cache\Cache::invalidateTags(['rendered']);
```

Scalar keys can be set from the CLI, e.g. `drush state:set bootstrap_site_alert_active0 1`. The message
key holds an array, so set it from PHP (`drush php:eval`) rather than a plain `state:set`.

## Config schema (legacy)

`config/schema/bootstrap_site_alert.schema.yml` and `config/install/bootstrap_site_alert.settings.yml`
still declare a `bootstrap_site_alert.settings` object (`bootstrap_site_alert_active`, `_severity`,
`_dismiss`, `_message`, `_key`). This is vestigial: the module switched to the State API in 8.x-1.3, the
runtime never reads that config, and `hook_uninstall` / `bootstrap_site_alert_update_8102` delete it.
