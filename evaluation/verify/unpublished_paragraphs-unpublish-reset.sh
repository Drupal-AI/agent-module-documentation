#!/usr/bin/env bash
# Execution RESET: ensure the up_* structure exists and create node 'UP Toggle Node' with a
# PUBLISHED paragraph whose body is 'Toggle target block', so verify FAILS until the agent
# unpublishes that paragraph. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
use Drupal\paragraphs\Entity\ParagraphsType; use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig; use Drupal\node\Entity\NodeType;
if (!ParagraphsType::load("up_text")) { ParagraphsType::create(["id"=>"up_text","label"=>"UP Text"])->save(); }
if (!FieldStorageConfig::loadByName("paragraph","field_up_body")) { FieldStorageConfig::create(["field_name"=>"field_up_body","entity_type"=>"paragraph","type"=>"string"])->save(); }
if (!FieldConfig::loadByName("paragraph","up_text","field_up_body")) { FieldConfig::create(["field_name"=>"field_up_body","entity_type"=>"paragraph","bundle"=>"up_text","label"=>"Body"])->save(); }
if (!NodeType::load("up_page")) { NodeType::create(["type"=>"up_page","name"=>"UP Page"])->save(); }
if (!FieldStorageConfig::loadByName("node","field_up_paras")) { FieldStorageConfig::create(["field_name"=>"field_up_paras","entity_type"=>"node","type"=>"entity_reference_revisions","settings"=>["target_type"=>"paragraph"],"cardinality"=>-1])->save(); }
if (!FieldConfig::loadByName("node","up_page","field_up_paras")) { FieldConfig::create(["field_name"=>"field_up_paras","entity_type"=>"node","bundle"=>"up_page","label"=>"Paragraphs","settings"=>["handler"=>"default:paragraph","handler_settings"=>["target_bundles"=>["up_text"=>"up_text"]]]])->save(); }
use Drupal\paragraphs\Entity\Paragraph; use Drupal\node\Entity\Node;
$nst=\Drupal::entityTypeManager()->getStorage("node");
foreach($nst->loadByProperties(["type"=>"up_page","title"=>"UP Toggle Node"]) as $n){$n->delete();}
$pst=\Drupal::entityTypeManager()->getStorage("paragraph");
foreach($pst->loadByProperties(["field_up_body"=>"Toggle target block"]) as $p){$p->delete();}
$p=Paragraph::create(["type"=>"up_text","field_up_body"=>"Toggle target block","status"=>1]); $p->save();
Node::create(["type"=>"up_page","title"=>"UP Toggle Node","field_up_paras"=>[$p]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: UP Toggle Node with PUBLISHED paragraph 'Toggle target block'"
