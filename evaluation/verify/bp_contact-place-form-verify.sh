#!/usr/bin/env bash
# Execution VERIFY (bp_contact): PASS when a paragraph of bundle bpcontact_place exists whose
# field_bpcontact_place references the contact_form 'bpcontact_support' (NOT bpcontact_sales).
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\paragraphs\Entity\Paragraph;
  $pids = \Drupal::entityQuery("paragraph")->accessCheck(FALSE)->condition("type", "bpcontact_place")->execute();
  $ok = FALSE; $detail = "no bpcontact_place paragraph";
  foreach (Paragraph::loadMultiple($pids) as $p) {
    $ref = $p->hasField("field_bpcontact_place") ? $p->get("field_bpcontact_place")->target_id : NULL;
    $detail = "pid=" . $p->id() . " references=" . var_export($ref, TRUE);
    if ($ref === "bpcontact_support") { $ok = TRUE; break; }
  }
  print ($ok ? "PASS" : "FAIL") . " " . $detail . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
