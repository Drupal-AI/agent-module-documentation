# Configuration

Configuring Modal Management Module has three parts: deciding who may manage
modals, creating and styling your modal content, and — only if you want
location-aware modals — connecting a geolocation service.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Open the module's settings form via its configure link (`ik_modals.settings`)
   from the **Extend** page or the admin configuration section.

## Permissions

The module provides its own permissions so you control who can create and manage
modals. Under **People → Permissions** (`/admin/people/permissions`), grant the
modal-management permissions only to the trusted editors or administrators who
should build modals, and leave them off for everyone else. Modal content is shown
to site visitors, so treat the ability to author it like any other content-editing
privilege.

## Modal bundles and content

Modals are a custom **entity** with **bundles** — think of a bundle as a modal
type. Each bundle is fieldable, so you can add exactly the fields a given kind of
modal needs (title, body, image, a call-to-action link, targeting options), and
each bundle provides its own template suggestions so themers can style it
independently.

A typical workflow is:

1. Create a **Modal bundle** for each kind of modal you need (for example a
   "Newsletter" bundle and a "Promotion" bundle).
2. Add fields to each bundle to hold its content.
3. Create individual **Modal** items within those bundles — this is the actual
   content visitors see.
4. Style each bundle through its template suggestions in your theme.

## Optional: geolocation for location-aware modals

If you want to show or target modals based on a visitor's location, the module can
resolve an IP address to a location using one of three back-ends:

- **GeoIP2** — the PHP library is bundled with the module, so no key is required.
- **ipdata** — requires an API key from [ipdata.co](https://ipdata.co).
- **AbstractAPI Geolocation** — requires an API key from
  [abstractapi.com](https://www.abstractapi.com).

The two hosted services are optional; use them only if the bundled GeoIP2 lookup
does not meet your needs.

### Store the API key safely

An API key is a secret — **never hard-code it or commit it to version control**.
Store the value in an environment variable instead:

1. In DDEV, save it to the project's dotenv file (this example uses ipdata):

   ```bash
   ddev dotenv set .ddev/.env --ipdata-api-key=<value>
   ddev restart
   ```

   The flag `--ipdata-api-key` becomes the environment variable `IPDATA_API_KEY`.
   Keep `.ddev/.env` out of version control.

2. Where the module accepts a key through a Key entity, install the
   [Key](https://www.drupal.org/project/key) module and create a Key backed by the
   environment variable rather than pasting the secret into a form. Otherwise
   reference the variable from `settings.php` with `getenv('IPDATA_API_KEY')`.

## Save

Save the settings form after making changes, and clear the cache (`drush cr`) if a
new bundle's template suggestions do not appear right away.
