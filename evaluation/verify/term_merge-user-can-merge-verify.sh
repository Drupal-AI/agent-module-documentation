#!/usr/bin/env bash
# Execution VERIFY for "let the user tm_access_user open term_merge's Merge form for the
# tm_access vocabulary". This is a BEHAVIOURAL check, not a config diff: it asks Drupal's
# access_manager to resolve entity.taxonomy_vocabulary.merge_form for that account, which
# exercises BOTH of term_merge's gates — the 'merge taxonomy terms' permission requirement and
# the module's own _term_merge_access_check (Drupal\term_merge\Access\MergeAccess).
# Guards against a false pass via uid 1 (which bypasses all access checks).
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $users = \Drupal::entityTypeManager()->getStorage("user")->loadByProperties(["name" => "tm_access_user"]);
  $u = $users ? reset($users) : NULL;
  $can = FALSE;
  $is_root = FALSE;
  if ($u) {
    $is_root = ((int) $u->id() === 1);
    $can = \Drupal::service("access_manager")->checkNamedRoute(
      "entity.taxonomy_vocabulary.merge_form",
      ["taxonomy_vocabulary" => "tm_access"],
      $u
    );
  }
  $ok = $u !== NULL && !$is_root && (bool) $can;
  print ($ok ? "PASS" : "FAIL")
    . " user=" . ($u ? "tm_access_user(uid=" . $u->id() . ")" : "MISSING")
    . " uid1_bypass=" . var_export($is_root, TRUE)
    . " roles=[" . implode("|", $u ? $u->getRoles() : []) . "]"
    . " can_reach_merge_form=" . var_export((bool) $can, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
