<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The resend action — route, permission, access & confirm form

## Install / enable
`composer require drupal/simplenews_resend` then `drush en simplenews_resend`. Requires `simplenews`
(declared in `simplenews_resend.info.yml` as `simplenews:simplenews`). Nothing to configure — no
settings form, no config objects, no config schema. Grant the `reset simplenews status` permission
(defined in `simplenews_resend.permissions.yml`) to the roles allowed to re-open sends.

## What "resend" actually does
It does **not** send mail. It resets the newsletter issue's status field so Simplenews will send it
again. `SimplenewsResendForm::resetStatus()` (`src/Form/SimplenewsResendForm.php`) sets
`$this->entity->simplenews_issue->status = SIMPLENEWS_STATUS_SEND_NOT;` and calls `$this->entity->save()`.
After that the issue is "not sent" as far as Simplenews is concerned, and the normal Simplenews send
UI/spool/cron path is available again. Who receives the follow-up send, and whether anyone is
duplicated, is Simplenews' responsibility (newsletter category + its spool/subscription handling), not
this module's.

Relevant Simplenews status constants (from `simplenews.module`): `SIMPLENEWS_STATUS_SEND_NOT = 0`
(not sent), and `SIMPLENEWS_STATUS_SEND_READY` (the issue has finished sending). The action only
targets issues currently at `SEND_READY`.

## Route
From `simplenews_resend.routing.yml`:

```yaml
entity.node.resend_status:
  path: '/node/{node}/resend'
  defaults:
    _entity_form: 'node.simplenews_resend'
    _title: 'Resend newsletter'
  requirements:
    _reset_newsletter_status: true
```

`_entity_form: 'node.simplenews_resend'` resolves to the `simplenews_resend` form handler on the node
entity type, wired up in `simplenews_resend_entity_type_build()` (`.module`):
`$entity_types['node']->setFormClass('simplenews_resend', SimplenewsResendForm::class);`.

## Permission & access checking
The route's only requirement is `_reset_newsletter_status: true`, handled by the tagged service
`access_check.simplenews_resend.reset_newsletter_status` →
`Drupal\simplenews_resend\Access\ResetNewsletterStatusAccessChecker` (`simplenews_resend.services.yml`,
`applies_to: _reset_newsletter_status`).

`ResetNewsletterStatusAccessChecker::access(NodeInterface $node, AccountInterface $account)`:

```php
if (simplenews_check_node_types($node->getType())) {
  if ($node->simplenews_issue->status == SIMPLENEWS_STATUS_SEND_READY) {
    return AccessResult::allowedIfHasPermission($account, 'reset simplenews status');
  }
}
return AccessResult::neutral();
```

So access is granted only when **all** of: the node's bundle is a Simplenews newsletter type
(`simplenews_check_node_types()`), the issue has actually finished sending (status `SEND_READY`), and
the account holds the `reset simplenews status` permission. Any other case returns `neutral()` — and
because no other access check grants the route, neutral resolves to access denied. This is why the
README notes the option only appears once an issue has been sent (never for unsent or still-sending
issues).

## How the action surfaces in the UI
- **Node operation** — `simplenews_resend_entity_operation_alter()` (`.module`) adds a `resend`
  operation titled "Reset newsletter status" (weight 20) for `NodeInterface` entities, but only after
  `Url::fromRoute('entity.node.resend_status', ['node' => $entity->id()])->access()` passes — i.e. the
  same access checker above. So it shows up in the Newsletter Issues listing only for sent issues the
  user may reset.
- **Local task tab** — `simplenews_resend.links.task.yml` adds tab `entity.node.resend_status`
  (base route `entity.node.canonical`, title "Reset newsletter status").

## Confirm form flow
`SimplenewsResendForm extends ContentEntityConfirmFormBase` (`src/Form/SimplenewsResendForm.php`):
- `getQuestion()` → "Are you sure you want to reset the status of %entity?"
- `getConfirmText()` → "Reset"
- `getCancelUrl()` → the node's canonical page (`entity.node.canonical`).
- `submitForm()` → calls `resetStatus()`, shows "Newsletter %label has been reset.", logs a `notice`
  to the `simplenews_resend` channel, and redirects to the cancel URL.

Being a confirm form, the reset is performed only on the POST submission with a valid form token — a
plain GET of `/node/{node}/resend` just renders the confirmation question.

## Operate it
1. Grant `reset simplenews status` to trusted roles.
2. Go to Content → Newsletter Issues, open the operations dropdown on a **sent** issue, choose
   "Reset newsletter status" (or visit the node's "Reset newsletter status" tab).
3. Confirm on the "Reset" screen. The issue returns to "not sent".
4. Send it again through Simplenews' normal newsletter send UI/spool as needed — choosing the intended
   newsletter category first, since this module does not pick recipients.
