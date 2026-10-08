# Configuration

All of Piwik PRO's settings live on one form. Open it at **Configuration →
System → Piwik PRO** (`/admin/config/services/piwik-pro`), or navigate there
directly. You need the **Administer Piwik PRO** permission, which is restricted
to trusted administrators because it controls what tracking code runs across the
whole site.

Settings are saved to the `piwik_pro.settings` configuration object, so they can
be exported and deployed like any other Drupal config.

## Account identifiers

These are the two values that connect Drupal to your Piwik PRO account. Find
them in your Piwik PRO administration panel.

- **Account ID** (`site_id`) — the ID of your Piwik PRO container. It is
  embedded directly in the page HTML, so it is a **public** identifier, not a
  secret — do not treat it like an API key.
- **Tracking domain** (`piwik_domain`) — the domain the container JavaScript is
  loaded from (your organization's Piwik PRO address). Also public.
- **Data layer** (`data_layer`) — the name of the JavaScript data‑layer variable
  the tag manager uses. The default is `dataLayer`; only change it if your Piwik
  PRO tag‑manager setup expects a different name.

The tracking snippet is only added to a page when **all three** of these values
are filled in *and* the visibility rules below pass.

## Visibility — where the snippet loads

There are three independent rules. The snippet appears on a page only if it
passes **all three** at once. Each rule has a *mode* that you can flip between
"everything except the ones I list" and "only the ones I list."

### Pages

- **Every page except the listed pages** *(default)* — track the whole site
  apart from the paths you enter.
- **Only the listed pages** — track *nothing* except the paths you enter.

Enter one path per line in the text box. By default the excluded list already
covers admin pages, the batch page, node‑add pages, and user account subpages
(`/admin`, `/admin/*`, `/batch`, `/node/add*`, `/node/*/*`, `/user/*/*`). Path
matching runs against the page's path alias.

### Roles

- **Every role except the selected roles** *(default)* — track everyone except
  the checked roles.
- **Only the selected roles** — track only the checked roles.

A common use: check the administrator and editor roles with the "every role
except" mode to stop tracking your own staff. Or select just *anonymous* with
the "only" mode to track only logged‑out visitors.

### Content types

- **Every content type except the selected ones** *(default)*.
- **Only the selected content types** — for example, track only *Article* pages.

## Cookie and privacy options

- **Use secure cookies** (`use_secure_cookies`, off by default) — adds the
  `secure` flag to the tracker's cookies so they are only sent over HTTPS. Turn
  this on for HTTPS sites.
- **SameSite=Strict** (`same_site_strict`, off by default) — adds
  `SameSite=Strict` to the tracker cookies for a stricter privacy/CSRF posture.
- **Disable tracking** (`disable_tracking`, off by default) — a master off
  switch. Turn it on to suppress the snippet everywhere without changing any of
  your other settings — handy during maintenance.
- **Load from library** (`piwik_pro_load_from_library`, off by default) — loads
  the snippet from a library variant instead of inline. Leave off unless you
  have a specific reason to change it.

## Content‑Security‑Policy nonce

- **Enable CSP nonce** (`csp_nonce_enabled`, off by default) — when your site
  runs a Content‑Security‑Policy (via the **CSP** module) that blocks inline
  scripts, turn this on so the snippet is served with a matching `nonce`
  attribute and is allowed to run. The module also adjusts the policy
  automatically to permit the Piwik PRO domain. This option has no effect unless
  the CSP module is installed.

## Save

Click **Save configuration**. Tracking takes effect immediately — load a
front‑end page that passes your visibility rules and the Piwik PRO snippet will
be present in the page source.
