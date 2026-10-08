#!/usr/bin/env bash
# Execution CLEANUP: remove test node + its scheduled transitions, unenable the bundle, remove
# schtr_page from the editorial workflow, and delete the content type.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\workflows\Entity\Workflow;
  $s = \Drupal::entityTypeManager()->getStorage("scheduled_transition");
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title"=>"ST Sched One"]) as $n) {
    $ids = $s->getQuery()->accessCheck(FALSE)->condition("entity__target_type","node")->condition("entity__target_id",$n->id())->execute();
    if ($ids) { $s->delete($s->loadMultiple($ids)); }
    $n->delete();
  }
  $c = \Drupal::configFactory()->getEditable("scheduled_transitions.settings");
  $bundles = array_values(array_filter($c->get("bundles") ?: [], fn($b)=>!(($b["entity_type"]??"")==="node" && ($b["bundle"]??"")==="schtr_page")));
  $c->set("bundles",$bundles)->save();
  if ($wf = Workflow::load("editorial")) {
    $p = $wf->getTypePlugin();
    if (in_array("schtr_page", $p->getBundlesForEntityType("node"), TRUE)) { $p->removeEntityTypeAndBundle("node","schtr_page"); $wf->save(); }
  }
  if ($t = NodeType::load("schtr_page")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ST Sched One + scheduled transitions removed, bundle unenabled, schtr_page deleted"
