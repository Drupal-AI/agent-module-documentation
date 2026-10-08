# Configure Protect Views Flood Control

No settings page of its own. Configuration is **per View display**: edit a View → *Advanced* panel →
**Flood control** section → "Flood control & Maximum filters at once".

## Options (display extender; schema `views.display_extender.protect_views_flood_control`)

| Option key | Type | Default | Meaning |
|---|---|---|---|
| `enable_protect_views_flood_control` | bool | off | Turn on flood throttling for this display's exposed form. |
| `protect_views_flood_control_window` | int | `30` | Time window in seconds (form `#min` 10). |
| `protect_views_flood_control_threshold` | int | `5` | Allowed submissions per window (`#min` 1). |
| `enable_flood_control_by_range` | bool | off | Group by IP subnet (IPv4 /24, IPv6 /48) instead of exact IP. **See caveat below.** |
| `enable_protect_views_exposed_form_max_filters` | bool | off | Turn on the max-filters/options cap. |
| `protect_views_exposed_form_max_filters_count` | int | `3` | Max number of active filters at once (0/blank = no limit). |
| `protect_views_exposed_form_max_options_per_filter_count` | int | `3` | Max options within a single array-valued filter (0/blank = no limit). |

Stored inside the View's display `display_options` under the extender. IP whitelist and blocked-submission
logging are **not** here — they live in the parent `protect_form_flood_control` settings page
(`protect_form_flood_control.settings`), linked from the section.

## How enforcement works (`src/Hook/ProtectViewsFloodControl.php`)

- `formViewsExposedFormAlter()` appends a **static** validate handler `exposedValidate()` (static so it
  survives the form cache).
- `exposedValidate()` finds the display's `protect_views_flood_control` extender, reads its `options`, and
  runs flood protection and/or max-filters if their `shouldHandle*` guards pass.
- **Flood guard** (`shouldHandleFloodProtection`): only if enabled AND the request has non-empty exposed
  input (values that are empty or `'All'` are filtered out). So a bare page load never counts.
- **Flood enforcement** (`handleFloodProtection`): key = `views_exposed:<view id>:<current_display>`, passed
  through `manager->truncateFormId()`. If `manager->getFlood()->isAllowed($key, $threshold, $window, $id)`
  is false:
  - AJAX request → `$form_state->setError($form, "You cannot submit the filters more than N times in T…")`
    and (if `manager->shouldLogBlockedSubmissions()`) logs via `logBlockedSubmission()`.
  - Non-AJAX → `throw new TooManyRequestsHttpException($window, …, headers: ['X-RateLimit-Limit' => threshold])`
    → HTTP **429** with `Retry-After: <window>`.
  - Otherwise (allowed) → `getFlood()->register($key, $window, $id)` records the hit.
- **Max-filters** (`handleMaxFilters`): counts active exposed filters (ignoring internal keys like
  `op`, `js`, `live_preview`, `views_ajax_history`, …). If more than `max_filters` → global form error.
  Then for each array-valued filter with more than `max_options` selected → error on that element
  (or a global fallback error).
- IP subnet identifier (`getIpSubnetIdentifier`): `inet_pton` on the client IP, then first 6 bytes (IPv6
  /48, prefixed `ipv6-subnet-48-`) or 3 bytes (IPv4 /24, `ipv4-subnet-24-`); falls back to the raw IP.

## Caveat (implementation note, not a vulnerability)

The subnet option is saved under `enable_flood_control_by_range` (schema + form + `submitOptionsForm`),
but `handleFloodProtection()` reads `$options['protect_views_flood_control_block_range']` to decide whether
to pass a subnet identifier. Those keys differ, so in this release enabling "Protect by IP range" may not
actually switch the flood identifier to the subnet — throttling stays per exact IP. Verify against the
running version before relying on subnet grouping.
