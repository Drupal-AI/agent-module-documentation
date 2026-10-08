#!/usr/bin/env bash
# Execution RESET for the "write an Advanced Queue job type plugin" case.
# Order matters: uninstall the module while its code is still on disk, drop the queue and
# its jobs, forcibly purge any leftover core.extension / system.schema entry, and only then
# delete the directory. Leaves verify FAILing on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall advancedqueue_eval -y >/dev/null 2>&1 || true
drush php:eval '
  use Drupal\advancedqueue\Entity\Queue;
  \Drupal::database()->delete("advancedqueue")->condition("queue_id", "advancedqueue_eval_queue")->execute();
  if ($q = Queue::load("advancedqueue_eval_queue")) { $q->delete(); }
  $config = \Drupal::configFactory()->getEditable("core.extension");
  $modules = $config->get("module") ?: [];
  if (array_key_exists("advancedqueue_eval", $modules)) {
    unset($modules["advancedqueue_eval"]);
    $config->set("module", $modules)->save();
  }
  \Drupal::keyValue("system.schema")->delete("advancedqueue_eval");
' >/dev/null 2>&1
rm -rf web/modules/custom/advancedqueue_eval
drush cr >/dev/null 2>&1
echo "reset: advancedqueue_eval module and advancedqueue_eval_queue removed"
