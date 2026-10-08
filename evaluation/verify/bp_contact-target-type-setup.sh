#!/usr/bin/env bash
# Introspection SETUP (bp_contact): stand up the paragraph bundle bpcontact_probe with TWO
# reference fields - field_bpcontact_ref targeting core's contact_form entity type (mirroring
# what bp_contact ships) and field_bpcontact_node targeting node - so the agent must read the
# live field storage definitions to say which one points at contact forms.
# bp_contact itself is not installable on D11, hence the stand-in bundle. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\paragraphs\Entity\ParagraphsType;
  if (!ParagraphsType::load("bpcontact_probe")) {
    ParagraphsType::create(["id" => "bpcontact_probe", "label" => "BP Contact Probe"])->save();
  }
  $spec = [
    ["field_bpcontact_ref", "contact_form", "default:contact_form", "Contact Form Reference"],
    ["field_bpcontact_node", "node", "default:node", "Node Reference"],
  ];
  foreach ($spec as [$name, $target, $handler, $label]) {
    if (!FieldStorageConfig::loadByName("paragraph", $name)) {
      FieldStorageConfig::create([
        "field_name" => $name, "entity_type" => "paragraph",
        "type" => "entity_reference", "cardinality" => 1,
        "settings" => ["target_type" => $target],
      ])->save();
    }
    $fc = FieldConfig::loadByName("paragraph", "bpcontact_probe", $name);
    if (!$fc) {
      $fc = FieldConfig::create([
        "field_name" => $name, "entity_type" => "paragraph",
        "bundle" => "bpcontact_probe", "label" => $label,
      ]);
    }
    $fc->setSetting("handler", $handler);
    $fc->save();
  }
  print "bundle bpcontact_probe has field_bpcontact_ref(contact_form) + field_bpcontact_node(node)\n";
'
drush cr >/dev/null 2>&1
echo "setup: paragraph bundle bpcontact_probe created with two entity_reference fields"
