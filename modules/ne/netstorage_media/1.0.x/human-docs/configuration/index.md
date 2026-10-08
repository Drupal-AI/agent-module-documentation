# Configuration

Setting up NetStorage Media has three parts: enter your Akamai credentials, create a
media type that uses NetStorage as its source, and (optionally) turn on automated
synchronization. Everything except the media-type creation happens at
**Configuration → Media → NetStorage Media**
(`/admin/config/media/netstorage-media`).

## 1. Enter your NetStorage credentials

On the NetStorage Media settings page, provide:

- **Key** — your NetStorage API key. This is the sensitive credential; store it
  with the **Key** module rather than typing it into plain configuration.
- **Domain Prefix**
- **Upload Account ID**
- **CP Code**
- **URL Prefix**

### Keep credentials out of your repository

The API key should be handled through the **Key** module. The other values —
`upload_account_id`, `domain_prefix`, `cp_code`, and `url_prefix` — can be left
blank on the form and **overridden in `settings.php`** instead, which is strongly
recommended so they are never committed. For example:

```php
$config['netstorage_media.settings']['upload_account_id'] = 'YOUR_UPLOAD_ACCOUNT_ID';
$config['netstorage_media.settings']['domain_prefix']     = 'YOUR_DOMAIN_PREFIX';
$config['netstorage_media.settings']['cp_code']           = 'YOUR_CP_CODE';
$config['netstorage_media.settings']['url_prefix']        = 'YOUR_URL_PREFIX';
```

With DDEV you can keep the underlying values in an uncommitted `.env` file and read
them with `getenv()`:

```bash
ddev dotenv set .ddev/.env --netstorage-upload-account-id=<value>
ddev restart
```

Then in `settings.php`:

```php
$config['netstorage_media.settings']['upload_account_id'] = getenv('NETSTORAGE_UPLOAD_ACCOUNT_ID');
```

Keep `.ddev/.env` out of version control.

## 2. Create a NetStorage media type

1. Go to **Structure → Media types → Add media type**
   (`/admin/structure/media/add`).
2. Set the media source to **Akamai NetStorage**.
3. Add a field for the source information if one is not already present, and in the
   **field mapping**, map the **Filename** to the media entity's **Name**.
4. On the media type's **Manage form display**, set the widget for the chosen media
   field to **NetStorage Path**.
5. On **Manage display**, set the formatter for that field to **NetStorage Path**.
6. Save the media type.

You can now create media entities manually by entering a NetStorage path.

## 3. Configure synchronization (optional)

Back on the NetStorage Media settings page (`/admin/config/media/netstorage-media`),
after the media type exists, configure automated sync:

- **Enable sync** — turn automatic synchronization on.
- **Base directory** — the NetStorage directory to sync from.
- **Extensions** — which file extensions to include.
- **Media type** — the NetStorage media type created above that synced assets
  become.
- **Sync media author (uid)** — the user recorded as the author of synced media.

Assets are then imported when **cron** runs. The `administer netstorage media sync`
permission controls who can manage sync, so grant it only to trusted
administrators.

## Confirm it works

Create one media entity manually from a known NetStorage path and confirm it
renders. Then run cron (`drush cron`) and check that assets from your configured
base directory appear as media entities. Synced and manually created media can be
used anywhere ordinary media entities are used.
