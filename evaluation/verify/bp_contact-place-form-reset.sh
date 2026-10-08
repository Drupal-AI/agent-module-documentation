#!/usr/bin/env bash
# Execution RESET (bp_contact): provide the bundle + field + a core contact form, but NO
# paragraph referencing it, so the agent must create the paragraph that embeds the right form.
# Creates paragraph bundle bpcontact_place with field_bpcontact_place (entity_reference ->
# contact_form) and a contact_form "bpcontact_support". Deletes any existing bpcontact_place
# paragraphs. verify FAILS here. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\contact\Entity\ContactForm;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\paragraphs\Entity\Paragraph;
  use Drupal\paragraphs\Entity\ParagraphsType;
  if (!ContactForm::load("bpcontact_support")) {
    ContactForm::create([
      "id" => "bpcontact_support", "label" => "BP Contact Support",
      "recipients" => ["bpcontact-support@example.com"], "message" => "", "redirect" => "",
    ])->save();
  }
  if (!ContactForm::load("bpcontact_sales")) {
    ContactForm::create([
      "id" => "bpcontact_sales", "label" => "BP Contact Sales",
      "recipients" => ["bpcontact-sales@example.com"], "message" => "", "redirect" => "",
    ])->save();
  }
  if (!ParagraphsType::load("bpcontact_place")) {
    ParagraphsType::create(["id" => "bpcontact_place", "label" => "BP Contact Place"])->save();
  }
  if (!FieldStorageConfig::loadByName("paragraph", "field_bpcontact_place")) {
    FieldStorageConfig::create([
      "field_name" => "field_bpcontact_place", "entity_type" => "paragraph",
      "type" => "entity_reference", "cardinality" => 1,
      "settings" => ["target_type" => "contact_form"],
    ])->save();
  }
  $fc = FieldConfig::loadByName("paragraph", "bpcontact_place", "field_bpcontact_place");
  if (!$fc) {
    $fc = FieldConfig::create([
      "field_name" => "field_bpcontact_place", "entity_type" => "paragraph",
      "bundle" => "bpcontact_place", "label" => "Contact Form",
    ]);
  }
  $fc->setSetting("handler", "default:contact_form");
  $fc->setSetting("handler_settings", ["target_bundles" => NULL, "auto_create" => FALSE]);
  $fc->save();
  $pids = \Drupal::entityQuery("paragraph")->accessCheck(FALSE)->condition("type", "bpcontact_place")->execute();
  if ($pids) { \Drupal::entityTypeManager()->getStorage("paragraph")->delete(Paragraph::loadMultiple($pids)); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: bpcontact_place bundle ready, contact forms bpcontact_support + bpcontact_sales exist, no paragraph yet"
