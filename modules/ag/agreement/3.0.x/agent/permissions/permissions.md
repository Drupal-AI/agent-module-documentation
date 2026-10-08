# Permissions

Defined in `agreement.permissions.yml`.

| Permission | Restrict access | Gates |
|---|---|---|
| `administer agreements` | yes | All admin routes (`entity.agreement.collection`, `agreement.add`, `entity.agreement.edit_form`, `entity.agreement.delete_form`) and the `agreements` records View. Also the config entity `admin_permission`. |
| `bypass agreement` | — | Holder is never redirected to any agreement. `AgreementSubscriber` and `AgreementHandler::canAgree()` both short-circuit for this permission. |
| `revoke own agreement` | — | Lets a user re-open the checkbox on an already-accepted agreement and un-check it to withdraw consent (records `agreed = 0`). Without it the checkbox/submit are hidden once accepted. |

Notes for operators:
- Grant `bypass agreement` to deployment, monitoring and support accounts **before** enabling an
  agreement — otherwise every request from those accounts is redirected to the agreement page.
- The acceptance page itself (route `agreement.<id>`) only requires core `access content`; the
  checkbox and submit button are additionally gated in the form by `canAgree()` (not bypassed AND
  the account holds one of the agreement's roles), so a visitor outside the target roles can view
  the page but cannot submit an acceptance.
- Acceptance is always written for the current authenticated user (`current_user`); there is no
  user-id input, so a user cannot record acceptance on behalf of another account.
