<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# dependent_country_state — agent orientation

Country/state/city/pincode reference data in custom tables, with admin CRUD + bulk import + JSON API for cascading selects.

- Admin routes: perm `dependent country state administrator` (restricted). API routes: per-endpoint restricted perms (`country/state/city/areapincode api access`) — NOT anon.
- API filter values (`id`, `*_name`, `pincode_area`) go through DB-API `->condition()` placeholders incl. LIKE — no SQLi. Filtered to `status=1`.
- Cosmetic bug: stray `"` in table-name strings (not injectable). No external calls/SSRF. Sound.
- Read: `src/Controller/APIController.php`, routing.yml, permissions.yml.
