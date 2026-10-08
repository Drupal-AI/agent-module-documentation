<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DNS — extras (dns_extras) — agent index

Optional submodule of the **dns** project that adds specialty `RecordType` plugins. Package `DNS`. Version `2.0.0-alpha3` (docs dir `2.0.x`). Core `^10.3 || ^11 || ^12`. License GPL-2.0-or-later.

## Dependencies

- **`dns:dns`** only (`dns_extras.info.yml`). No routes, permissions, services, config, or hooks of its own.

## What it provides

Seven `#[RecordType]` plugins in `src/Plugin/RecordType/`, discovered by the parent module's `plugin.manager.dns_record_type`:

- **DNAME** (`Dname`) — subtree delegation (RFC 6672); extends `RecordTypeBase` + `TargetHostnameTrait`, single `target`, no rdata.
- **SSHFP** (`Sshfp`), **TLSA** (`Tlsa`), **SMIMEA** (`Smimea`), **OPENPGPKEY** (`Openpgpkey`), **DS** (`Ds`), **DNSKEY** (`Dnskey`) — the hash-digest / key family, all extending `HashRecordTypeBase`.

Enabling the submodule just adds these ids to the DNS record form's Type select. See the parent's [plugin system doc](../../../2.0.x/agent/plugins/record-types.md).

## Solution docs

- [plugins/record-types.md](plugins/record-types.md) — `HashRecordTypeBase`, the seven types, storage shape, and validation.

## Tests

`tests/src/Kernel/Plugin/DnsExtrasDiscoveryTest.php`, `HashRecordTypeTest.php`.
