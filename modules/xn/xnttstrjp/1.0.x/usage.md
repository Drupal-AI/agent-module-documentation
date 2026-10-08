<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
xnttstrjp provides a storage plugin for External Entities.

---

xnttstrjp provides an **External Entities storage-client plugin** — a data-source/storage backend for the
External Entities module (a JSON-based source), letting external data be mapped into browsable external entities.
It depends on the External Entities module, in the External Entity package.

Use it as a storage backend for external entities. It is an integration/external-data feature. Security/data
handling: the data comes from an **external source** (handle any source **credentials** as secrets over HTTPS,
trust the source), and external-entity access follows how you configure it (don't over-expose sensitive external
data). It has no access-control role of its own. Configure the external-entity type using this storage.

---

- Provide an External Entities storage plugin.
- Offer a JSON-based data source.
- Map external data to entities.
- Depend on the External Entities module.
- Serve external-data integration.
- Back external entities.
- Handle source credentials as secrets over HTTPS.
- Trust the external source.
- Not over-expose sensitive external data.
- Have no access-control role of its own.
- Configure the external-entity type.
- Handle external storage.
- Store external data.
- Configure the source.
- Map external data.
- Handle the integration.
- Browse external data.
- Back entities.
- Secure the source.
- Provide external-entity storage.
