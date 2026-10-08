<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Travel Safety — configuration & operation

## Settings
`Drupal\travel_safety\Form\SettingsForm` at `/admin/config/people/travel-safety` (`administer travel safety module`). Keys (from `TravelSafetySettingKeys`): conference name, conference timezone, check-in grace window, notification/BCC addresses, retention days. The digest mail BCCs the configured addresses plus `system.site` mail.

## Permissions
- `access travel safety form` — use the `/travel-safety` form and the tokenized check-in/update/delete routes.
- `view travel safety submissions` (restricted) — see `/admin/people/travel-safety-submissions`.
- `administer travel safety module` (restricted) — settings.
- `delete travel safety submissions` (restricted) — delete any submission (submitters can always delete their own via token).

## Data flow
1. `TravelInformationForm` writes to `travel_safety_submissions` and generates four tokens with `Crypt::randomBytesBase64()` (accommodation, boarded, delete, update).
2. `hook_mail()` sends the traveler capability links (`UrlHelper::makeAtAccommodationUrl/makeBoardedUrl/makeUpdateUrl/makeDeleteUrl`).
3. Check-in: `TravelSafetyController::markAtAccommodation/markBoarded({token})` → `markSafe()` matches the token column and sets the safe flag.
4. `travel_safety_cron()` → `CronHelper`: retention deletion, then overdue-accommodation and overdue-boarding digest emails for records past arrival/departure + grace with no check-in.

## Extending
Alter outgoing mail with `hook_mail_alter()`; the message id is `travel_safety_<OverdueFor|SubmissionType value>` (e.g. `travel_safety_boarding`).
