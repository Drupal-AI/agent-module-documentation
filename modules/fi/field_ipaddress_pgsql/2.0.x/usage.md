<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field IP address PostgreSQL provides IP-address field types stored as PostgreSQL network address types.

---

Field IP address PostgreSQL **provides IP-address field types backed by PostgreSQL network types** — storing
and processing IP addresses/ranges using PostgreSQL's native `inet`/`cidr` network address column types, enabling
efficient IP matching. It works on core 11 (and requires a PostgreSQL database).

Use it to store IPs with native PostgreSQL types. It is a field-types/developer feature. Data-handling note: IP
addresses are **personal data** in many jurisdictions — handle stored IPs per your privacy policy, and note it is
**PostgreSQL-specific** (it uses PG network types, so it won't work on MySQL/MariaDB). It has no access-control
role. Configure the IP-address field.

---

- Store IPs as PostgreSQL network types.
- Use inet/cidr columns.
- Enable efficient IP matching.
- Require a PostgreSQL database.
- Serve field types/developers.
- Process IP addresses/ranges.
- TREAT IP addresses as personal data (handle per policy).
- BE PostgreSQL-specific (won't work on MySQL/MariaDB).
- Have no access-control role.
- Configure the IP-address field.
- Handle IP fields.
- Store IPs.
- Configure the field.
- Match IPs.
- Handle the field.
- Save addresses.
- Configure PostgreSQL.
- Handle the network types.
- Store ranges.
- Provide IP-address fields.
