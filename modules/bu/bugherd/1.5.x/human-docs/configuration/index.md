# Configuration

## Open the settings form

1. Log in as a user with the **administer bugherd** permission.
2. Go to **Configuration → Development → BugHerd**, or navigate directly to
   `/admin/config/development/bugherd`.

Here you connect the site to your BugHerd project (using the project key from
your BugHerd account) and set the overlay's behavior, including the option to
**suppress it on admin pages**.

### The project key

The key that ties the overlay to your BugHerd project is rendered into the
page's client-side JavaScript, so it is not a true secret in the way a server
API password is. Even so, keep it out of configuration you commit to public
version control: on DDEV you can hold it in an environment variable
(`ddev dotenv set .ddev/.env --bugherd-api-key=<value>` then `ddev restart`,
never committing `.ddev/.env`) and feed it into the module's config via a
settings.php override using `getenv('BUGHERD_API_KEY')`.

## Decide who sees the overlay — the control that matters

The **`access bugherd`** permission (People → Permissions) decides which roles
actually receive the overlay. This is the important setting:

- Grant it to **reviewer roles only**. The widget is third-party JavaScript that
  should not be shipped to anonymous, public visitors.
- Leave it off for the anonymous role on production.

## Recommended arrangement

- Prefer enabling BugHerd on a **staging** environment rather than production.
- Remember the overlay is a **third-party script** loaded into the page — a
  data-flow and consent consideration anywhere real visitors could encounter it.
- Use the option to hide the widget on admin pages if you do not want it there.

## Save

Click **Save configuration**. The overlay then appears for the roles you granted
`access bugherd`, on the pages you have not suppressed.
