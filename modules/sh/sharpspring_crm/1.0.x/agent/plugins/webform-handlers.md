<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SharpSpring Webform handlers

Two `@WebformHandler` plugins add SharpSpring behaviour to any Webform (Webform > Settings > Emails/Handlers).

## SharpSpringCrmLeadHandler (`sharpspring_crm_lead_handler`)
- Config form calls `SharpSpringCrm::getFields()` and renders a textfield per active SharpSpring field; you enter the **webform field machine name** to map into each.
- `postSave()` on a completed submission builds a `\stdClass` of mapped values and calls `SharpSpringCrm::createLeads()`.
- On failure it emails `backupEmailAddress` (mail key `backup_email`) with a link to the submission.

## SharpSpringCrmListHandler (`sharpspring_crm_list_handler`)
- Adds the submitter's email to a selected SharpSpring active list via `addListMemberEmailAddress()`.

Both require valid `account_id`/`secret_key`; an invalid pair makes the handler config form show a "no relevant fields" message.
