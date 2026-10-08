# Configuration

Smart IP's settings all live on one form at **Configuration → People → Smart IP**
(`/admin/config/people/smart_ip`), reachable with the **Administer Smart IP**
permission. The form has a few sections: a manual lookup tool, the **data source**
selection (each enabled source adds its own subsection here), general
**preferences**, and a **debug** tool.

## Selecting a data source (required)

Nothing geolocates until you pick an active data source:

1. Enable the source submodule you want (see
   [Installation](../installation/index.md)).
2. On the settings form, select it as the **data source**.
3. Provide whatever that source needs — a database file for the binary sources,
   or an API key/credentials for the web-service sources — in the section that
   source added to the form.

The choices, at a glance:

- **MaxMind GeoIP2 binary database** — you download a MaxMind database file to
  your server; lookups are then fast and offline. The database can be refreshed
  from the form's manual-update button or automatically on cron.
- **MaxMind GeoIP2 web service** — MaxMind's hosted Precision service; each lookup
  is an API call and needs MaxMind account credentials.
- **IP2Location binary database** — an IP2Location database file on your server.
- **IPInfoDB / Abstract web service** — keyed API lookups; you paste in the API
  key their section provides.
- **Device Geolocation** — precise coordinates from the visitor's own browser via
  the W3C Geolocation API (the visitor is prompted to allow it).

For binary-database sources, use the form's manual-update button to download or
refresh the database, or let cron keep it current.

> **API keys and credentials are secrets.** The web-service sources (MaxMind,
> IPInfoDB, Abstract) require keys that should not end up in a public repository.
> Follow this project's secrets practice: store the value in an environment
> variable via DDEV's dotenv (`ddev dotenv set .ddev/.env --maxmind-license-key=…`,
> then `ddev restart`), keep `.ddev/.env` out of version control, and be careful
> not to commit exported configuration with a live key in it. Enter real
> credentials on the live site only.

## Preferences — the general settings

The main settings, stored on the `smart_ip.settings` config object, are:

- **Roles to geolocate** — which user roles get geolocated on each request.
  Default is authenticated users. Choose the roles you actually need to reduce
  overhead.
- **Save user location at registration** — when on, a user's location is stored
  on their profile when their account is created.
- **Allowed pages** — restrict geolocation to a specific set of Drupal paths
  (visibility-style list) instead of running it everywhere.
- **Excluded IPs** — a list of IP addresses to skip entirely (for example your
  office or internal ranges). Lookups for those addresses return no location.
- **Don't save location for EU visitors** — a privacy/GDPR option: when on, Smart
  IP will not store location data for visitors detected as being in an EU
  country.
- **Time-zone format** — how the time zone is represented, either as an
  identifier like `Europe/Berlin` or as a numeric offset.

You can also read or set these from the command line, for example:

```bash
drush cget smart_ip.settings data_source
drush cset smart_ip.settings data_source maxmind_geoip2_bin_db -y
```

## Debugging

Because your own IP usually resolves to a local/development address, the form
includes tools to test with a real one:

- The **manual lookup** section lets you type any IP and see what Smart IP
  returns for it.
- **Debug mode** can be turned on **per role**: set a role into debug mode and
  give it a fixed **debug IP**, and users in that role are geolocated as if they
  were at that IP. Handy for testing country-specific behaviour without a VPN.

## Using the result — block visibility by country

Once a source is active, Smart IP provides a **"User country"** condition. In a
block's *Visibility* settings you'll find it under **User country**, letting you
show or hide the block based on the visitor's detected country — no code needed.
For anything more custom, the location is available to code and other modules can
subscribe to Smart IP's events to adjust results; see the sibling
[`agent/`](../agent/start.md) docs for the programmatic details.
