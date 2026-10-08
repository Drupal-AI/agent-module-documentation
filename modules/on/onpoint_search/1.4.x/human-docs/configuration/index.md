# Configuration

OnPoint Search needs one thing to connect: your **OnPoint API key**. Everything
else — crawling, relevance tuning, analytics, blacklists/whitelists — is managed
in the OnPoint dashboard rather than in Drupal.

## Open the settings form

1. Log in as a user with permission to administer the site's configuration.
2. Open the settings form from the **Extend** page (**Configure** next to *OnPoint
   Search*) or the **Configuration** section of the admin menu. It is registered
   as `onpoint_search.settings`.

## Enter your API key

- **API key** — the key from your OnPoint account (find it in the OnPoint
  dashboard at [search.onpointsuite.com](https://search.onpointsuite.com/)). This
  key authenticates your Drupal site to the OnPoint service, so it is a
  **credential**: do not commit it to version control or export it into
  `config/sync`.

### Store the key securely

Keep the API key in an environment variable and reference it from Drupal rather
than pasting it into exported configuration. With DDEV:

```bash
ddev dotenv set .ddev/.env --onpoint-api-key=<your-key>
ddev restart
```

That makes the value available inside the container as `ONPOINT_API_KEY` (and
keeps `.ddev/.env` out of Git). Confirm it is present without printing it:

```bash
ddev exec 'test -n "$ONPOINT_API_KEY"'   # exit status 0 means it is set
```

Then feed the value into the module's API‑key setting from the environment (for
example via `getenv('ONPOINT_API_KEY')` in `settings.php`, or a Key entity) so the
secret never lands in committed configuration.

## What leaves your site

Because OnPoint is a hosted service, be aware that:

- **Search queries** typed by your visitors are sent to OnPoint to be answered.
- **Your content** is crawled and indexed on OnPoint's platform.

That is the normal SaaS trade‑off — no local search infrastructure in exchange for
sending queries and content to a third party. Make sure that fits your site's
privacy and data‑handling requirements before going live.

## Save

Save the form. Once the key is stored and OnPoint has crawled your site, run a
search to confirm results are returned. Manage crawl schedules, result tuning, and
analytics from the OnPoint dashboard.
