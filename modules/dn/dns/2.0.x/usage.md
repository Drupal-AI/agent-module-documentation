<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Manage DNS zones and records as native Drupal content entities, with a pluggable record-type architecture, IDN/Punycode handling, per-zone collaborator delegation, and Views/REST/JSON:API exposure.

---

DNS (`dns`) is a ground-up Drupal 10.3+/11 rewrite of the legacy Drupal 7 DNS module. It models DNS data with three content entities — `dns_zone`, `dns_record`, and `dns_zone_grant` — so zones and records are stored, listed, edited, and API-exposed like any other Drupal content. Zone names accept Unicode (e.g. `münchen.de`) and are normalized to lowercase Punycode (`xn--mnchen-3ya.de`) on save via `ZoneNameTransformer`; the Unicode form is kept for display. Each record type (A, AAAA, CNAME, NS, MX, PTR, TXT, CAA, SRV, HTTPS, SVCB) is a `RecordType` plugin declared with the `#[RecordType]` attribute and managed by `RecordTypeManager`; plugins decide which shared base fields (`ip_address`, `target`) are shown, contribute type-specific form fields whose values land in a JSON `rdata` field, validate RFC concerns, and render a one-line BIND-style summary. Access is two-layered: site-wide permissions (`administer dns`, `create dns zones`, and legacy `view/edit/delete own`/`view any` zone perms) plus per-zone `dns_zone_grant` rows converted into `dns_zone`-scope calculated permissions by `DnsZoneGrantPolicy` (zone owners implicitly get every capability; records inherit their parent zone's access). It provides a module settings form, a `dns_records` view (admin page + zone-embedded listing), a custom `dns_record_rdata_value` Views field, and Drupal-7 Migrate source/process plugins. The optional `dns_extras` submodule adds DNAME plus the hash-digest family (SSHFP, TLSA, SMIMEA, OPENPGPKEY, DS, DNSKEY). Note: it stores and validates DNS data only — there is no live provider sync or outbound DNS lookup in this release (planned).

---

- Store DNS zones as content entities and manage them at `/admin/content/dns/zones` (collection) and `/dns/{zone}` (canonical page with an embedded records table).
- Create a zone by typing its human-readable name (`example.com` or `münchen.de`); the module derives and stores the canonical Punycode wire name automatically.
- Manage records per zone with full CRUD: add via the zone page's "Add record" action or the admin records page at `/admin/content/dns/records`.
- Publish A / AAAA records mapping a hostname to a single validated IPv4/IPv6 address (family enforced per type; ranges/CIDR rejected).
- Publish CNAME / NS / PTR records that point at a target hostname, with BIND absolute-vs-relative (`trailing dot`) and `@`-apex semantics preserved.
- Publish MX records with a priority and a mail-exchanger target.
- Publish SRV records for service discovery (SIP, XMPP, Active Directory, Matrix) with priority/weight/port plus target host.
- Publish TXT records for SPF, DKIM, DMARC, and domain-verification tokens (up to 4096 chars, NUL-byte rejected).
- Publish CAA records to restrict which certificate authorities may issue for the domain.
- Publish modern HTTPS / SVCB service-binding records.
- Enter internationalized domain names in Unicode and have them stored as Punycode but displayed back in Unicode (IDN round-trip).
- Set a site-wide default TTL for new records and optionally allow single-label (TLD) zones via the settings form at `/admin/config/content/dns`.
- Delegate work on a specific zone to other users without granting site-wide admin: add collaborators at `/dns/{zone}/collaborators` with a chosen capability set (view/edit/delete zone; view/create/edit/delete records).
- Let zone owners manage their own zones and records while keeping the collaborator list controllable only by the owner (or an administrator).
- Expose zones and records over REST and JSON:API for external tooling, since both are standard content entities.
- Build custom admin listings and reports with Views, including the `dns_record_rdata_value` field to surface individual JSON rdata keys (priority, weight, port, content) as columns.
- Filter the zone page's records table client-side by record type using the built-in type-filter pills.
- Preview a record's effective BIND resolution (`prefix.zone. → target`) live as you type in the record form.
- Migrate zones and records from a legacy Drupal 7 DNS install using the bundled `d7_dns_zone` and `d7_dns_record` migrations, with orphaned/legacy data handled tolerantly.
- Extend the module with a custom record type by writing a `RecordType` plugin — no core changes required.
- Enable the `dns_extras` submodule to add DNSSEC/DANE and specialty record types (DNAME, SSHFP, TLSA, SMIMEA, OPENPGPKEY, DS, DNSKEY).
- Use zones and records as a structured, validated source of truth ahead of a future provider-sync layer (Cloudflare, Route 53, PowerDNS, etc.).
