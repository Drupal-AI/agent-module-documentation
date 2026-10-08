<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# State Expirable (state_expirable) — agent index
**A State-API-like service whose values expire after a TTL, backed by the expirable key/value store.**

- **Version:** 1.1.x
- **Core:** ^8 || ^9 || ^10
- **Service:** `state_expirable.state` → `StateExpirable` (args `@keyvalue`, `@keyvalue.expirable`)
- API mirrors core State (`get/set/getMultiple/setMultiple/delete`) with a TTL on writes.
- No routes, permissions, or forms.

**Security:** Server-side developer API only; no request surface, no routes, nothing anonymous can reach.

See [api/service.md](api/service.md)
