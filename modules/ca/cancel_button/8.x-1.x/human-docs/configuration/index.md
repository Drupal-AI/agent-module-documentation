# Configuration

The Cancel button appears on entity forms as soon as the module is enabled. The
settings form exists to set one thing: the **fallback destination per content type
/ entity bundle** — where Cancel should land when none of the higher‑precedence
signals apply.

## Open the settings form

1. Log in as a user with the **Administer cancel button configuration**
   (`administer cancel button configuration`) permission.
2. Go to **Configuration → Content authoring → Cancel Button**, or navigate directly
   to `/admin/config/content/cancel-button` (route `cancel_button.admin_settings`).

## Set the per‑bundle fallbacks

For each content type / bundle, set the path the Cancel button uses as a last
resort. This matters most on **add** forms, where the entity doesn't exist yet and so
has no canonical page to return to. For example, you might send article cancels to
the content admin listing and page cancels somewhere else.

## How the target is chosen

When the button is clicked, the destination is resolved in this order — the fallback
you set here is only used if the earlier options don't apply:

1. **Form redirect** — a redirect the form set internally via
   `FormState::setRedirect()` (common in submit handlers).
2. **`destination` parameter** — `?destination=/some/path` on the form URL. Core
   sanitises this to internal paths.
3. **HTTP referer** — the page the user came from.
4. **Entity canonical page** — the entity's own view page (e.g. `/node/1`), if it has
   one.
5. **Per‑bundle fallback** — the path you configured above for that content type.

## A note on safety

Because the `destination` parameter is handled by Drupal core's redirect subsystem,
external URLs are stripped out — the Cancel button cannot be turned into an open
redirect.
