#!/usr/bin/env bash
# Introspection cleanup: remove the known `eval_book` ECK entity type (and its `hardcover`
# bundle) installed by eck-book-setup.sh, restoring the baseline. Deleting the type
# uninstalls the dynamic content entity type and drops its DB tables. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $type = \Drupal\eck\Entity\EckEntityType::load("eval_book");
  if ($type) {
    if (\Drupal::entityTypeManager()->hasDefinition("eval_book_type")) {
      foreach (\Drupal::entityTypeManager()->getStorage("eval_book_type")->loadMultiple() as $b) { $b->delete(); }
    }
    $type->delete();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ECK type eval_book removed (tables dropped), baseline restored"
