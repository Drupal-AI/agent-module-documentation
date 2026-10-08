# Configuration

Netcall AI Widget needs your Netcall widget details before it will show anything to
visitors. You configure it at **Configuration → Web services → Netcall AI Widget**
(`/admin/config/services/netcall/ai-widget`).

## Before you start: treat the widget details as secrets

The identifiers Netcall gives you to embed the widget are account credentials.
Follow your project's convention for handling secrets rather than committing a
production value into version-controlled configuration:

- Keep production values out of exported configuration where you can, and use
  different values for staging and production.
- If your workflow supports it, store the value in an environment variable and
  reference it from `settings.php`. With DDEV you can set an environment variable
  without committing it:

  ```bash
  ddev dotenv set .ddev/.env --netcall-widget-id=<value>
  ddev restart
  ```

  Then override the module's setting from `settings.php` using
  `getenv('NETCALL_WIDGET_ID')`. (Keep `.ddev/.env` out of version control.)

## Open the settings form

1. Log in as a user with permission to administer the Netcall AI Widget (see the
   module's permissions at
   `/admin/people/permissions/module/netcall_ai_widget`).
2. Go to **Configuration → Web services → Netcall AI Widget**
   (`/admin/config/services/netcall/ai-widget`).

## Fields to complete

Enter the widget identifier / embed details from your Netcall account so the module
can render the correct widget. Then choose where it should appear:

- **Enable site-wide** — turn the widget on for the whole site so it shows on every
  page.
- **Per-page / per-section overrides** — once the site-wide widget is set, you can
  override it for specific pages or site sections to display a different version of
  the widget in those places.

## Save and confirm

Save the form, then load a front-end page (as an anonymous visitor for a realistic
test). The Netcall AI widget should appear where you enabled it. If it does not,
re-check the widget details and that the widget is enabled for the page you are
viewing.

## A note on privacy

Conversations that visitors have with the widget are sent to Netcall's service.
Confirm that this data egress is acceptable for your site and disclose it to
visitors where your privacy obligations require it.
