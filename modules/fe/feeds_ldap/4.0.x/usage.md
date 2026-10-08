<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Feeds LDAP provides a Feeds fetcher for a generic LDAP query and a parser that turns LDAP entries into Feeds-compatible results, automating content creation from LDAP data.

---

Feeds LDAP extends the Feeds module with an LDAP fetcher and parser: it runs a configured LDAP query
(via the LDAP Servers / LDAP Query modules) and turns the returned directory entries into Feeds parser
results, so content can be created or updated automatically from an LDAP directory. Typical uses are
syncing people/staff directories, groups or org data from LDAP/Active Directory into Drupal content on
a schedule. It depends on `feeds`, `ldap_servers` and `ldap_query`.

Use it to automate content import from LDAP. The security-relevant aspects live in the LDAP
configuration it builds on: the LDAP server connection uses bind credentials configured in LDAP Servers
(store/protect those, and prefer LDAPS/StartTLS for the directory connection), and the query is
administrator-defined (not attacker-supplied), so LDAP-injection from end users is not the exposure —
the trust boundary is the directory connection and its credentials. It creates Drupal content from
directory data, so treat that data as external input on display.

---

- Import content from LDAP via Feeds.
- Run a generic LDAP query as a fetcher.
- Parse LDAP entries into Feeds results.
- Automate content creation from LDAP.
- Sync a staff directory from LDAP.
- Import groups/org data from AD.
- Depend on feeds, ldap_servers, ldap_query.
- Schedule LDAP-to-content sync.
- Use admin-defined LDAP queries.
- Protect LDAP bind credentials.
- Prefer LDAPS/StartTLS for the directory.
- Create Drupal content from directory data.
- Treat directory data as external input.
- Map LDAP attributes to fields.
- Update content from LDAP on cron.
- Build a people directory from LDAP.
- Fetch directory entries.
- Turn LDAP data into feed items.
- Configure the LDAP connection securely.
- Automate directory-driven content.
