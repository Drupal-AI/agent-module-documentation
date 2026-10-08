# Configuration

Before you configure Drupal, make sure your **Cookie Information account** has a
consent template set up on their platform (go.cookieinformation.com) — that's where
the banner content, cookie declaration, and templates actually live. The Drupal
settings below control *how* and *where* that platform's popup and scripts load on
your site.

## Open the settings form

1. Log in as a user with the **Administer cookie information settings** permission.
2. Go to **Configuration → System → Cookie Information**, or navigate directly to
   `/admin/config/system/cookie-information`. Values are saved to the
   `cookieinformation.settings` config object.

## The settings, field by field

| Setting | What it does |
|---|---|
| **Enable consent popup** | The master switch. The consent script only loads when this is on. Leave everything else configured but flip this to turn the banner on/off. |
| **Enable IAB** | Turns on IAB TCF v2.2 support, for ad-tech vendors that require the framework. Needs the matching IAB template configured on the Cookie Information platform. |
| **Google Consent Mode** | Choose *disabled*, *v1*, or *v2*. When set, the module injects Google's consent-mode init script early in the page so Google tags respect the visitor's consent choices. Use **v2** (advanced mode) for current Google requirements; **v1** is for legacy analytics signalling. v2 also needs the matching template on the platform. |
| **Block iframes** | Turns on client-side blocking of third-party iframes until the visitor consents. Requires the *Iframe blocking category* below. |
| **Iframe blocking category** | Which cookie category (*functional*, *marketing*, or *statistic*) a blocked iframe waits for. The iframe only loads after the visitor accepts that category. A placeholder over the blocked iframe lets the user open the banner to unblock it. |
| **Exclude paths** | A newline-separated list of paths where the popup should *not* show. Supports `*` wildcards and `<front>`, and matches both the internal path and its alias. |
| **Exclude admin pages** | When on, the popup is suppressed on admin routes so editors aren't interrupted. |
| **Don't show for UID 1** | When on, the superuser (user 1) never sees the popup. |

The popup shows only when all the visibility checks pass: the popup is enabled, the
current user isn't a staff account holding the "disable consent" permission (below),
the UID-1 rule allows it, the admin-route rule allows it, and the current path isn't
excluded.

### Language

You don't configure language manually — the module automatically loads the popup in
the site's current interface language, mapped to Cookie Information's supported list
(for example Norwegian `no`/`nn` is mapped to `nb`), and falls back to English when
the language isn't supported.

## The two blocks

Place these at **Structure → Block layout** (category "Cookieinformation"):

- **Cookie Policy block** — renders the platform's cookie-declaration table. Put it on
  a dedicated "Cookie policy" page.
- **Privacy Controls block** — renders the platform's re-consent controls so visitors
  can reopen and change their choices. A footer is a common place for it.

Both blocks respect the same visibility rules as the popup (enabled state, excluded
paths, admin/UID-1 exclusions, and the disable-consent permission).

## Permissions

At **People → Permissions**:

- **Administer cookie information settings** — who can reach and change this settings
  form. Restrict to trusted admins.
- **Disable cookie information consent** — any non-superuser role holding this
  permission is served pages **without** the consent popup. Handy for staff or testing
  roles, but don't grant it to normal visitors.

## Save and test

After saving, view the site as an anonymous visitor and confirm the consent popup
appears. If you enabled iframe blocking, embed a third-party iframe on a page and check
that it stays blocked until you accept the chosen category. Remember that IAB and
Google Consent Mode v2 also depend on the matching template being configured on your
Cookie Information account.

## Setting values with Drush

```bash
ddev drush cset cookieinformation.settings enable_popup 1 -y
ddev drush cset cookieinformation.settings google_consent_mode v2 -y
ddev drush cset cookieinformation.settings block_iframes 1 -y
ddev drush cset cookieinformation.settings block_iframes_category functional -y
```
