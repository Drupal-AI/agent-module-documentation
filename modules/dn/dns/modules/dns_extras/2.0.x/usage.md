<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Optional DNS submodule that adds less-common record-type plugins — DNAME plus the DNSSEC/DANE hash-digest family (SSHFP, TLSA, SMIMEA, OPENPGPKEY, DS, DNSKEY) — to the parent DNS module.

---

DNS — extras (`dns_extras`) is the companion submodule of the `dns` project. It contributes seven additional `RecordType` plugins so the core `dns` module can keep its shipped set focused on common types. It adds **DNAME** (subtree delegation, RFC 6672 — same shape as CNAME/NS/PTR: one `target` hostname) and the **hash-digest / key family** built on a shared `HashRecordTypeBase`: **SSHFP** (SSH host-key fingerprint, RFC 4255), **TLSA** (DANE TLS cert pinning, RFC 6698), **SMIMEA** (S/MIME cert association), **OPENPGPKEY** (OpenPGP public key in DNS), **DS** (delegation signer), and **DNSKEY** (DNSSEC zone key). Each hash-family type is a set of small integer headers (uint8/uint16 ranges) plus one binary payload validated and stored as hex or base64, written into the record's `rdata` JSON field and rendered in BIND zone-file order. The submodule has no routes, permissions, services, or config of its own; it depends only on `dns`, and enabling it simply makes these types selectable in the DNS record form. Discovery and validation are covered by kernel tests (`DnsExtrasDiscoveryTest`, `HashRecordTypeTest`).

---

- Enable via `drush en dns_extras` (requires the `dns` module) to add specialty record types to every zone.
- Publish DNAME records to alias an entire subtree of names to another domain (like CNAME but for everything beneath the owner name).
- Publish SSHFP records to advertise SSH host-key fingerprints in DNS for DNSSEC-secured host verification.
- Publish TLSA records to pin a TLS certificate (or its hash) for DANE-aware clients (`_443._tcp.example.com` convention).
- Publish SMIMEA records to associate an S/MIME certificate with an email address in DNS.
- Publish OPENPGPKEY records to distribute a user's OpenPGP public key via DNS.
- Publish DS records to link a delegated child zone into the DNSSEC chain of trust from the parent.
- Publish DNSKEY records to publish a zone's DNSSEC signing keys.
- Enter hash/key payloads as hex or base64 with whitespace and (for hex) case ignored; the module validates the encoding and round-trips base64.
- Rely on per-header range validation (certificate usage, selector, matching type, algorithm, fingerprint type, etc., each 0–255 or 0–65535) before a record can be saved.
- Extend a DNS deployment toward DNSSEC/DANE workflows without writing custom code.
- See the shipped types appear automatically in the DNS record form's Type select once the submodule is enabled.
