#!/usr/bin/env bash
# Introspection SETUP (shared): build a namespaced Paragraphs fixture: content type up_page with
# a paragraphs field field_up_paras, paragraph type up_text with field_up_body, and one node
# 'UP Fixture Node' containing a published paragraph and one UNPUBLISHED paragraph. Idempotent.
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
foreach($nst->loadByProperties(["type"=>"up_page","title"=>"UP Fixture Node"]) as $n){$n->delete();}
$pst=\Drupal::entityTypeManager()->getStorage("paragraph");
foreach(["Published intro block","Secret unpublished block"] as $b){foreach($pst->loadByProperties(["field_up_body"=>$b]) as $p){$p->delete();}}
$p1=Paragraph::create(["type"=>"up_text","field_up_body"=>"Published intro block","status"=>1]); $p1->save();
$p2=Paragraph::create(["type"=>"up_text","field_up_body"=>"Secret unpublished block","status"=>0]); $p2->save();
Node::create(["type"=>"up_page","title"=>"UP Fixture Node","field_up_paras"=>[$p1,$p2]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: UP Fixture Node with 1 published + 1 unpublished (Secret unpublished block) paragraph"
