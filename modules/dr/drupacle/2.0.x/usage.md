<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drupacle lets developers connect Drupal to one or more external Oracle databases through PHP's OCI8 extension.

---

Drupacle is an **Oracle Database Connection Tool** for Drupal. You register each Oracle database
as a **`drupacle_connection`** config entity (label, database name, host, port, username, password,
service name / SID) under **Configuration → Drupacle** (`/admin/drupacle/connections`). The
collection page lists every connection, shows a live connection-status column, and hands you a
ready-to-paste PHP snippet ("short code"). At runtime a developer loads the connection entity and
calls the `drupacle.connection_service` service (`DrupacleController::drupalConnectionCallback()`),
which opens an OCI8 connection with `oci_connect()` and returns the connection resource keyed by the
connection label; the developer then runs Oracle statements with the standard `oci_parse()` /
`oci_execute()` / `oci_fetch_*()` functions. Multiple connections are supported so one Drupal site
can talk to several Oracle databases. The module ships permissions, an access-control handler and a
config schema for the connection entity; it requires the **oci8** PHP extension to be installed on
the server and has no other Drupal module dependencies.

---

- Register an Oracle database as a reusable connection entity in Drupal.
- Store host, port, service name / SID, database name and credentials for a connection.
- Manage several Oracle connections from one site.
- List all configured connections at `/admin/drupacle/connections`.
- See a per-connection live "Connection Status" column on the list page.
- Copy the generated PHP short-code snippet for a connection.
- Load a connection programmatically via the `drupacle_connection` entity storage.
- Open an OCI8 connection with the `drupacle.connection_service` service.
- Run Oracle queries with `oci_parse()` / `oci_execute()` on the returned resource.
- Read data from an external Oracle database into Drupal code.
- Write data to an external Oracle database from Drupal code.
- Build a custom module that reports on Oracle data.
- Integrate a legacy Oracle system alongside Drupal's own database.
- Gate connection management with dedicated per-operation permissions.
- Add a new connection via the "Add Oracle DB connection" action link.
- Edit an existing connection's details.
- Delete a connection through a confirmation form.
- Give each connection a human-readable label used as its lookup key.
- Reference connections by machine name in code.
- Detect whether the oci8 extension is available before connecting.
- Support Oracle service-name and SID style connect strings.
