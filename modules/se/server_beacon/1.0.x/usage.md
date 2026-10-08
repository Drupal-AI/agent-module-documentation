<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Server Beacon reports server status/health beacons to a station REST API.

---

Server Beacon **sends server status/health beacons** — periodically reporting the server/site's status and
health to a central "server station" REST API, for fleet monitoring. It stores credentials via the **Key** module,
in the Web services package.

Use it to report health to a monitoring station. It is a monitoring/integration feature. Security/data handling:
it **sends status/health data to an external station API** (egress — this can include operational/infra details,
so keep it to a trusted station) and authenticates with **credentials stored via the Key module** (secret handling,
a positive) over HTTPS. It has no access-control role. Configure the station endpoint and key.

---

- Send server health beacons.
- Report status to a station API.
- Support fleet monitoring.
- Store credentials via the Key module.
- Serve monitoring/integration.
- Report health.
- Send status/health data externally (egress; operational/infra details).
- Keep it to a trusted station.
- Store credentials via Key (positive), HTTPS.
- Have no access-control role.
- Configure the station endpoint + key.
- Handle beacons.
- Send beacons.
- Configure the client.
- Report status.
- Handle the integration.
- Monitor the server.
- Push health.
- Secure the key via Key.
- Provide server beacons.
