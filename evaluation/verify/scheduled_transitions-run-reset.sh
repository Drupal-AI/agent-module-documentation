#!/usr/bin/env bash
# Execution RESET: ensure moderated content type schtr_page exists on the editorial workflow and
# is enabled; create published node "ST Run One"; create a scheduled_transition due IN THE PAST
# that targets 'archived'; enable retain_processed so the record survives for inspection. Verify
# FAILS until the transition is processed and the node becomes archived. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\workflows\Entity\Workflow;
  if (!NodeType::load("schtr_page")) { NodeType::create(["type"=>"schtr_page","name"=>"ST Page"])->save(); }
  $wf = Workflow::load("editorial"); $plugin = $wf->getTypePlugin();
  if (!in_array("schtr_page", $plugin->getBundlesForEntityType("node"), TRUE)) { $plugin->addEntityTypeAndBundle("node","schtr_page"); $wf->save(); }
  $c = \Drupal::configFactory()->getEditable("scheduled_transitions.settings");
  $bundles = $c->get("bundles") ?: []; $has=FALSE;
  foreach ($bundles as $b) { if (($b["entity_type"]??"")==="node" && ($b["bundle"]??"")==="schtr_page") { $has=TRUE; } }
  if (!$has) { $bundles[] = ["entity_type"=>"node","bundle"=>"schtr_page"]; $c->set("bundles",$bundles); }
  $c->set("retain_processed.enabled", TRUE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
drush php:eval '
  use Drupal\node\Entity\Node;
  use Drupal\scheduled_transitions\Entity\ScheduledTransition;
  use Drupal\workflows\Entity\Workflow;
  $s = \Drupal::entityTypeManager()->getStorage("scheduled_transition");
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title"=>"ST Run One"]) as $n) {
    $ids = $s->getQuery()->accessCheck(FALSE)->condition("entity__target_type","node")->condition("entity__target_id",$n->id())->execute();
    if ($ids) { $s->delete($s->loadMultiple($ids)); }
    $n->delete();
  }
  $node = Node::create(["type"=>"schtr_page","title"=>"ST Run One","moderation_state"=>"published"]); $node->save();
  $wf = Workflow::load("editorial");
  $when = new \DateTime("@".(\Drupal::time()->getRequestTime() - 3600));
  $st = ScheduledTransition::createFrom($wf, "archived", $node, $when, \Drupal::entityTypeManager()->getStorage("user")->load(1));
  $st->save();
  print "nid=".$node->id()." st=".$st->id()."\n";
' 2>/dev/null
echo "reset: node 'ST Run One' published + a past-due scheduled_transition to archived"
