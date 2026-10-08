<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EtherAPI — configuration

Route `etherapi.settings` → `/admin/config/development/etherapi`, permission **access etherapi settings** (`restrict access: true`). Config object `etherapi.settings`, stored under a top-level `config` array.

Install default (`config/install/etherapi.settings.yml`):
```yaml
config:
  key: ''
  address: ''
  currency: ETH
  REMOTE_ADDR: 88.99.198.205
```

Key settings the callback reads:
- `config.currency` — default currency (e.g. `ETH`) applied to new payments.
- `config.keys[<CURRENCY>].key` — the etherapi.net API key **per currency**; this value is the shared secret for the `sign` verification. **Set it** for every currency.
- `config.REMOTE_ADDR` — newline-separated IP allow-list; if non-empty, `status` POSTs from other IPs get a 404.
- `config.address` — receiving wallet address surfaced on the pay form.

## DB table `payments_etherapi`
Columns: `id, nid, sid, uid, created, paytime, amount, currency, status, data`. Status flow `new` → `pay`. `data` holds `serialize()`d payment/POST detail.
