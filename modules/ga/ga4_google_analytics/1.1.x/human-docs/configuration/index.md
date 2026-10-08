# Configuration

All of GA4 Google Analytics is configured on one settings form. This page covers each
field, the cookie-consent option, and the permission that controls access.

## Open the settings form

1. Log in as a user with the **GA4 Google Analytics Settings** permission.
2. Go to **Configuration → Web services → GA4 Google Analytics**, or navigate
   directly to `/admin/config/services/ga4-google-analytics`.

Everything you save here is stored in the `ga4_google_analytics.config` object. Until
you save the form at least once, that object does not exist and no tracking happens.

## Measurement ID

This is the only required field. Enter your GA4 property's **Measurement ID** — the
`G-XXXXXXXXXX` value from the Google Analytics admin. When it is filled in, the
`gtag.js` snippet is injected into every page that passes the role and page checks
below. If you leave it empty, tracking is completely off — clearing this field is the
quickest way to disable tracking site-wide. The value is sanitized before it is
written into the page.

## Roles

A checkbox list of the site's roles. A visitor is tracked only if they hold **at least
one** of the roles you select here. If you select **no roles**, the check passes for
everyone — which is the usual "track all visitors" setup. Use this to, for example,
track only a "customer" role, or to avoid tracking logged-in staff.

## Pages

This controls which paths are tracked, using Drupal core's request-path condition. It
has two parts:

- **A list of paths** — one per line. You can use the `*` wildcard (e.g. `/admin/*`)
  and `<front>` for the front page.
- **A negate choice** — whether the list means *"track only these pages"* or *"track
  every page except these"*.

Two common setups:

- **Exclude admin and account pages** — list `/admin/*` and `/user/*` and choose the
  *everywhere except the listed pages* option. This is the typical way to keep
  analytics off back-end screens.
- **Track a marketing section only** — list `/campaign/*` (or `<front>`) and choose
  the *only the listed pages* option.

## Scripts Custom Attributes

A free-text field for adding extra attributes to the injected `<script>` tags. It is
strictly validated: only `async`, `type="…"`, `data-*="…"`, and
`crossorigin="anonymous"` are accepted, and unsafe values (such as `javascript:` or
`data:text/html`) are rejected. Its primary use is deferring analytics until cookie
consent, though you can also use it to add, for example, `crossorigin="anonymous"` for
stricter CORS handling. Leave it blank if you do not need it.

## Cookie-consent (Klaro) integration

To let a consent manager such as Klaro hold the GA script back until the visitor
consents, put the consent tool's expected attributes in **Scripts Custom
Attributes**. A typical Klaro value is:

```
type="text/plain" data-type="application/javascript" data-name="ga"
```

where `data-name` matches the Klaro service machine name you configured for Google
Analytics. Klaro then activates the script only after consent, helping you meet GDPR
requirements.

## Saving and deploying

The form validates your input before saving. Because all settings live in the single
`ga4_google_analytics.config` object, you can export and deploy them like any other
configuration — useful for rolling the same GA4 setup across a multisite. To read or
set values from the command line:

```bash
drush cget ga4_google_analytics.config
drush cset ga4_google_analytics.config measurement_id 'G-ABCDE12345' -y
```

(The nested role and page settings are easiest to set with `drush php:eval` — see the
[`agent/`](../agent/start.md) docs for an example.)

## Permission

Grant at **People → Permissions**:

- **GA4 Google Analytics Settings** — access to this settings form. Because editing it
  exposes site-wide tracking markup, it is a restricted permission; grant it only to
  trusted roles.

The permission's internal machine name is the misspelled `ga4 configre`, which matters
only when assigning it via config or `drush role:perm:add content_editor 'ga4 configre'`.
There are no other permissions and no per-entity access checks.
