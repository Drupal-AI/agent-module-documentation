<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "data stored about you" user page

Route `gdpr.collected_user_data` — path `/user/{user}/gdpr`, title "Data stored about you",
shown as the **All your data** tab on a user profile
(`gdpr.links.task.yml`, base route `entity.user.canonical`).

Controller: `Drupal\gdpr\Controller\UserController`.

## Access (`accessCollectedData`)

Custom access callback (`_custom_access`):
- Requires the permission **`view gdpr data summary`** — without it, forbidden (lets admins
  disable the page entirely).
- With `administer gdpr settings`, allowed for any user's page.
- Otherwise allowed only when viewing **your own** profile (`$user->id() === currentUser id`).

## Behaviour (`collectedData`)

- If neither `gdpr_tasks` nor `gdpr_consent` is enabled → renders a placeholder
  ("Data stored about you.").
- If `gdpr_tasks` is enabled → redirects to the view
  `view.gdpr_tasks_my_data_requests.page_1` for that user.
- Else (only `gdpr_consent`) → redirects to route `gdpr_consent.agreements` for that user.

So the base module only provides the entry point; the actual data listing comes from the
`gdpr_tasks` / `gdpr_consent` submodules. There are no services or hooks exposed for reuse
here — to change what is shown, enable/configure those submodules.
