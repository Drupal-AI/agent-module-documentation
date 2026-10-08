<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field IP address — agent index

Field type storing a **single IP or IP range** (IPv4/IPv6), packed for efficient range comparison.
Used by e.g. **IP Login** to map ranges to users. Depends on core `field`. Version **2.1.3**. Core
`^10||^11||^12`.

Storage/field primitive only — security implications come from the consuming module, not from storing
the value.
