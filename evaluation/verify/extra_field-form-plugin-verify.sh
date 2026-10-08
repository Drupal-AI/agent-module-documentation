#!/usr/bin/env bash
# Execution VERIFY: PASS when an ExtraFieldForm plugin with id efeval_note is registered, its
# pseudo-field extra_field_efeval_note is placed on
# core.entity_form_display.node.article.default, and building a real Article node form
# actually contains the element extra_field_efeval_note. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $manager = \Drupal::service("plugin.manager.extra_field_form");
  $has = $manager->hasDefinition("efeval_note");
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $placed = $fd && $fd->getComponent("extra_field_efeval_note") !== NULL;
  $inForm = FALSE;
  if ($has && $placed) {
    \Drupal::currentUser()->setAccount(\Drupal\user\Entity\User::load(1));
    $node = \Drupal::entityTypeManager()->getStorage("node")->create(["type" => "article"]);
    $form = \Drupal::service("entity.form_builder")->getForm($node, "default");
    $inForm = isset($form["extra_field_efeval_note"]);
  }
  $ok = $has && $placed && $inForm;
  print ($ok ? "PASS" : "FAIL") . " definition=" . ($has ? "yes" : "no")
    . " placed=" . ($placed ? "yes" : "no")
    . " in_node_form=" . ($inForm ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
