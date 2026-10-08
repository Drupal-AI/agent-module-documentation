<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User Export CSV & VCF lets administrators export selected user accounts as CSV or VCF (vCard) files, driven by Drupal's bulk-operation actions on the People page.
---
On install the module adds Full name (`field_full_name`) and Phone number (`field_phone_number`) fields to user profiles, and provides two bulk actions ("Download User CSV", "Download User VCF") plus download controllers. From `/admin/people` an admin selects users and runs an action to get a single CSV file or a multi-entry VCF; a per-user download link also appears under the operations dropdown. Exported fields include full name, phone, email, address (`field_address`), comment (`field_comment`), and (for VCF) the user picture embedded as base64 JPEG. It relies on the `phone_number`, `address` and `action` contrib modules.

Setup requires no configuration — enable, ensure the added fields are populated, and use the People page.
---
- Export selected users to a single CSV file.
- Export selected users to a multi-entry VCF/vCard file.
- Download a vCard for one user from the operations dropdown.
- Bulk-export contacts from `/admin/people`.
- Include full name and phone number in exports.
- Include email and postal address in exports.
- Embed the user picture as base64 JPEG in a VCF.
- Import exported vCards into a phone or address book.
- Generate contact cards for staff or members.
- Use core bulk actions (no Views required).
- Add Full name / Phone number fields to users on install.
- Populate the address field for richer exports.
- Export a comment/notes field per user.
- Produce a mailing list as CSV.
- Hand off attendee contacts as vCards.
- Migrate user contact data to another system.
- Create per-user downloadable business cards.
- Batch-generate vCards for an event roster.
- Restrict who can run the export actions.
- Support Drupal 10 and 11 people management.
