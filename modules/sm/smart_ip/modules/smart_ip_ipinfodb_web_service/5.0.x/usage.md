Smart IP IPInfoDB web service is a Smart IP data source that geolocates a visitor's IP by calling the IPInfoDB.com web service with your IPInfoDB API key.

---

This submodule registers the Smart IP data source `ipinfodb_web_service`. Enable it and set `smart_ip.settings:data_source` to `ipinfodb_web_service` to activate it. Its settings live in the `smart_ip_ipinfodb_web_service.settings` config object: `version` (IPInfoDB API version, integer, `2` or `3`, default `3`) and `api_key` (your IPInfoDB API key, required). It implements the data-source contract through an event subscriber (`SmartIpEventSubscriber` extending `SmartIpEventSubscriberBase`): `processQuery()` sends the visitor's IP to the IPInfoDB v2 endpoint (`IpinfodbWebService::V2_URL` = `http://api.ipinfodb.com/v2/ip_query.php`) or v3 endpoint (`V3_URL` = `http://api.ipinfodb.com/v3/ip-city`) via `WebServiceUtility`, then maps the response (country, country code, region, city, zip, latitude, longitude, time zone) onto the Smart IP location. Version 2 still returns a region code; version 3 removed it. Form validation refuses to select this source without an API key. Like the other web-service sources it makes a per-lookup HTTP API call (rate-limited) and needs no local database or cron download.

---

- Geolocate visitors via the IPInfoDB.com hosted web service.
- Activate it by setting `smart_ip.settings:data_source` to `ipinfodb_web_service`.
- Authenticate to IPInfoDB with an `api_key` stored in `smart_ip_ipinfodb_web_service.settings`.
- Choose IPInfoDB API `version` 2 (with region code) or 3 (default, no region code).
- Get country, country code, region, city, zip, latitude/longitude and time zone from an IP.
- Avoid hosting or updating a local binary geolocation database.
- Use IPInfoDB as an alternative web-service provider to MaxMind or Abstract.
- Feed the `SmartIp::query()` API with IPInfoDB web-service results.
- Back a country-based block visibility rule (Smart IP "User country" condition) with IPInfoDB data.
- Combine with Smart IP role/page/excluded-IP controls to limit API traffic.
- Fall back to a web service on hosts that cannot store a binary database file.
- Localize content, currency or language from live IPInfoDB geolocation.
- Geo-target campaigns using IPInfoDB's on-demand lookups.
- Keep region-code data by pinning `version` to 2 when downstream code needs region codes.
- Let other modules alter the acquired location by subscribing to Smart IP's location events.
- Serve low/medium-traffic sites where per-request API calls are acceptable.
- Use on platforms without the filesystem access needed for a binary GeoIP reader.
- Migrate from a deprecated bundled IPInfoDB integration to this standalone data source.
