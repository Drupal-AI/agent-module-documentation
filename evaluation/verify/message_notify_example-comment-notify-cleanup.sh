#!/usr/bin/env bash
# Execution CLEANUP: remove the example messages, the mne_post node(s) + comments, the comment
# field/type, the content type and the mne_author user created by the reset. Scoped to
# field_mne_* only (never a broad field purge). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (\Drupal::entityTypeManager()->getStorage("message")->loadByProperties(["template" => "example_create_comment"]) as $m) { $m->delete(); }
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["type" => "mne_post"]) as $n) {
    foreach (\Drupal::entityTypeManager()->getStorage("comment")->loadByProperties(["entity_id" => $n->id(), "comment_type" => "mne_comment"]) as $c) { $c->delete(); }
    $n->delete();
  }
  if ($fc = FieldConfig::loadByName("node", "mne_post", "field_mne_comments")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_mne_comments")) { $fs->delete(); }
  if ($ct = \Drupal\node\Entity\NodeType::load("mne_post")) { $ct->delete(); }
  if ($cmt = \Drupal\comment\Entity\CommentType::load("mne_comment")) { $cmt->delete(); }
  if ($u = user_load_by_name("mne_author")) { $u->delete(); }
' >/dev/null 2>&1
echo "cleanup: mne_post fixture, mne_author user and example messages removed"
