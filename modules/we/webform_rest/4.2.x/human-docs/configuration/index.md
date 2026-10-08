# Configuration

Configuring Webform REST is really two jobs: **turning on the REST resources** you
want (and giving them methods, formats, and authentication), and then making sure the
client account has the **Webform permissions** to actually use them. There is also a
small settings form of the module's own.

## The five resources

The module ships these resource plugins. Each is off until you enable it:

| Resource | Methods | Endpoint |
|----------|---------|----------|
| Webform Elements | GET | `/webform_rest/{webform_id}/elements` |
| Webform Fields | GET | `/webform_rest/{webform_id}/fields` |
| Webform Submit | POST | `/webform_rest/submit` |
| Webform Submission | GET, PATCH | `/webform_rest/{webform_id}/submission/{uuid}` |
| Webform Complete Submission | GET | `/webform_rest/{webform_id}/complete_submission/{uuid}` |

## Enable a resource with REST UI (recommended)

1. Install and enable the REST UI module (`composer require drupal/restui -W` then
   `drush en restui -y`).
2. Go to **Configuration → Web services → REST** (`/admin/config/services/rest`).
3. Find the resource you want — for example **Webform Submit** — and click **Enable**.
4. Tick the **methods** the resource should answer to (POST for submit; GET for
   elements/fields; GET and PATCH for a submission), the **formats** to accept
   (usually `json`), and the **authentication providers** (for example `cookie`, or
   `basic_auth` if that module is enabled).
5. **Save**, then clear caches (`drush cr`) so the REST routes rebuild.

If you prefer not to install REST UI, the same result can be achieved by importing a
`rest.resource.*` config file or creating the resource config in code — see the
[`agent/`](../../agent/start.md) docs for ready‑made snippets.

## Grant the Webform permissions

Enabling a resource only opens the route. The requesting account must also hold the
relevant **Webform** permissions — for example the ability to create a submission for
the target webform, or *access any webform submission* to read submissions back.
Grant these on **People → Permissions** to whichever role the client authenticates
as (including the Anonymous role for a public form).

## The settings form

Webform REST adds one small form at **Configuration → Webform REST**
(`/admin/webform_rest/settings`), reachable by users with the **Access webform rest
settings** permission. It has a single option:

- **Confirmation Settings** — a checkbox. When **off** (the default), a successful
  `POST /webform_rest/submit` returns only the new submission id, e.g.
  `{ "sid": … }`. When **on**, the response also includes the webform's confirmation
  type, URL, message, and title — handy when the client wants to show the same
  "thank you" experience the site would.

Set it from the command line with:

```bash
drush cset webform_rest.settings confirmation_settings 1 -y
```

## Permissions summary

- **Access webform rest settings** — needed to open the module's settings form above.
- The usual **Webform** submission permissions — needed by the client account to read
  or create submissions through the resources.
