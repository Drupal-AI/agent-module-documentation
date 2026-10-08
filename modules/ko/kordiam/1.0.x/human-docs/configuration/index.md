# Configuration

Kordiam's setup has two parts: give Drupal your Kordiam API credentials (stored
securely), and grant the API permission to the roles that should use the
integration. You need the **Administer site configuration** permission (an
administrator by default) to reach the settings form, which lives under
**Configuration**.

## Get your Kordiam credentials

In your Kordiam account, obtain the **API credentials** for connecting your
site(s). Copy them for the next step.

## Store the credentials securely (recommended)

The Kordiam credentials are secrets. Rather than pasting them straight into the
form — where they can end up in a configuration export and in git — store them in
an environment variable and reference them from Drupal.

With DDEV, save the value into the project's dotenv file and restart so the
container picks it up:

```bash
ddev dotenv set .ddev/.env --kordiam-api-secret=<your-secret>
ddev restart
```

That makes the value available as `KORDIAM_API_SECRET` inside the container. Never
commit `.ddev/.env`. Where the module accepts a
[Key](https://www.drupal.org/project/key) entity, create one backed by that
environment variable and select it here; otherwise reference the variable from
`settings.php` with `getenv('KORDIAM_API_SECRET')`.

## Enter the settings

On the module's settings form, provide your **Kordiam API credentials** (or the
Key/environment reference you set up). This authenticates the two‑way sync between
Drupal and Kordiam. Save the form.

## Grant the API permission

Go to **People → Permissions** (`/admin/people/permissions`) and grant the
**`access to Kordiam API`** permission to the roles that should be able to use the
Kordiam integration. Keep it scoped to trusted editorial roles.

## What syncs

Once connected, the module keeps the following metadata in step between Drupal and
Kordiam: article description, publishing date and time, statuses, categories,
author emails, the URLs on each system, slug, headline, content types, and a
custom platform text field. Planned content created in Kordiam appears as articles
in Drupal, and breaking‑news articles created in Drupal are pushed back to
Kordiam's story lists.
