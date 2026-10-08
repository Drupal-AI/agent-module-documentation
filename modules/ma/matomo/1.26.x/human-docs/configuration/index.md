# Configuration

## Open the settings form

1. Log in as a user with the **Administer Matomo** permission.
2. Go to **Configuration → System → Matomo**, or navigate directly to
   `/admin/config/system/matomo`.

All settings are stored in the `matomo.settings` config object, so they export
with `drush config:export` and deploy identically across environments.

## Server (required)

Enter the details of your Matomo instance:

- **Matomo site ID** — the numeric ID of the site as it appears in Matomo.
- **Matomo server URL** (HTTP and HTTPS) — the address of your self-hosted Matomo
  or Matomo Cloud instance.

Tracking does not start until these are filled in.

## Page visibility — where tracking appears

- **Pages (request path)** — an allow or deny list of paths. The default excludes
  administrative and system paths (`/admin`, `/admin/*`, `/batch`, `/node/add*`,
  `/node/*/*`, `/user/*/*`), so you are not tracking editors as they work. Switch
  to an allow list to track only specific sections.
- **Roles** — track, or skip, specific user roles (for example exclude
  administrators and editors).
- **Users** — let individual users opt in or out of tracking from their own
  account, gated by a permission.

## Tracking — what gets recorded

Turn on the events you care about:

- **Mailto links** — record clicks on `mailto:` links.
- **Downloads** — track file downloads, limited to the file **extensions** you
  list (pdf, zip, docx, …).
- **Colorbox** — track interactions in Colorbox lightboxes.
- **User ID** — send a hashed user ID for logged-in users so their sessions are
  unified.
- **Site search** — track on-site search queries and result counts.
- **Messages** — track Drupal status/warning/error messages.

## Privacy

- **Do Not Track** — honor the visitor's browser Do Not Track signal and skip
  tracking them.
- **Disable cookies** — cookie-less tracking for stricter privacy compliance.

## Custom variables

Add **custom variables / dimensions** that are sent on every tracked hit — useful
for segmenting by values specific to your site. Tokens are supported here.

## Code snippet

Inject raw JavaScript **before** or **after** the generated tracker for advanced
setups. Because this is arbitrary code, it is gated by the **Add JS snippets for
Matomo** permission — reserve it for trusted administrators.

## Advanced

- **Page title hierarchy** — send a structured page title so Matomo groups pages
  by their place in the site.
- **Disable tracking** — a master switch to turn the snippet off without changing
  the rest of your configuration.
- **Cache matomo.js locally** — store the tracker file on your own server and
  refresh it on cron, avoiding a request to the Matomo host on every page.

## Save

Click **Save configuration**. The tracking snippet is emitted on matching pages
immediately.
