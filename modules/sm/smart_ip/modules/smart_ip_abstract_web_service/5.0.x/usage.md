Smart IP Abstract IP Geolocation web service is a Smart IP data source that geolocates a visitor's IP by calling Abstract's hosted IP Geolocation API (ipgeolocation.abstractapi.com) with your Abstract API key.

---

This submodule registers the Smart IP data source `abstract_web_service`. Enable it and set `smart_ip.settings:data_source` to `abstract_web_service` to activate it. Its settings live in the `smart_ip_abstract_web_service.settings` config object: `version` (Abstract API version, integer, default `1`) and `api_key` (your Abstract IP Geolocation API key, required). It implements the data-source interface through an event subscriber (`SmartIpEventSubscriber` extending `SmartIpEventSubscriberBase`): `processQuery()` sends the visitor's IP to the Abstract v1 endpoint (`AbstractWebService::V1_URL` = `https://ipgeolocation.abstractapi.com/v1/`) via `WebServiceUtility`, then maps the JSON response (`country`, `country_code`, `region`, `region_iso_code`, `city`, `postal_code`, `latitude`, `longitude`, `timezone.name`) onto the Smart IP location. Form validation refuses to select this source without an API key. Like the other web-service sources it makes a per-lookup HTTPS API call (billable/rate-limited) and needs no local database or cron download.

---

- Geolocate visitors via Abstract's hosted IP Geolocation web service.
- Activate it by setting `smart_ip.settings:data_source` to `abstract_web_service`.
- Authenticate to Abstract with an `api_key` stored in `smart_ip_abstract_web_service.settings`.
- Select the Abstract API `version` (currently 1).
- Get country, country code, region, city, postal code, latitude/longitude and time zone from an IP.
- Avoid hosting or updating a local binary geolocation database.
- Use Abstract as an alternative web-service provider to MaxMind or IPInfoDB.
- Feed the `SmartIp::query()` API with Abstract web-service results.
- Back a country-based block visibility rule (Smart IP "User country" condition) with Abstract data.
- Combine with Smart IP role/page/excluded-IP controls to limit billable lookups.
- Fall back to a web service on hosts that cannot store a binary database file.
- Localize content/currency/language from live Abstract geolocation.
- Geo-target campaigns using Abstract's on-demand lookups.
- Let other modules alter the acquired location by subscribing to `smart_ip.data_acquired`.
- Serve low/medium-traffic sites where per-request API calls are acceptable.
- Use on platforms without the filesystem access needed for a binary GeoIP reader.
