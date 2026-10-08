<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field IP address provides a field for storing a single IP address or a range of IPs, supporting both IPv4 and IPv6.

---

Field IP address provides a field type that holds a single IP address or an IP range, for both
IPv4 and IPv6. It stores addresses in a form suitable for range comparisons (packed binary), so other
modules can query "is this IP within the stored range" efficiently — for example IP Login uses it to
map IP ranges to user accounts. It depends on core Field.

Use it whenever content or user entities need to record IPs or CIDR-style ranges — allow-lists,
per-user network mappings, geo/network metadata. It is a storage/field primitive with no behaviour of
its own beyond holding and validating the value; how the IP is used (access, matching) is up to the
consuming module. Any security implication comes from that consumer, not from storing the value.

---

- Store a single IP address in a field.
- Store an IP range in a field.
- Support IPv4 and IPv6.
- Hold CIDR-style network ranges.
- Enable efficient IP-in-range queries.
- Back IP Login's per-user ranges.
- Record network metadata on entities.
- Build an IP allow-list field.
- Depend on core Field.
- Validate IP values on entry.
- Store addresses for range comparison.
- Provide a reusable IP field primitive.
- Attach IPs to users or content.
- Map ranges for consuming modules.
- Store packed binary for comparison.
- Add network fields to entities.
- Hold geo/network data.
- Let other modules query the range.
- Provide storage only, no access logic.
- Support single or range input.
