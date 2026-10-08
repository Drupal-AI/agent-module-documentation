# Configuration

Page Load Progress has one settings form plus two permissions. Even with the module enabled,
the throbber only loads for users who have the **Use page load progress** permission — so start
there.

## Permissions

Grant these at **People → Permissions** (`/admin/people/permissions`):

- **Administer page load progress** — access the settings form below.
- **Use page load progress** — controls whether the throbber assets load for a given user.
  Grant it to any role (including *Anonymous user*) that should see the loading overlay. Neither
  permission grants access to data — this one only decides whether a purely cosmetic overlay
  loads.

## Open the settings form

Go to **Configuration → User interface → Page Load Progress**, or navigate directly to
`/admin/config/user-interface/page-load-progress`. You need the *Administer page load progress*
permission.

## Settings, field by field

- **Time to wait (delay)** — how long after the action before the lock overlay appears. Choose
  **immediate** (10 ms), **1 second**, **3 seconds**, or **5 seconds**. A short delay means the
  throbber only shows up on genuinely slow operations, not instant ones.
- **Pages (path conditions)** — a list of path patterns, one per line. You may use wildcards
  (`*`) and `<front>`. Leave it empty to apply everywhere.
- **Negate the condition** — pairs with the path list:
  - *Show only on the listed pages* — the throbber runs **only** on paths in the list.
  - *Hide on the listed pages* — the throbber runs **everywhere except** the listed paths.
    (This is the default behavior when the negate condition is on.)
- **Internal links** — when enabled, the overlay also locks the screen when a visitor clicks an
  internal link (external links, AJAX/`use-ajax`, toolbar, modal, and new‑tab links are skipped
  automatically). Off by default; the module triggers on form submits regardless.
- **Allow Esc key** *(default: on)* — let users press **Esc** to dismiss the overlay if a
  request hangs.

## Save

Click **Save configuration**. Changes take effect on the next page load.

## Good to know

- **Standard forms are covered automatically.** The module tags non‑AJAX submit buttons so the
  lock triggers on form submit without any per‑form setup. (Advanced: the trigger selector
  defaults to `.page-load-progress-submit`; add that class to a custom element to trigger the
  lock on it. This selector isn't exposed in the form UI.)
- **The Views admin UI is always excluded** so it stays usable, regardless of your path
  settings.
- **Styling** comes from `css/page_load_progress.theme.css`; override it in your theme to
  restyle the overlay/throbber.
