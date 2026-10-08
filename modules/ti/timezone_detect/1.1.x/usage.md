Timezone detect automatically determines a logged-in user's timezone in the browser (via the bundled jsTimezoneDetect / `jstz` library) and saves it to their Drupal user account, so date/time output is shown in each user's real local timezone without them setting it manually.

---

The module attaches a small JS library on page load for authenticated users (gated by a session flag set in `hook_user_login()` and by the configured mode). `jstz.determine()` computes the browser timezone, and if it differs from the account's current value the JS POSTs it (with a CSRF token) to the AJAX route `timezone-detect/ajax/set-timezone`. The controller (`SetTimezoneController::updateTimezone`) validates the CSRF token, checks the value is a real IANA/Olson id (`timezone_identifiers_list()`), and saves it to the user entity's `timezone` field — optionally logging the change to the log/`watchdog` channel. A settings form at `/admin/config/regional/timezone_detect` (route `timezone_detect.admin`, permission *administer site configuration*) exposes two options: **mode** (`default` = only set on login when the user's timezone is empty [recommended]; `login` = overwrite on every login; `always` = update whenever it changes on any page) and a **watchdog** toggle for logging. A `hook_requirements()` check warns on the status report if the mode is `default` but the site's default user timezone is not configurable/empty (in which case new users already get a non-empty timezone and detection never runs). No permissions are defined by the module; the AJAX route only requires the user to be logged in. Depends only on Drupal core.

---

- Automatically set a new user's timezone on their first login so dates render locally.
- Keep dates, times and scheduling correct for a globally distributed user base.
- Avoid asking users to pick their timezone manually during registration.
- Overwrite a user's timezone on every login (`login` mode) for kiosk/shared machines.
- Continuously keep the timezone current as travelling users change locations (`always` mode).
- Show comment/post timestamps in each reader's own local time.
- Ensure event start/end times display correctly per user without manual configuration.
- Correct timezone for users who never touched their account settings.
- Log every automatic timezone change to watchdog for auditing, then disable logging later.
- Fix a site where the default user timezone was left empty and users see server time.
- Localize deadline/countdown displays to the visitor's actual timezone.
- Improve accuracy of "posted X hours ago" style relative dates per user.
- Detect timezone client-side without any third-party geolocation service or API key.
- Pair with core's empty default user timezone so detection is the source of truth.
- Provide consistent local-time rendering across a multilingual/multi-region site.
- Reduce support tickets about "wrong times" for authenticated users.
- Auto-populate the timezone select on the account edit form with the detected value.
- Only set the timezone when it is currently unset (recommended, least intrusive mode).
- Keep scheduling modules (that rely on user timezone) accurate automatically.
- Validate and store only genuine IANA timezone ids, ignoring invalid browser guesses.
