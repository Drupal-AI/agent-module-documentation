# Configuration

Neuraflow needs your **assistant ID** and a few display choices before the neurabot
integration will appear on your site. You configure it at **Configuration → Web
services → Neuraflow** (`/admin/config/services/neuraflow`).

## Open the settings form

1. Log in as a user with the **`administer neuraflow`** permission.
2. Go to **Configuration → Web services → Neuraflow**
   (`/admin/config/services/neuraflow`).

## Fields to complete

- **Assistant ID** — the valid assistant ID issued by Neuraflow GmbH under your
  contract. This is what ties the on-site assistant to your Neuraflow account, so
  the neurabot integration cannot run without it.
- **Display settings** — configure how and where the assistant appears on your site
  to match your layout and audience.

## Store credentials securely

Any Neuraflow API credentials are secrets — keep them out of committed
configuration. Where a value is sensitive, prefer an **environment variable**
referenced from `settings.php`, or the **Key** module. With DDEV you can set a
value without committing it:

```bash
ddev dotenv set .ddev/.env --neuraflow-api-key=<value>
ddev restart
```

Then reference it from `settings.php` with `getenv('NEURAFLOW_API_KEY')` and keep
`.ddev/.env` out of version control.

## Save and confirm

Save the form, then load a front-end page and confirm the neurabot assistant
appears and responds as configured. If it does not, re-check the assistant ID and
your display settings.

## A note on privacy

Visitor interactions with the assistant are handled by Neuraflow's service. Confirm
that this data egress is acceptable for your site and disclose it to visitors where
your privacy obligations require it.
