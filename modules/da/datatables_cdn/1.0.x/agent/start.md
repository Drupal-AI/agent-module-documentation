<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# datatables_cdn — agent orientation

Registers Drupal libraries that load the DataTables jQuery plugin from `cdn.datatables.net` (external assets).

- Libraries: `datatables_cdn`, `datatables_responsive`, `datatables` (init). No routes/perms/services.
- SECURITY NOTE (low): external CDN scripts declared WITHOUT SRI → supply-chain/MITM risk. One URL is protocol-relative. Mitigate by self-hosting, SRI, or CSP.
- Declares an odd `ckeditor` module dependency.
- Read: `datatables_cdn.libraries.yml`.
