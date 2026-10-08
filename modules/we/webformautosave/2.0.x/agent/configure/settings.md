<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Webform Autosave

No dedicated admin route (`configure` is null). Autosave is switched on through **Webform third-party
settings**, either per-webform or globally.

## Settings

Schema `webform.third_party.webformautosave.schema.yml` (two identical mappings — one for a webform,
one for global `webform.settings`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `auto_save` | boolean | off | Automatically save the submission as a draft when an input changes. |
| `auto_save_time` | integer (ms) | 5000 | Debounce before an autosave fires. Raise it if optimistic locking is on. |
| `optimistic_locking` | boolean | off | Warn when another user/session changed the same submission. |

## Enable per webform (UI)

Edit the webform → **Settings → General** → *Webform auto-save settings* section
(`hook_webform_third_party_settings_form_alter`). Tick *Automatically save…*, set the wait time, and
optionally *Use an optimistic locking strategy…*.

## Enable via Drush / config

```bash
# Per webform (replace CONTACT with the webform id):
ddev drush php:eval '$w=\Drupal\webform\Entity\Webform::load("contact");
$w->setThirdPartySetting("webformautosave","auto_save",TRUE);
$w->setThirdPartySetting("webformautosave","auto_save_time",8000);
$w->setThirdPartySetting("webformautosave","optimistic_locking",TRUE);
$w->save();'
```

## Side effects on save (`webformautosave_webform_presave`)

When `auto_save` or `optimistic_locking` is enabled, the webform's own settings are auto-adjusted:
- Drafts enabled if currently `DRAFT_NONE` → `DRAFT_ALL`.
- Purge set to include drafts (`PURGE_DRAFT`, or `PURGE_ALL` if it was `PURGE_COMPLETED`); `purge_days`
  defaulted to 182 if unset.
- For optimistic locking, `submission_log` is turned on (needed to read change timestamps).

So enabling autosave will change a webform's draft/purge/log configuration — expect those to flip on.
