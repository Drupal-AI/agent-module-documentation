#!/usr/bin/env bash
# Execution VERIFY: PASS when a node titled 'TEE Article Probe' exists AND RepositoryManager
# wraps it as the example's Article wrapped-entity class. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ids=\Drupal::entityQuery("node")->accessCheck(FALSE)->condition("type","article")->condition("title","TEE Article Probe")->execute();
  $ok=FALSE; $cls="none";
  if ($ids) {
    $node=\Drupal\node\Entity\Node::load(reset($ids));
    $w=\Drupal::service(\Drupal\typed_entity\RepositoryManager::class)->wrap($node);
    $cls=$w?get_class($w):"null";
    $ok=$w instanceof \Drupal\typed_entity_example\WrappedEntities\Article;
  }
  print ($ok?"PASS":"FAIL")." wrapper=".$cls."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
