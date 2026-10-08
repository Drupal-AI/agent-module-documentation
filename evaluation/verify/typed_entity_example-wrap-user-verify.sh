#!/usr/bin/env bash
# Execution VERIFY: PASS when a user with email tee_probe_user@example.com exists AND
# RepositoryManager wraps it as the example's User wrapped-entity class. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ids=\Drupal::entityQuery("user")->accessCheck(FALSE)->condition("mail","tee_probe_user@example.com")->execute();
  $ok=FALSE; $cls="none";
  if ($ids) {
    $u=\Drupal\user\Entity\User::load(reset($ids));
    $w=\Drupal::service(\Drupal\typed_entity\RepositoryManager::class)->wrap($u);
    $cls=$w?get_class($w):"null";
    $ok=$w instanceof \Drupal\typed_entity_example\WrappedEntities\User;
  }
  print ($ok?"PASS":"FAIL")." wrapper=".$cls."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
