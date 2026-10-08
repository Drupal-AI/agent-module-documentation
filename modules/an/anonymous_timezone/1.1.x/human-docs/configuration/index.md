# Configuration

Anonymous Timezone needs to know where your MaxMind GeoIP database file lives. That
is the one required setting, and you set it on the module's settings form.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Anonymous Timezone**, or navigate directly to
   `/admin/config/anonymous_timezone`.

## Set the GeoIP database path

Enter the path to your MaxMind **GeoLite2/GeoIP2** database file (a city or country
database). The module reads this file to resolve an anonymous visitor's IP address
to a timezone, and caches the lookup so it does not re‑read the database on every
request.

Save the form. From then on, anonymous visitors see dates formatted in the timezone
resolved from their IP; if an IP cannot be resolved, the module falls back to the
site default timezone.

## Keep in mind

- **Keep the database updated.** GeoIP data changes over time; refresh the file
  periodically for accurate results.
- **Caching impact.** The module uses the page‑cache kill switch so per‑visitor
  timezones are not stored in the shared anonymous page cache, which reduces
  cacheability on the affected responses.
- **Only anonymous users** are affected; authenticated users keep their account
  timezone.

## Test it

Request the site with an IP that maps to a non‑default timezone and confirm that
dates render in that timezone.
