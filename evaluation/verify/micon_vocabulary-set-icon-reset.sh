#!/usr/bin/env bash
# Execution RESET: ensure vocabulary micon_vocab_task exists with NO Micon icon. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  $v = Vocabulary::load("micon_vocab_task") ?: Vocabulary::create(["vid"=>"micon_vocab_task","name"=>"Micon Vocab Task"]);
  $v->unsetThirdPartySetting("micon_vocabulary","icon");
  $v->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: vocabulary micon_vocab_task present, no micon icon"
