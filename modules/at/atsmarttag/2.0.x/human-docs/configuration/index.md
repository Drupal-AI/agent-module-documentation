# Configuration

All of AT Internet SmartTag's behaviour is controlled from one form at
**Configuration → System → AT Internet SmartTag settings**
(`/admin/config/system/atsmarttag/settings`), reachable by users with the
**Administer AT Internet SmartTag** (`administer atsmarttag`) permission. The values
you save are rendered into the tracker's client‑side settings on every non‑admin
page.

## Loading the SmartTag library

Choose how the SmartTag JavaScript is loaded:

- **From a URL** — provide the SmartTag library URL and it is registered as an
  external header script.
- **From a file** — upload a managed SmartTag file and it is served locally with
  aggregation (preprocessing) enabled.

You can also name an **additional library** to attach alongside the tracker if your
setup needs one.

## Site id and collection domains

- **Site id** — the AT Internet `site` identifier that data is collected under.
- **Collection domain** and **SSL collection domain** — the endpoints AT Internet
  data is sent to.
- **Secure** — enable HTTPS collection.

## Cookies and privacy

These settings have privacy implications — review them against the rules that apply
to your visitors:

- **Disable cookie** — turn off analytics cookies for privacy compliance.
- **Cookie domain** — set a custom cookie domain if needed.
- **CNIL exempt** — mark the tag as CNIL‑exempt where that applies (a French data
  protection consideration).

If you need full opt‑in consent gating, see the companion **AT Internet SmartTag for
TacJS** (`atsmarttag_tacjs`) module, which registers this tracker as a
consent‑managed service in the TacJS consent manager.

## Page naming

Choose what name is reported for each page view:

- **Path alias** — use the current URL alias as the page name.
- Otherwise the **resolved page title** is used.

Optionally enable **chapters from breadcrumb**: when on, up to three page
"chapters" are derived from the breadcrumb trail (the home crumb and empty‑URL
crumbs are skipped).

## Click tracking

Toggle what kinds of clicks are tracked:

- **Files** — track file downloads by extension. A large default list of tracked
  extensions is provided; you can customise the tracked‑extension list.
- **Mailto** — track clicks on `mailto:` links.
- **Outbound** — track clicks on links leaving your site.

## Extending the payload

Developers can implement `hook_atsmarttag_settings_alter(array &$settings)` in a
custom module to add or override any value in the emitted analytics payload before
it is sent to the browser.

## Save

Click **Save configuration**. The tracker and its settings are attached to all
non‑admin pages from then on; admin routes are never tracked.
