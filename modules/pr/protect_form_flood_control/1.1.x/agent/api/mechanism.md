<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How it works (mechanism)

`hook_form_alter()` delegates to `protect_form_flood_control.manager` → `Manager::alterForm()`:

1. Optionally prints the form ID (debug `show_ids`), and adds cache tags/contexts
   (`user.permissions`, `ip`, the config's cache tags) so protection decisions vary correctly.
2. Returns early if the client should bypass (whitelisted IP via path matcher, or the
   `bypass protect form flood control` permission).
3. If `formIsProtected($form_state, $form_id)` is true, attaches a hidden element with the
   `#element_validate` callback `_protect_form_flood_control_validate_element` (a validate callback
   must be a function, hence the procedural wrapper in `.module`).

At validation time `_protect_form_flood_control_validate_element()`:

- resolves the effective `window`/`threshold` via `Manager::getFormConfiguration()` (per-form
  override or general default),
- truncates the form ID to fit the flood `event` column (>= 64 chars → first 30 chars + `_` + md5),
- calls the core **`flood`** service: `isAllowed($event, $threshold, $window)`. If **not** allowed
  it sets a form error ("You cannot submit the form more than @threshold times in @window…") and,
  when `general.log` is on, logs the blocked submission; otherwise it `register($event, $window)`s
  the attempt.

## `formIsProtected` decision order

1. `false` for the module's own settings form and for system forms (`system_*`, `search_*`,
   `views_exposed_form_*`).
2. If `protect_all`: protected unless the form matches `general.unprotected_ids`.
3. Else: protected if the form (or its base form ID) matches `general.protected_ids`, or matches the
   `ids` of any entry in `forms`.

Pattern matching uses `path.matcher` against both the form ID and the base form ID, so `*` wildcards
work.

## Notable services / state

- Flood counts are stored by core's flood backend keyed on the (truncated) form ID and the client
  IP — there is no module table. Clearing them is a core concern (`flood` service / `flood` table).
- The manager exposes helpers (`getWindow`, `getThreshold`, `getProtectedFormIds`,
  `getFormConfiguration`, `getFlood`, `truncateFormId`, …) but there is no public hook/event to
  extend; customization is via the config object.
