#!/usr/bin/env bash
# Execution RESET for the comment->notify flow. Builds the fixture the example needs:
#  - content type mne_post with a comment field field_mne_comments (comment type mne_comment)
#  - a real (non-anonymous) user mne_author with an email (the notification recipient)
#  - a node of type mne_post owned by mne_author
# and removes any existing example_create_comment messages so verify FAILS on empty state.
# NOTE: node creation currently fails on this shared site because multiple node-access modules
# (content_access, nodeaccess, node_view_permissions, permissions_by_term, domain_access,
# unpublished_node_permissions) emit duplicate 'all/0' grants, so this reset cannot complete
# until that is resolved. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\node\Entity\Node;
  use Drupal\user\Entity\User;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\comment\Entity\CommentType;
  if (!NodeType::load("mne_post")) { NodeType::create(["type" => "mne_post", "name" => "MNE Post"])->save(); }
  if (!CommentType::load("mne_comment")) { CommentType::create(["id" => "mne_comment", "label" => "MNE Comment", "target_entity_type_id" => "node"])->save(); }
  if (!FieldStorageConfig::loadByName("node", "field_mne_comments")) {
    FieldStorageConfig::create(["field_name" => "field_mne_comments", "entity_type" => "node", "type" => "comment", "settings" => ["comment_type" => "mne_comment"]])->save();
  }
  if (!FieldConfig::loadByName("node", "mne_post", "field_mne_comments")) {
    FieldConfig::create(["field_name" => "field_mne_comments", "entity_type" => "node", "bundle" => "mne_post", "label" => "Comments", "settings" => ["default_mode" => 2, "per_page" => 50, "form_location" => 3, "anonymous" => 0, "preview" => 1]])->save();
  }
  $u = user_load_by_name("mne_author");
  if (!$u) { $u = User::create(["name" => "mne_author", "mail" => "mne_author@example.com", "status" => 1]); $u->save(); }
  // remove prior test messages
  foreach (\Drupal::entityTypeManager()->getStorage("message")->loadByProperties(["template" => "example_create_comment"]) as $m) { $m->delete(); }
  // remove prior test node/comments
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["type" => "mne_post"]) as $n) {
    foreach (\Drupal::entityTypeManager()->getStorage("comment")->loadByProperties(["entity_id" => $n->id(), "comment_type" => "mne_comment"]) as $c) { $c->delete(); }
    $n->delete();
  }
  $node = Node::create(["type" => "mne_post", "title" => "MNE eval node", "uid" => $u->id()]);
  $node->save();
  print "node=" . $node->id() . "\n";
' >/tmp/mne_reset.$$ 2>&1 || true
echo "reset: attempted mne_post fixture + mne_author user + node; example_create_comment messages cleared"
