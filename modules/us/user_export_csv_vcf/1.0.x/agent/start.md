<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User Export CSV & VCF (user_export_csv_vcf) — agent index
**Exports selected users as CSV or VCF (vCard) via bulk actions on the People page.**

- **Version:** 1.0.x (1.0.0-beta1)
- **Core:** ^10 || ^11
- **Depends on:** phone_number, action, address
- **Install:** adds `field_full_name` and `field_phone_number` to users.
- **Actions:** DownloadUserCsvAction, DownloadUserVcfAction (run from `/admin/people`).
- **Routes:** `user_export_csv_vcf.download_user_export_csv_vcf` `/user/{uid}/download-user_export_csv_vcf` (`_access: 'TRUE'`); `user_export_csv_vcf.download_csv` `/user_export_csv_vcf/download/csv/{uid}` (`access content`).
