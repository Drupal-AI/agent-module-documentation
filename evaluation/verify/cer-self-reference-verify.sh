#!/usr/bin/env bash
# Execution VERIFY: PASS when an enabled CER preset makes field_cer_buddy correspond to
# itself for node:article with add_direction 'prepend', AND the relationship really is
# reciprocal on the live site. Test nodes are always removed again. The live test is retried
# because a busy shared site can throw a transient InnoDB deadlock on the cache tables.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\node\Entity\Node;
  // Make sure this process sees fields created by a previous process.
  \Drupal::service("entity_field.manager")->clearCachedFieldDefinitions();
  \Drupal::service("entity_type.manager")->clearCachedDefinitions();

  $cfgOk = FALSE; $presetId = "none"; $direction = "n/a";
  foreach (\Drupal::entityTypeManager()->getStorage("corresponding_reference")->loadMultiple() as $p) {
    $bundles = (array) $p->getBundles();
    $nodeBundles = (array) ($bundles["node"] ?? []);
    if ($p->getFirstField() === "field_cer_buddy" && $p->getSecondField() === "field_cer_buddy"
        && $p->isEnabled() && $p->getAddDirection() === "prepend"
        && (in_array("article", $nodeBundles, TRUE) || in_array("*", $nodeBundles, TRUE))) {
      $cfgOk = TRUE; $presetId = $p->id(); $direction = $p->getAddDirection(); break;
    }
  }

  $syncOk = FALSE; $backrefs = "n/a";
  for ($attempt = 0; $attempt < 3 && !$syncOk; $attempt++) {
    try {
      $two = Node::create(["type" => "article", "title" => "CER Buddy Two"]);
      $two->save();
      $one = Node::create(["type" => "article", "title" => "CER Buddy One"]);
      $one->set("field_cer_buddy", [["target_id" => $two->id()]]);
      $one->save();
      $twoReloaded = Node::load($two->id());
      $ids = [];
      foreach ($twoReloaded->get("field_cer_buddy") as $item) { $ids[] = (int) $item->target_id; }
      $backrefs = implode(",", $ids);
      $syncOk = in_array((int) $one->id(), $ids, TRUE);
    }
    catch (\Throwable $e) { $backrefs = "ERROR:" . $e->getMessage(); }
    finally {
      $stale = \Drupal::entityTypeManager()->getStorage("node")
        ->loadByProperties(["title" => ["CER Buddy One", "CER Buddy Two"]]);
      foreach ($stale as $n) { $n->delete(); }
    }
  }

  $ok = $cfgOk && $syncOk;
  print ($ok ? "PASS" : "FAIL") . " preset=" . $presetId . " direction=" . $direction
    . " config_ok=" . var_export($cfgOk, TRUE) . " backref_ok=" . var_export($syncOk, TRUE)
    . " two_buddy=[" . $backrefs . "]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
