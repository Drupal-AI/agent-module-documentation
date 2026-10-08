<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WSLA (Webform File Upload to Salesforce) — agent index

On-disk dir **wsla**, machine name **webform_file_upload_to_salesforce**. Event subscriber on Salesforce push: reads submission's managed **File** entities, creates SF **Attachment** records, links lead to a **Campaign** (CampaignMember). Deps `salesforce:salesforce_push`, `webform`. Version **1.1.0**, core `^9||^10`. Files come from managed File entities (not arbitrary paths).