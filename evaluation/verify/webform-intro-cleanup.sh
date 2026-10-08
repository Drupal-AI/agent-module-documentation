#!/usr/bin/env bash
# Introspection cleanup: restore baseline after the eval_intro medium cases by removing every
# eval_intro webform_submission and the eval_intro webform config entity itself. Idempotent —
# a no-op if eval_intro does not exist.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("webform");
  $subs = \Drupal::entityTypeManager()->getStorage("webform_submission");
  $ids = $subs->getQuery()->condition("webform_id", "eval_intro")->accessCheck(FALSE)->execute();
  if ($ids) { $subs->delete($subs->loadMultiple($ids)); }
  if ($wf = $storage->load("eval_intro")) { $wf->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: eval_intro webform + submissions removed"
