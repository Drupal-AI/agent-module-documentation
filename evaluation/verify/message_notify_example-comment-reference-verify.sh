#!/usr/bin/env bash
# Execution VERIFY (stricter): PASS when a Message of template example_create_comment owned by
# mne_author exists AND its field_comment_reference is populated (points at a comment).
# Pure reads. exit 0 pass / 1 fail. (See reset note: node creation is currently broken
# site-wide, so the PASS path is not smoke-testable until that is resolved.)
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $uid = 0; if ($u = user_load_by_name("mne_author")) { $uid = $u->id(); }
  $ok = FALSE; $found = 0;
  if ($uid) {
    $ids = \Drupal::entityTypeManager()->getStorage("message")->getQuery()->accessCheck(FALSE)
      ->condition("template", "example_create_comment")->condition("uid", $uid)->execute();
    foreach ($ids as $id) {
      $m = \Drupal\message\Entity\Message::load($id);
      if ($m->hasField("field_comment_reference") && !$m->get("field_comment_reference")->isEmpty()) { $ok = TRUE; $found++; }
    }
  }
  print (($ok) ? "PASS" : "FAIL") . " author_uid=" . $uid . " msgs_with_ref=" . $found . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
