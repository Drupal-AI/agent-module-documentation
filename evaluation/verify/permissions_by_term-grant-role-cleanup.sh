#!/usr/bin/env bash
# Execution CLEANUP: delete the pbt_task_vocab vocabulary with its terms, the pbt_task_role role
# and every grant row for those terms. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\user\Entity\Role;
  $storage = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  $db = \Drupal::database();
  foreach ($storage->loadByProperties(["vid" => "pbt_task_vocab"]) as $term) {
    $db->delete("permissions_by_term_role")->condition("tid", $term->id())->execute();
    $db->delete("permissions_by_term_user")->condition("tid", $term->id())->execute();
    $term->delete();
  }
  if ($v = Vocabulary::load("pbt_task_vocab")) { $v->delete(); }
  if ($r = Role::load("pbt_task_role")) { $r->delete(); }
  print "cleaned\n";
' 2>/dev/null
echo "cleanup: pbt_task_vocab / pbt_task_role removed"
