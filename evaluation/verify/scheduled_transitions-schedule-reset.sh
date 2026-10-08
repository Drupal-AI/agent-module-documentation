#!/usr/bin/env bash
# Execution RESET: ensure a moderated namespaced content type schtr_page (on the editorial
# workflow) exists and is enabled for scheduled transitions, create a published node
# "ST Sched One", and delete any scheduled_transition already targeting it. Verify FAILS until
# the agent schedules an 'archived' transition for that node. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\node\Entity\Node;
  use Drupal\workflows\Entity\Workflow;
  if (!NodeType::load("schtr_page")) { NodeType::create(["type"=>"schtr_page","name"=>"ST Page"])->save(); }
  $wf = Workflow::load("editorial");
  $plugin = $wf->getTypePlugin();
  if (!in_array("schtr_page", $plugin->getBundlesForEntityType("node"), TRUE)) {
    $plugin->addEntityTypeAndBundle("node", "schtr_page");
    $wf->save();
  }
  // Enable the bundle for scheduled transitions.
  $c = \Drupal::configFactory()->getEditable("scheduled_transitions.settings");
  $bundles = $c->get("bundles") ?: [];
  $has = FALSE;
  foreach ($bundles as $b) { if (($b["entity_type"]??"")==="node" && ($b["bundle"]??"")==="schtr_page") { $has = TRUE; } }
  if (!$has) { $bundles[] = ["entity_type"=>"node","bundle"=>"schtr_page"]; $c->set("bundles",$bundles)->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
drush php:eval '
  use Drupal\node\Entity\Node;
  // Delete existing test nodes + their scheduled transitions.
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title"=>"ST Sched One"]) as $n) {
    $sts = \Drupal::entityTypeManager()->getStorage("scheduled_transition")->getQuery()->accessCheck(FALSE)
      ->condition("entity__target_type","node")->condition("entity__target_id",$n->id())->execute();
    if ($sts) { $s = \Drupal::entityTypeManager()->getStorage("scheduled_transition"); $s->delete($s->loadMultiple($sts)); }
    $n->delete();
  }
  $node = Node::create(["type"=>"schtr_page","title"=>"ST Sched One","moderation_state"=>"published"]);
  $node->save();
  print "nid=".$node->id()."\n";
' 2>/dev/null
echo "reset: node 'ST Sched One' (schtr_page, published) present, no scheduled transitions"
