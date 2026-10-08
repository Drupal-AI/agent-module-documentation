<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enabling & operating "Send draft link"

## Enable per webform
1. Webform → **Settings → Submissions** (`/admin/structure/webform/manage/{id}/settings/submissions`).
2. Under **Send draft link**, check "Allow users to send links to drafts by email".
3. The module's validator requires:
   - **Submission draft settings** must allow save-and-finish-later (`draft` ≠ `none`).
   - **Submission access token settings** must allow updating via secure token (`token_update` on).

## Runtime
- On draft save (`webform_submission_presave` / `webform_submission_form_alter`) the token URL from `$submission->getTokenUrl('update')` is stored in `\Drupal::state('webform_send_draft_link_settings')[webform_id]`.
- The "Send draft link" local task appears on the webform and submission view/edit/notes routes; `router.builder` is rebuilt on webform save to toggle the tab.
- `WebformSendDraftLinkForm` collects `to` (comma-separated emails, validated), `subject`, `message`; body = `Xss::filterAdmin(message)` + the link; sent per-recipient with `simple_mail_send()`.

## Cautions for reviewers
- `access()` (line 78) grants the form purely on the `enabled` flag + allowed route — add path/role restrictions on public webforms.
- State is keyed by webform id, not per submission/user — the tab always sends the **latest** draft's link. Treat this as a cross-user disclosure risk.
