#!/usr/bin/env bash
# Reset the eval_contact webform to a clean, known baseline between eval runs so each
# condition is independent: delete every webform_submission for eval_contact, then delete
# the eval_contact webform config entity itself. After this the form does not exist.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("webform");
  $subs = \Drupal::entityTypeManager()->getStorage("webform_submission");
  $ids = $subs->getQuery()->condition("webform_id", "eval_contact")->accessCheck(FALSE)->execute();
  if ($ids) { $subs->delete($subs->loadMultiple($ids)); }
  if ($wf = $storage->load("eval_contact")) { $wf->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: eval_contact webform + submissions removed"
