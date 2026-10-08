# Configuration

OpenWoo is set up in a few steps: configure your organisation, then configure
whichever of the Search and Publish submodules you enabled, add the OpenWoo.app API
key, and (for Search) place the search block.

## 1. Set up the organisation

1. Go to **Configuration → Web services → OpenWoo**
   (`/admin/config/services/openwoo`).
2. Fill in your organisation's details. These can be **pre-filled from the Dutch
   OIN register** at [oinregister.logius.nl](https://oinregister.logius.nl/), which
   saves you typing them by hand.
3. Save.

## 2. The OpenWoo.app API key (store it as a secret)

Both the Search and Publish submodules can use an OpenWoo.app **API key**. Rather
than a UI field, the key is set in `settings.php`:

```php
// For search:
$config['openwoo_search.openwoo_app']['api_key'] = 'API_KEY';

// For publishing:
$config['openwoo_publish.openwoo_app']['api_key'] = 'API_KEY';
```

For search the key is **optional** (it speeds searches up); for publishing you will
need it to push data. Because it is a credential, do not hard-code it directly in a
committed `settings.php`. On DDEV, store it in an environment variable and read it
in:

```bash
ddev dotenv set .ddev/.env --openwoo-api-key=YOUR_KEY_HERE
ddev restart
```

Then in `settings.php`:

```php
$config['openwoo_publish.openwoo_app']['api_key'] = getenv('OPENWOO_API_KEY');
$config['openwoo_search.openwoo_app']['api_key'] = getenv('OPENWOO_API_KEY');
```

Keep `.ddev/.env` out of version control. Note that publishing sends data to the
external OpenWoo.app service — that is the intended behaviour, since WOO
publications are public documents.

## 3. Configure OpenWoo Search

1. Enable the **OpenWoo Search** submodule (see
   [Installation](../installation/index.md)).
2. Go to **Configuration → Web services → OpenWoo → OpenWoo Search**
   (`/admin/config/services/openwoo/openwoo-search`) and **select the client** to
   use. OpenWoo.app is currently the only available provider.
3. Add the API key in `settings.php` as shown above (optional, but it speeds up
   search).
4. Place the **OpenWoo search block** from **Structure → Block layout**
   (`/admin/structure/block`). Visitors can then filter by **year**, **category**,
   and a **free-text** field.

## 4. Configure OpenWoo Publish

1. Enable the **OpenWoo Publish** submodule (it requires Media and Media Library).
2. Go to **Configuration → Web services → OpenWoo → OpenWoo Publish**
   (`/admin/config/services/openwoo/openwoo-publish`) and **select the client** and
   the **correct endpoint** (consult the OpenWoo.app team if you are unsure which
   endpoint to use).
3. Add the API key in `settings.php` as shown above.
4. Create publications at **Content → OpenWoo publications**
   (`/admin/content/openwoo/publications`). Each publication supports attachments
   (added as a media type with the required metadata) and a published/unpublished
   state. A saved publication is pushed to OpenWoo.app on the **next cron run**.

## 5. Optional: store attachments in S3

If you want publication attachments stored in an S3 bucket rather than local
files, install the [s3fs](https://www.drupal.org/project/s3fs) module and add its
settings to `settings.php` (access key, secret key, bucket, region), configuring
uploads as private. Refer to the s3fs module documentation for the exact keys.
Attachments will then be saved to your bucket.
