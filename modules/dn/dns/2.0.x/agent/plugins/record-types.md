<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DNS — the RecordType plugin system

## The plugin type

- Manager: `RecordTypeManager` (`src/RecordTypeManager.php`), service `plugin.manager.dns_record_type` (`parent: default_plugin_manager`). Discovers `Plugin/RecordType/` namespaces, interface `RecordTypeInterface`, attribute `#[RecordType]`, alter hook `dns_record_type_info`, cache key `dns_record_type_plugins`.
- Attribute: `Attribute\RecordType` — `id` (the record-type token, e.g. `A`, `MX`), `label` (TranslatableMarkup), optional `description`.
- Interface `Plugin\RecordType\RecordTypeInterface`, base `RecordTypeBase` (no-op defaults + `getSubmittedRdata()` / `getRdataValue()` helpers; `FORM_KEY_RDATA = 'rdata'`).

Plugin ids become the `dns_record.record_type` allowed values (`DnsRecord::recordTypeAllowedValues()`), so enabling a module that adds a plugin immediately adds a selectable type.

## The five contract methods

1. `usedFields(): array` — which shared base fields the type shows: subset of `['ip_address', 'target']`; `[]` means everything lives in `rdata`. The form (`DnsRecordForm`) sets `#access` and `#required` on these accordingly and clears unclaimed fields on save.
2. `buildForm($form, $form_state, $record): array` — extra form elements for long-tail data, rendered under an "Additional record data" fieldset (`#tree`) whose values are read from `rdata`.
3. `validateForm(&$form, $form_state, $record): void` — cross-cutting checks after field validation (e.g. A requires IPv4).
4. `applyToRecord($record, &$form, $form_state): void` — writes the plugin's `rdata` payload. The form pre-clears `rdata` before calling this, so a stale payload from a previously-selected type never persists.
5. `renderSummary($record): string` — one-line BIND-style value for list contexts (no prefix/type/TTL).

## Storage model

Shared base fields (`ip_address`, `target`) hold the common values; everything else is JSON in the `rdata` `string_long` field. The `RdataValue` Views field (see [../config/settings.md](../config/settings.md)) renders individual `rdata` keys as columns.

## Shipped core plugins (`src/Plugin/RecordType/`)

- **A** / **AAAA** — extend `SingleAddressRecordTypeBase`; use `ip_address`; enforce IPv4 / IPv6 family respectively.
- **CNAME** / **NS** / **PTR** — extend `RecordTypeBase` with `TargetHostnameTrait`; single `target` hostname, no `rdata`.
- **MX** — `RecordTypeBase` + `TargetHostnameTrait`; `target` + `rdata.priority` (uint16).
- **SRV** — `target` + `rdata.priority/weight/port` (each uint16 0–65535; `validateU16()`).
- **TXT** — no base field; `rdata.content` (≤4096 chars, NUL bytes rejected); summary is quoted, truncated at 80 chars.
- **CAA** — no base field; `rdata.tag` (`issue`/`issuewild`/`iodef`), `rdata.value`, `rdata.critical` (RFC 8659).
- **HTTPS** / **SVCB** — service-binding types; extend `ServiceBindingRecordTypeBase`, using `Utility\SvcParams` for SvcParam key/value handling.

Support classes: `RecordTypeBase`, `SingleAddressRecordTypeBase`, `ServiceBindingRecordTypeBase`, `TargetHostnameTrait` (BIND target validate/render), `Utility\SvcParams`, `Utility\ZoneNameTransformer`, `Utility\LabelValidationError`.

## Adding a record type

Drop a class in any module's `Plugin/RecordType/`:

```php
#[RecordType(id: 'MY', label: new TranslatableMarkup('My type'))]
final class My extends RecordTypeBase {
  public function usedFields(): array { return ['target']; }
  // buildForm()/validateForm()/applyToRecord()/renderSummary() as needed
}
```

Clear caches; the id appears in the record form's Type select automatically. This is exactly what the **`dns_extras`** submodule does — see `modules/dns_extras/2.0.x/`.
