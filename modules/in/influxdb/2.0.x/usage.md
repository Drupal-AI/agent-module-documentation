<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
InfluxDB integrates the InfluxDB time-series database with Drupal by storing connection details and exposing a client-factory service that builds `InfluxDB2\Client` instances for reading and writing metrics.

---

The main module provides a config-only settings form at `/admin/config/services/influxdb` (`administer influxdb` permission) that stores `server_url`, `organization`, an authorization `token`, and `allow_redirects`/`debug` flags. Crucially the token is stored via the **Key** module — the form uses a `key_select` element and only the key ID is persisted, so the secret itself lives in a Key provider (env, file, etc.) rather than in plaintext config. `ClientFactory` (`influxdb.services.client_factory`) resolves that Key at runtime and injects Drupal's shared `@http_client`; the `influxdb.services.client` service is the ready-to-use client. TLS behaviour follows whatever `server_url` scheme the admin configures (use `https://`); the module never disables certificate verification. The `influxdb_bucket` submodule adds a `influxdb_bucket` config entity and admin UI (`/admin/config/services/influxdb/buckets`, `administer influxdb bucket`) that upserts buckets on the remote server via `BucketManager`. The `influxdb_bucket_eca` submodule adds ECA actions — Create Point, Write Point and Run Flux Query. Note that the Flux query in `RunFluxQuery` and the Point tags/fields in `CreatePoint` come from the ECA model configuration authored by an admin (not from end-user request input), so there is no user-supplied query interpolation / injection surface exposed to anonymous traffic. As with the other admin routes there is a permission-name mismatch (routing requires `administer influxdb` while the defined permission is `administer influxdb configuration`), so the settings route fails closed until reconciled.

Typical setup: create a Key holding the InfluxDB token, enter the server URL/organization on the settings form, select the Key, then use `Drupal::service('influxdb.services.client')` (or the ECA actions/buckets submodules) to push metrics.
---
- Configure server URL, organization and token key at `/admin/config/services/influxdb`.
- Store the InfluxDB token as a Key (authentication type) rather than plaintext.
- Validate connectivity — the form pings the server and reports the InfluxDB version.
- Confirm the organization ID on save.
- Enable HTTP redirect following or verbose HTTP debug logging as needed.
- Obtain a ready client via `Drupal::service('influxdb.services.client')`.
- Create arbitrary InfluxDB2 services with `->createService(SomeService::class)`.
- Write time-series points from custom code.
- Query data with the Flux query API.
- Enable `influxdb_bucket` to manage buckets from Drupal.
- Create a bucket config entity at `/admin/config/services/influxdb/buckets/add`.
- Set a bucket's retention period in seconds.
- Upsert (create or patch) buckets on the remote server via `BucketManager`.
- Enable `influxdb_bucket_eca` to drive InfluxDB from ECA models.
- Use the "Create a Point" ECA action to build a measurement point from tokens/YAML.
- Use the "Write Point" ECA action to send a point to a selected bucket.
- Use the "Execute a Flux query" ECA action and capture results in an ECA token.
- Send application metrics or IoT sensor data to InfluxDB.
- Feed dashboards/alerting from Drupal-generated events.
- Rotate the token by updating the referenced Key.
- Restrict administration with the `administer influxdb bucket` permission.
