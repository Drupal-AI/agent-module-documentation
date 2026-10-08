<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cancel Button — configuration

## Settings form
`/admin/config/content/cancel-button` — route `cancel_button.admin_settings`, permission **`administer cancel button configuration`**.

Here you set, **per content type / entity bundle**, the fallback path the Cancel button uses when none of the higher-precedence signals apply (see precedence below). This matters mainly for *add* forms, where the entity has no canonical page to return to yet.

## Cancel destination precedence
When the button is clicked, the target is chosen in this order:

1. **Form redirect** — a redirect the form set internally via `FormState::setRedirect()` (common in submit handlers).
2. **`destination` parameter** — `?destination=/some/path` on the form URL (core sanitises this to internal paths).
3. **HTTP referer** — the page the user came from.
4. **Entity canonical page** — the entity's own view page (e.g. `/node/1`), if one is defined.
5. **Per-bundle fallback** — the path configured on the settings form for that content type.

## Notes
- The button is added to entity add/edit forms; enable the module and configure fallbacks per bundle.
- Because the `destination` parameter is handled by Drupal core's redirect subsystem, external URLs are stripped — the Cancel button cannot be turned into an open redirect.