<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# InfluxDB (influxdb) — agent index
**Integrates the InfluxDB time-series database: a Key-backed client-factory service plus optional bucket management and ECA actions for writing points and running Flux queries.**

**Version:** 2.0.x  ·  **Core:** ^10.3 || ^11  ·  **Depends:** key:key  ·  **Configure:** `/admin/config/services/influxdb`
- **Route:** `influxdb.settings_form` (`_permission: administer influxdb`).
- **Permission (influxdb.permissions.yml):** `administer influxdb configuration` (`restrict access: true`).
- **Services:** `influxdb.services.client_factory` (`ClientFactory`) and `influxdb.services.client` (`InfluxDB2\Client` built by the factory).
- **Submodules:** `influxdb_bucket` (bucket config entity + `/admin/config/services/influxdb/buckets`, perm `administer influxdb bucket`); `influxdb_bucket_eca` (ECA actions: Create Point, Write Point, Run Flux Query).
- **Security:** token stored via the **Key** module (`key_select` → only key ID in config; secret in a Key provider) — good posture. TLS follows the admin's `server_url` scheme; verification never disabled. Flux queries / point data come from admin-authored ECA config, not end-user request input → no anonymous injection surface. Permission-name mismatch: route wants `administer influxdb` but `administer influxdb configuration` is defined (fails closed).

See [api/influxdb.md](api/influxdb.md)
