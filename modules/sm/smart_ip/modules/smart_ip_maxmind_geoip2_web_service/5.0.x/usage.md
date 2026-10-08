Smart IP MaxMind GeoIP2 Precision web service is a Smart IP data source that geolocates visitors by calling MaxMind's hosted GeoIP2 Precision web service (Country, City or Insights) with your MaxMind user id and license key.

---

This submodule registers the Smart IP data source `maxmind_geoip2_web_service`. Enable it and set `smart_ip.settings:data_source` to `maxmind_geoip2_web_service` to activate it. Its settings live in `smart_ip_maxmind_geoip2_web_service.settings`: `service_type` (which MaxMind Precision endpoint — `country`, `city` or `insights`; default `city`), `user_id` (MaxMind account/user id) and `license_key`. It implements the data-source interface through an event subscriber (`SmartIpEventSubscriber` extending `SmartIpEventSubscriberBase`): `processQuery()` sends the visitor's IP to the MaxMind web service (via a `WebServiceUtility` and the `geoip2/geoip2` client) and fills the Smart IP location (country, region, city, postal code, latitude/longitude, time zone). Unlike the binary-database source it makes a per-lookup API call (billable, requires outbound HTTPS) and needs no local database or cron download. Use it when you want MaxMind accuracy without hosting the `.mmdb` file yourself.

---

- Geolocate visitors via MaxMind's hosted GeoIP2 Precision web service.
- Choose the Country, City, or Insights Precision endpoint via `service_type`.
- Authenticate to MaxMind with a `user_id` + `license_key`.
- Get country, region, city, postal code, latitude/longitude and time zone from an IP.
- Avoid hosting or updating a local `.mmdb` database file.
- Use MaxMind's most up-to-date data without cron-based downloads.
- Serve low/medium-traffic sites where per-request API calls are acceptable.
- Get higher-accuracy Insights data when configured for the Insights endpoint.
- Feed the `SmartIp::query()` API with MaxMind web-service results.
- Back a country-based block visibility rule with MaxMind web-service data.
- Combine with Smart IP role/page/excluded-IP controls to limit billable lookups.
- Fall back to a web service on hosts that cannot store a binary database.
- Localize content/currency/language based on live MaxMind geolocation.
- Switch between Country/City/Insights precision as accuracy needs change.
- Use MaxMind accuracy on platforms without the `geoip2/geoip2` binary-reader filesystem access.
- Geo-target campaigns using MaxMind's on-demand lookups.
