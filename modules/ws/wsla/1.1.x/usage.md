<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WSLA attaches Webform file uploads to a Salesforce lead and links campaigns.

---

**Webform File Upload and Campaign as Salesforce Lead Attachment** (on-disk `wsla`, machine name `webform_file_upload_to_salesforce`) listens to Salesforce push events and, for a mapped Webform submission, reads uploaded managed files and creates Salesforce `Attachment` records against the pushed lead, and can add the lead to a Campaign as a `CampaignMember`. It depends on the Salesforce Suite (`salesforce_push`) and `webform`.

Files come from managed `File` entities on the submission (not arbitrary paths); records are created through the `salesforce.client` service.

---

- Attach Webform-uploaded files to a Salesforce lead.
- Create Salesforce Attachment records from submissions.
- Link a submission's lead to a Campaign.
- Add the lead as a CampaignMember.
- React to Salesforce push events.
- Read uploaded managed files by file ID.
- Base64-encode file content for Salesforce.
- Map Webform file fields to lead attachments.
- Depend on the Salesforce Suite push module.
- Depend on the Webform module.
- Use webform element properties as configuration.
- Push attachments via the salesforce.client service.
- Handle multiple file uploads per submission.
- Report errors when attachment upload fails.
- Set CampaignMember status to Sent.
- Automate lead enrichment from forms.
- Keep file transfer within managed File entities.
- Connect Webform submissions to Salesforce CRM.