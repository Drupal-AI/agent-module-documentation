#!/usr/bin/env bash
# Introspection SETUP: create vocabulary micon_vocab_med with a Micon icon (fa-tags). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  $v = Vocabulary::load("micon_vocab_med") ?: Vocabulary::create(["vid"=>"micon_vocab_med","name"=>"Micon Vocab Med"]);
  $v->setThirdPartySetting("micon_vocabulary","icon","fa-tags");
  $v->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: vocabulary micon_vocab_med icon=fa-tags"
