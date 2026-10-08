#!/usr/bin/env bash
# Execution VERIFY: PASS when at least one Message of template example_create_comment exists
# owned by user mne_author (i.e. the example fired for a comment on that user's node and
# notified them). Pure reads. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $uid = 0; if ($u = user_load_by_name("mne_author")) { $uid = $u->id(); }
  $q = \Drupal::entityTypeManager()->getStorage("message")->getQuery()->accessCheck(FALSE)
    ->condition("template", "example_create_comment");
  if ($uid) { $q->condition("uid", $uid); }
  $n = count($q->execute());
  print (($uid && $n > 0) ? "PASS" : "FAIL") . " author_uid=" . $uid . " messages=" . $n . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
