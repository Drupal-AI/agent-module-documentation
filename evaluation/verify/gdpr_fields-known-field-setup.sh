#!/usr/bin/env bash
# Introspection SETUP: configure GDPR field metadata for the user 'mail' field (enabled, RTF
# anonymize, anonymizer email_anonymizer) so an inspecting agent can read it back. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\gdpr_fields\Entity\GdprFieldConfigEntity;
  use Drupal\gdpr_fields\Entity\GdprField;
  $c = GdprFieldConfigEntity::load("user") ?? GdprFieldConfigEntity::create(["id" => "user"]);
  $f = new GdprField(["bundle" => "user", "name" => "mail", "entity_type_id" => "user"]);
  $f->setEnabled(TRUE)->setRta("inc")->setRtf("anonymize")->setAnonymizer("email_anonymizer");
  $c->setField($f);
  $c->save();
' >/dev/null 2>&1
echo "setup: gdpr_fields_config user.mail enabled, rtf=anonymize, anonymizer=email_anonymizer"
