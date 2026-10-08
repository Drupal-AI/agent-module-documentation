# Configuration

Setting up GeoIP Auto-Update is a matter of entering your MaxMind credentials,
fetching the database once, and telling the GeoIP module to read from the private
copy. After that, cron keeps everything fresh with no further attention.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → GeoIP → Auto-update**, or navigate directly
   to `/admin/config/system/geoip/autoupdate`.

## The settings form, field by field

- **MaxMind Account ID** (`account_id`) — a required text field. Enter the numeric
  Account ID from your MaxMind account.
- **MaxMind License Key** (`license_key`) — a password field. Paste the license
  key generated in your MaxMind account. **Leave this blank to keep the key you
  already saved** — submitting an empty value does not wipe the stored key. This
  also makes rotating a key easy: paste the new value and save.
- **Database last downloaded** — a read‑only line showing the `Last-Modified`
  timestamp of the database currently installed, or *Never* if nothing has been
  downloaded yet.
- **Download now** — a button that saves your credentials and then immediately
  downloads the database, bypassing the "is it newer?" check. Use it to verify
  your credentials work and to seed the database the first time — watch for the
  success message.

Click **Download now** (or **Save configuration**) to store your settings.

## Point GeoIP at the private database

The module ships a GeoLocator plugin called **Local dataset (private filesystem)**
(`local_private`) that reads the database this module downloads. You need to
select it as GeoIP's active locator:

1. Go to the GeoIP settings page at **Configuration → System → GeoIP**
   (`/admin/config/system/geoip`).
2. Choose **Local dataset (private filesystem)** as the active GeoLocator and save.

Or from the command line:

```bash
drush cset geoip.geolocation plugin_id local_private -y
```

## How the automatic updates work

Once credentials are set and cron runs regularly, you don't have to do anything:

- **On each cron run**, the module makes a lightweight authenticated HEAD request
  to MaxMind and reads the `Last-Modified` header. If it matches the value it last
  recorded, it stops — nothing to do. If it's newer, it downloads the `.tar.gz`,
  extracts the `.mmdb`, copies it to `private://GeoLite2-Country.mmdb`, and records
  the new timestamp. This "only download when changed" behavior keeps you within
  MaxMind's daily download limit.
- If either credential is empty, the cron update quietly does nothing.
- Network or extraction problems are logged to the `geoip_autoupdate` log channel
  (see **Reports → Recent log messages**) rather than interrupting cron.

## Setting values without the UI

You can set the credentials with Drush instead of the form:

```bash
drush cset geoip_autoupdate.settings account_id 123456 -y
drush cset geoip_autoupdate.settings license_key YOUR_LICENSE_KEY -y
```

## Checking status

Once the `local_private` locator is active, the site status page at **Reports →
Status report** (`/admin/reports/status`) reports the private database and its age,
and warns if the database is more than a month old.
