<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# COOKiES service + anonymize behavior

How `cookies_msdynamics365marketing` registers itself with COOKiES and drives Dynamics 365's
`Anonymize` flag. Source: `config/install/cookies.cookies_service.msdynamics365marketing.yml`,
`cookies_msdynamics365marketing.module`, `cookies_msdynamics365marketing.libraries.yml`,
`js/anonymize.js`.

## Install / enable

- `ddev drush en cookies_msdynamics365marketing -y` (COOKiES `cookies` is a hard dependency and is
  pulled in). No settings form is provided by this module — `configure` is null.
- On install, the `cookies_service` config entity below is imported. Nothing else needs configuring;
  the service then shows up in the COOKiES banner.

## The COOKiES service entity

File `config/install/cookies.cookies_service.msdynamics365marketing.yml` creates a
`cookies.cookies_service.*` config object (the entity type is defined by the parent COOKiES module):

- `id: msdynamics365marketing`, `label: 'MS Dynamics 365 Marketing'`
- `group: tracking` — places the toggle under the banner's tracking category
- `consent: true` — a consent-requiring (non-essential) service
- `url: 'https://www.microsoft.com/trustcenter'` — the info link shown to visitors
- `info.format: full_html`, `info.value:` a static `<table>` describing the four Dynamics 365
  cookies (`79f08280-…`, `319af4c0-…`, `msd365mkttr`, `msd365mkttrs`)
- `dependencies.enforced.module: [cookies_msdynamics365marketing]` — removed with the module

All values are shipped by the module and are admin-facing config (editable through the COOKiES
service UI); the config **schema** for this entity lives in the parent COOKiES module, so this
module reports `provides_config_schema: false`. The `msdynamics365marketing` id here must match the
`id` in `js/anonymize.js` — that is the key the JS looks up in the consent event.

## Page attachment

`cookies_msdynamics365marketing_page_attachments(&$page)` unconditionally adds
`$page['#attached']['library'][] = 'cookies_msdynamics365marketing/anonymize';` on every page, so
the consent behavior is always present. (A commented-out block hints at a future
`CookiesKnockOutService` knock-out flow for when the Dynamics scripts are added via a library — not
active in this release.) Library `anonymize` (`cookies_msdynamics365marketing.libraries.yml`) is
just `js/anonymize.js` with no dependencies.

## The consent behavior (`js/anonymize.js`)

`Drupal.behaviors.cookies_msdynamics365marketing_anonymize`, `id: "msdynamics365marketing"`:

- `attach(context)` — registers a `document` listener for the COOKiES `cookiesjsrUserConsent`
  event. It reads `event.detail.services` (defaulting to `{}` if not an object) and, if
  `services["msdynamics365marketing"]` is truthy, calls `activate()`; otherwise `fallback()`.
- `activate(context)` — consent granted: sets global
  `window.d365mktConfigureTracking = () => ({ Anonymize: false })` and, if `window.MsCrmMkt` is
  loaded, calls `window.MsCrmMkt.reconfigureTracking({ Anonymize: false })` to un-anonymize live.
- `fallback(context)` — consent denied/revoked (and the pre-consent default): same two calls with
  `{ Anonymize: true }`.

`d365mktConfigureTracking()` is the global that Dynamics 365 Marketing forms read at load time;
`MsCrmMkt.reconfigureTracking()` reconfigures an already-running Dynamics tracker when the visitor
changes their choice. The behavior only reads the boolean consent state from the COOKiES event and
sets a boolean flag — it renders no markup and injects no admin/remote data into the page.

## Operating & testing

- Enable and configure the COOKiES banner, keep this module enabled, and embed your Dynamics 365
  Marketing forms as usual.
- Verify in the browser console: call `d365mktConfigureTracking()` with and without consent — it
  should return `{Anonymize: true}` before consent and `{Anonymize: false}` after. If the function
  is undefined, the attachment/behavior is not loading.
- `hook_help()` (route `help.page.cookies_msdynamics365marketing`) links to Microsoft's guidance:
  "How to disable non-essential Dynamics 365 Marketing cookies".
