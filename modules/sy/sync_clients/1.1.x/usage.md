<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sync Clients base module for syncing data to/from a remote via Advanced Queue.

---

Sync Clients **provides a data-sync framework** — a base module for syncing data to and from a remote system,
using Advanced Queue for background processing and a custom Sync API. It depends on the Advanced Queue and core
MySQL modules, and provides its own permissions, in the Web services package.

Use it as a foundation for remote data sync. It is a developer/integration framework. Security/data handling: it
**exchanges data with a remote system** (egress/ingress — confirm acceptable for the data, which may include PII)
and needs **remote credentials** (store as secrets — env/Key — over HTTPS); data received from the remote should be
**validated** before use. It has its own permissions. Configure the sync clients.

---

- Provide a data-sync framework.
- Sync to/from a remote.
- Use Advanced Queue for background sync.
- Depend on Advanced Queue + core MySQL.
- Provide its own permissions.
- Serve developers/integration.
- Exchange data with a remote (egress/ingress; may include PII).
- Need remote credentials (secrets - env/Key, HTTPS).
- Validate data received from the remote before use.
- Have its own permissions.
- Configure the sync clients.
- Handle data sync.
- Sync data.
- Configure the client.
- Queue sync.
- Handle the integration.
- Exchange data.
- Process sync.
- Secure the credentials.
- Provide a data-sync framework.
