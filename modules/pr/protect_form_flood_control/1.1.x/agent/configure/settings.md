<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Protect Form Flood Control

Single config object **`protect_form_flood_control.settings`**. Settings form at
`/admin/config/user-interface/protect-form-flood-control` (route
`protect_form_flood_control.settings`, permission `administer protect form flood control`).

## Config structure (shipped defaults)

```yaml
general:
  protect_all: false        # protect every form (minus system forms + the unprotected list)
  window: 86400             # default flood window, seconds
  threshold: 50             # default max submissions per window
  protected_ids: {}         # form-ID patterns to protect (used when protect_all is false)
  unprotected_ids: {}       # form-ID patterns to exclude (used when protect_all is true)
  whitelist:
    - 127.0.0.1             # client IPs that bypass protection
  log: false                # log blocked submissions to the module's logger channel
forms: {}                   # per-form overrides: list of { ids: [...], window, threshold }
show_ids: false             # print each form's ID to privileged users (debug aid)
```

## Two protection modes

- **protect_all = true** — every form is protected except `system_*` / `search_*` /
  `views_exposed_form_*` (always exempt), the settings form, and anything matching
  `general.unprotected_ids`.
- **protect_all = false** (default) — a form is protected only if its form ID or **base form ID**
  matches `general.protected_ids`, or matches the `ids` of an entry in `forms`.

Matching uses the **path matcher**, so form-ID patterns accept `*` wildcards (e.g.
`webform_submission_*`, `user_*`). Both the concrete form ID and its base form ID are tested.

## Per-form window/threshold overrides

`forms` is a list; each entry sets its own limit for a set of IDs:

```yaml
forms:
  - ids:
      - user_register_form
    window: 3600
    threshold: 3
```

When a protected form matches a `forms` entry, that entry's `window`/`threshold` apply (falling
back to `general.window`/`general.threshold` when an override is empty).

## Drush / scripting

```bash
drush cget protect_form_flood_control.settings
drush cset protect_form_flood_control.settings general.protect_all 1 -y
drush cset protect_form_flood_control.settings general.threshold 5 -y
drush cset protect_form_flood_control.settings general.window 3600 -y
```

Add protected IDs (sequence) in PHP:

```php
\Drupal::configFactory()->getEditable('protect_form_flood_control.settings')
  ->set('general.protected_ids', ['contact_message_feedback_form'])
  ->save();
```

## Bypass and debug

- `whitelist` IPs and the `bypass protect form flood control` permission skip protection entirely.
- `show_ids: true` + the `view protect form flood control form ids` (or admin) permission shows a
  status message with each form's ID and base form ID — use it to discover IDs to protect.

## Permissions

- `administer protect form flood control` — reach the settings form.
- `bypass protect form flood control` — never be flood-limited.
- `view protect form flood control form ids` — see the debug form-ID messages.
