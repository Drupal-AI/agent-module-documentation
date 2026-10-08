<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DNS — entities and the two-layer access model

Three content entities, all `base_table`-backed with `admin_permission = administer dns`, defined in `src/Entity/`.

## dns_zone (`DnsZone`)

- `entity_keys`: `id = name`, `label = label`, `owner = uid`. Base table `dns_zone`.
- Two identity fields: **`label`** (Unicode display form, the user input, e.g. `münchen.de`) and **`name`** (lowercase Punycode/ACE wire form, the entity id and URL slug, e.g. `xn--mnchen-3ya.de`). For ASCII zones they match. Both are read-only after create.
- `preSave()` derives the `[label, name]` pair from input via `Utility\ZoneNameTransformer::derivePair()` on first save only (`DnsZoneForm::copyFormValuesToEntity()` does it earlier for validation). `label` carries the `DnsZoneName` constraint (`ZoneNameConstraint`).
- Other fields: `uid` (owner), `attrs` (free-form JSON `string_long`, not displayed), `created`, `changed`.
- `preDelete()` enforces "no orphans": throws `EntityStorageException` if any `dns_record` still references the zone (an entity-level invariant, not just a UI check), then cascade-deletes the zone's `dns_zone_grant` rows.
- Routes via core `AdminHtmlRouteProvider`. Links: canonical `/dns/{dns_zone}`, add `/dns/zones/add`, edit/delete, collection `/admin/content/dns/zones`. Forms `DnsZoneForm` (add/edit), `DnsZoneDeleteForm` (delete). List builder `DnsZoneListBuilder`.

## dns_record (`DnsRecord`)

- `entity_keys`: `id = record_id` (numeric PK), `owner = uid`. Base table `dns_record`. **No canonical route** — records are authored/listed via the parent zone's embedded view; `DnsRecordRouteProvider::getCanonicalRoute()` returns NULL. Links: add/edit/delete nested under `/dns/{dns_zone}/records/...`.
- Fields: `zone` (entity_reference → dns_zone, required), `prefix` (subdomain label; `@`/empty = apex; `DnsRecordPrefix` constraint; lowercased in `preSave()`), `record_type` (`list_string`; allowed values from `DnsRecord::recordTypeAllowedValues()` → the RecordType plugin manager), `ttl` (integer 0–2147483647, default 3600), `ip_address` (`ipaddress` field from field_ipaddress, single address, no ranges; A/AAAA), `target` (hostname for CNAME/MX/NS/SRV/PTR/DNAME; canonicalized to BIND form in `preSave()` via `ZoneNameTransformer::canonicalizeTargetName()`), `rdata` (`string_long` JSON catch-all for type-specific data — `getRdata()`/`setRdata()` encode/decode), `uid`, `created`, `changed`.
- `record_type` drives which fields matter: the form (see [../plugins/record-types.md](../plugins/record-types.md)) toggles `ip_address`/`target` per the active plugin's `usedFields()` and clears unclaimed fields on save.
- Entity constraint `DnsRecordCnameExclusivity` (`CnameExclusivityConstraint` — a CNAME cannot coexist with other records at the same name). `route_provider = DnsRecordRouteProvider` adds the `{dns_zone}` converter; `urlRouteParameters()` injects the zone id into nested URLs.

## dns_zone_grant (`DnsZoneGrant`)

- `entity_keys`: `id = grant_id`, `owner = uid` (the **collaborator** who receives capabilities). Base table `dns_zone_grant`. Links nested under `/dns/{dns_zone}/collaborators/...`, collection `/dns/{dns_zone}/collaborators`.
- Fields: `zone` (ref → dns_zone), `uid` (the grantee/collaborator), `capabilities` (multi-value `list_string`; allowed values from `DnsZoneGrant::capabilityAllowedValues()` → the `ZoneCapability` enum), `created`, `changed`.
- Constraint `DnsZoneGrantUnique` (`DnsZoneGrantUniqueConstraint`) — one grant row per (zone, user). Form `DnsZoneGrantForm` pins the zone from the route, hides the zone selector in the nested flow, and rejects a grant to the zone owner (owners already hold all capabilities).

## Access model (two layers)

Capability vocabulary: enum `Access\ZoneCapability` — `view zone`, `edit zone`, `delete zone`, `view records`, `create records`, `edit records`, `delete records`. These are **per-zone capabilities, never site-wide permissions** (never appear on `/admin/people/permissions`).

Access policy `AccessPolicy\DnsZoneGrantPolicy` (service `dns.access_policy.zone_grant`, tag `access_policy`, scope constant `SCOPE = 'dns_zone'`) turns grants into calculated permissions per user:
- **Owned zones** → an item with *every* capability (owner-implies-all; no grant row needed).
- **Granted zones** → an item carrying that `dns_zone_grant` row's capability set.
- Cache: context `user`; tags include `dns_zone_grant_list` (+ per-grant/per-zone) so grant edits invalidate. Provider modules are expected to layer their own policy in the same scope to revoke caps.

`DnsZoneAccessControlHandler::checkAccess()` resolution (first match wins):
1. `administer dns` → allowed (super-admin escape).
2. synthesized `manage_collaborators` op → allowed only for the zone **owner** (or admin) — a collaborator with `edit zone` deliberately cannot manage grants (prevents self-escalation).
3. per-zone capability via the access policy (`ZoneCapability::forZoneOperation()` maps view/update/delete).
4. legacy site-wide fallback: `view any dns zone`, or owner + `view/edit/delete own dns zones`.
Create access → `create dns zones`.

`DnsRecordAccessControlHandler` maps record ops to record capabilities (`ZoneCapability::forRecordOperation()`) resolved against the **parent zone's** `dns_zone`-scope permissions; admin escapes; view ops fall back to the parent zone's view access for legacy installs; create access resolves the zone from `$context['zone']` or the route's `dns_zone` param.

`DnsZoneGrantAccessControlHandler` gates all grant CRUD through the parent zone's `manage_collaborators` op (owner/admin only), for every save path. The grant collection route provider (`DnsZoneGrantRouteProvider`) swaps the default `administer dns` requirement for `_entity_access: dns_zone.manage_collaborators` so owners aren't locked out.

Because both entities are standard content entities, these handlers govern REST/JSON:API and programmatic access too, not just the HTML forms.
