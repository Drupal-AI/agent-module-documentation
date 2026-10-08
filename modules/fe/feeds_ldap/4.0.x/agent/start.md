<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Feeds LDAP — agent index

**Feeds fetcher + parser for LDAP** — runs an admin-configured LDAP query and turns directory entries
into Feeds results to auto-create/update content (staff directories, groups, org data). Depends on
`feeds`, `ldap_servers`, `ldap_query`. Version **4.0.0-beta2**. Core `^9.4||^10||^11`.

**Security:** trust boundary is the directory connection — protect LDAP bind credentials (in LDAP
Servers), prefer LDAPS/StartTLS. Query is admin-defined (not user LDAP-injection). Directory data
becomes content — treat as external input on display.
