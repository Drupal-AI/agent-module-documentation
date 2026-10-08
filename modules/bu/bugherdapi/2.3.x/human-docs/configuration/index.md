# Configuration

## Open the settings form

1. Log in as a user with the **administer bugherd** permission.
2. Go to **Configuration → System → BugHerd**, or navigate directly to
   `/admin/config/system/bugherd`.

Here you connect the site to your BugHerd project (using the project key from
your BugHerd account) and configure which pages carry the overlay.

### The project key

The key that ties the overlay to your BugHerd project is rendered into the
page's client-side JavaScript, so it is not a true server secret. Still, keep it
out of configuration you commit to public version control: on DDEV hold it in an
environment variable (`ddev dotenv set .ddev/.env --bugherd-api-key=<value>`
then `ddev restart`, never committing `.ddev/.env`) and feed it into the
module's config via a settings.php override using `getenv('BUGHERD_API_KEY')`.

## Decide who sees the overlay — before you enable it

This is the deployment decision that matters most:

- Loaded for everyone, the overlay shows a floating widget to real visitors and
  puts a third-party script on every page.
- The usual arrangement is to restrict it to **authenticated users**, to a
  **specific role**, or to a **non-production environment** only.
- Configure which pages carry the script so the overlay stays where reviewers
  need it and off the pages they do not.

## Mind the trust boundary

The overlay reads the page in order to capture screenshots, so:

- Your BugHerd account is effectively **inside the site's trust boundary** — it
  sees whatever a reviewer sees.
- Avoid placing it on screens that show **personal or regulated data**,
  including authenticated admin screens, unless you have considered the
  implications.

## Save

Click **Save configuration**. The overlay then appears according to the audience
and pages you configured.
