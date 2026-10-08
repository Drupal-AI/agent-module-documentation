#!/usr/bin/env bash
# Execution VERIFY: PASS when an enabled CER preset corresponds field_cer_task_left with
# field_cer_task_right for node:article AND the relationship actually works -- the script
# creates two Articles, points Alpha.field_cer_task_left at Beta, saves, and requires that
# CER wrote Alpha into Beta.field_cer_task_right. Test nodes are always removed again.
# The live test is retried because a busy shared site can throw a transient InnoDB deadlock
# on the cache tables. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\node\Entity\Node;
  // Make sure this process sees fields created by a previous process.
  \Drupal::service("entity_field.manager")->clearCachedFieldDefinitions();
  \Drupal::service("entity_type.manager")->clearCachedDefinitions();

  $cfgOk = FALSE; $presetId = "none";
  foreach (\Drupal::entityTypeManager()->getStorage("corresponding_reference")->loadMultiple() as $p) {
    $fields = [$p->getFirstField(), $p->getSecondField()];
    sort($fields);
    $bundles = (array) $p->getBundles();
    $nodeBundles = (array) ($bundles["node"] ?? []);
    if ($fields === ["field_cer_task_left", "field_cer_task_right"]
        && $p->isEnabled()
        && (in_array("article", $nodeBundles, TRUE) || in_array("*", $nodeBundles, TRUE))) {
      $cfgOk = TRUE; $presetId = $p->id(); break;
    }
  }

  $syncOk = FALSE; $backrefs = "n/a";
  for ($attempt = 0; $attempt < 3 && !$syncOk; $attempt++) {
    try {
      $beta = Node::create(["type" => "article", "title" => "CER Verify Beta"]);
      $beta->save();
      $alpha = Node::create(["type" => "article", "title" => "CER Verify Alpha"]);
      $alpha->set("field_cer_task_left", [["target_id" => $beta->id()]]);
      $alpha->save();
      $betaReloaded = Node::load($beta->id());
      $ids = [];
      foreach ($betaReloaded->get("field_cer_task_right") as $item) { $ids[] = (int) $item->target_id; }
      $backrefs = implode(",", $ids);
      $syncOk = in_array((int) $alpha->id(), $ids, TRUE);
    }
    catch (\Throwable $e) { $backrefs = "ERROR:" . $e->getMessage(); }
    finally {
      $stale = \Drupal::entityTypeManager()->getStorage("node")
        ->loadByProperties(["title" => ["CER Verify Alpha", "CER Verify Beta"]]);
      foreach ($stale as $n) { $n->delete(); }
    }
  }

  $ok = $cfgOk && $syncOk;
  print ($ok ? "PASS" : "FAIL") . " preset=" . $presetId . " config_ok=" . var_export($cfgOk, TRUE)
    . " backref_ok=" . var_export($syncOk, TRUE) . " beta_right=[" . $backrefs . "]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
