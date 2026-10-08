#!/usr/bin/env bash
# Introspection SETUP (bp_contact): bp_contact itself cannot be installed on Drupal 11
# (core_version_requirement ^8||^9||^10, and it needs the contrib module contact_formatter).
# So this stands up an equivalent of the structure it ships in config/install: a paragraph
# bundle bpcontact_eval carrying an entity_reference field to core's contact_form entity type,
# plus a core contact_form "bpcontact_eval_form", and a paragraph referencing it.
# The agent must inspect the live site to say which contact form is referenced.
# The bundle id is deliberately NOT bp_contact so it cannot collide with the real bundle.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\contact\Entity\ContactForm;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\paragraphs\Entity\Paragraph;
  use Drupal\paragraphs\Entity\ParagraphsType;
  if (!ContactForm::load("bpcontact_eval_form")) {
    ContactForm::create([
      "id" => "bpcontact_eval_form", "label" => "BP Contact Eval Form",
      "recipients" => ["bpcontact-eval@example.com"], "message" => "", "redirect" => "",
    ])->save();
  }
  if (!ParagraphsType::load("bpcontact_eval")) {
    ParagraphsType::create(["id" => "bpcontact_eval", "label" => "BP Contact Eval"])->save();
  }
  if (!FieldStorageConfig::loadByName("paragraph", "field_bpcontact_form")) {
    FieldStorageConfig::create([
      "field_name" => "field_bpcontact_form", "entity_type" => "paragraph",
      "type" => "entity_reference", "cardinality" => 1,
      "settings" => ["target_type" => "contact_form"],
    ])->save();
  }
  $fc = FieldConfig::loadByName("paragraph", "bpcontact_eval", "field_bpcontact_form");
  if (!$fc) {
    $fc = FieldConfig::create([
      "field_name" => "field_bpcontact_form", "entity_type" => "paragraph",
      "bundle" => "bpcontact_eval", "label" => "Contact Form",
    ]);
  }
  $fc->setSetting("handler", "default:contact_form");
  $fc->setSetting("handler_settings", ["target_bundles" => NULL, "auto_create" => FALSE]);
  $fc->save();
  $pids = \Drupal::entityQuery("paragraph")->accessCheck(FALSE)->condition("type", "bpcontact_eval")->execute();
  if ($pids) { \Drupal::entityTypeManager()->getStorage("paragraph")->delete(Paragraph::loadMultiple($pids)); }
  $p = Paragraph::create([
    "type" => "bpcontact_eval",
    "field_bpcontact_form" => ["target_id" => "bpcontact_eval_form"],
  ]);
  $p->save();
  print "paragraph=" . $p->id() . " references contact_form=bpcontact_eval_form\n";
'
drush cr >/dev/null 2>&1
echo "setup: paragraph bundle bpcontact_eval has field_bpcontact_form -> contact_form 'bpcontact_eval_form'"
