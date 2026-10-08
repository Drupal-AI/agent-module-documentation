#!/usr/bin/env bash
# Introspection SETUP: create an embedded_paragraphs entity labelled 'PEE Known Embed' wrapping a
# bp_simple paragraph, so an agent can read back the label of the existing embedded paragraph.
# Uses the existing bp_simple paragraph type (no paragraphs_type CRUD). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\paragraphs\Entity\Paragraph;
  use Drupal\paragraphs_entity_embed\Entity\EmbeddedParagraphs;
  $existing = \Drupal::entityTypeManager()->getStorage("embedded_paragraphs")->loadByProperties(["label" => "PEE Known Embed"]);
  if (!$existing) {
    $p = Paragraph::create(["type" => "bp_simple"]); $p->save();
    EmbeddedParagraphs::create(["label" => "PEE Known Embed", "paragraph" => $p])->save();
  }
' >/dev/null 2>&1
echo "setup: embedded_paragraphs 'PEE Known Embed' present"
