# Ban actions & the submission operation link

The whole operating surface of the module. Everything ends up calling core Ban's
`ban.ip_manager` service (`Drupal\ban\BanIpManager`) on the IP that Webform stored for a submission
(`WebformSubmission::getRemoteAddr()`). The module never blocks a submission itself; once an IP is in
core's ban list, core Ban's middleware answers 403 to that IP site-wide.

## Operation link — `hook_entity_operation()`

`webform_ban.module` implements `hook_entity_operation()`. For each `webform_submission` entity it
adds a `block` operation (title **"Ban IP Address"**, weight 100) **only when all of**:

- `\Drupal::moduleHandler()->moduleExists('ban')` is true, and
- `\Drupal::currentUser()->hasPermission('ban IP addresses')`, and
- `$ban_ip_manager->isBanned($entity->getRemoteAddr())` is false (hidden once already banned).

The link is navigational: it opens `Url::fromRoute('ban.admin_page', ['default_ip' => <remote_addr>])`
in a narrow modal (`WebformDialogHelper::getModalDialogAttributes(WebformDialogHelper::DIALOG_NARROW)`).
It does not ban on click — the admin still submits core Ban's form (Form-API/CSRF protected) on
`/admin/config/people/ban`, which is itself gated by core Ban's `ban IP addresses` permission.

## Action — `webform_submission_ban_ip_address`

Class `Drupal\webform_ban\Plugin\Action\WebformSubmissionBanIpAddress` (extends
`Drupal\Core\Action\ActionBase`), type `webform_submission`.

```php
public function execute($entity = NULL) {
  $ban_ip_manager = \Drupal::service('ban.ip_manager');
  if (!$ban_ip_manager->isBanned($entity->getRemoteAddr())) {
    $ban_ip_manager->banIp($entity->getRemoteAddr());
  }
}

public function access($object, AccountInterface $account = NULL, $return_as_object = FALSE) {
  return $account->hasPermission('ban IP addresses');
}
```

Runs from the webform-submission results table's bulk "Action" select (a POST form with a CSRF
token). Access requires the **`ban IP addresses`** permission.

## Action — `webform_submission_ban_and_delete_action`

Class `…\WebformSubmissionBanAndDeleteAction` (extends webform's `WebformSubmissionDeleteAction`,
which is core `DeleteAction`), type `webform_submission`,
`confirm_form_route_name = webform_submission.multiple_delete_confirm`.

```php
public function executeMultiple(array $entities) {
  $ban_ip_manager = \Drupal::service('ban.ip_manager');
  foreach ($entities as $entity) {
    if (!$ban_ip_manager->isBanned($entity->getRemoteAddr())) {
      $ban_ip_manager->banIp($entity->getRemoteAddr());
    }
  }
  parent::executeMultiple($entities);
}
```

It bans every selected submission's IP, then defers to the parent delete flow (stashes the selection
in the `entity_delete_multiple_confirm` tempstore and redirects to the multi-delete confirm form).
Its access is the parent core `DeleteAction::access()` — `$object->access('delete', $account)` on
each webform submission.

## Notes for agents

- Both action config entities ship in `config/install`
  (`system.action.webform_submission_ban_ip_address`,
  `system.action.webform_submission_ban_and_delete_action`) so the actions appear on install even
  though the module's info.yml does not depend on `ban`.
- The IP acted on is whatever Webform stored as the submission's `remote_addr` at submit time (from
  core's `Request::getClientIp()`), not a live request value. Behind a reverse proxy this is only the
  real client IP if Drupal's trusted-proxy / trusted-header settings are configured; otherwise it is
  the proxy address. Banning is also IP-granular, so a shared/CGNAT IP bans every visitor behind it.
- If `ban` is disabled, `\Drupal::service('ban.ip_manager')` does not exist and executing either
  action throws; the operation link, by contrast, is guarded by `moduleExists('ban')`.
