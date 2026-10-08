#!/usr/bin/env bash
# Execution VERIFY for "let the tm_editor role use term_merge's Merge form on tm_gate".
# term_merge's routes have TWO requirements, so PASS needs both on user.role.tm_editor:
#   * the module's own permission 'merge taxonomy terms', AND
#   * whatever satisfies _term_merge_access_check for that vocabulary — i.e.
#     'edit terms in tm_gate' or the global 'administer taxonomy'.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("tm_editor");
  $perms = $r ? $r->getPermissions() : [];
  $has_merge = in_array("merge taxonomy terms", $perms, TRUE);
  $has_gate = in_array("edit terms in tm_gate", $perms, TRUE)
    || in_array("administer taxonomy", $perms, TRUE);
  $ok = $r !== NULL && $has_merge && $has_gate;
  print ($ok ? "PASS" : "FAIL")
    . " role=" . ($r ? "tm_editor" : "MISSING")
    . " merge_perm=" . var_export($has_merge, TRUE)
    . " vocab_gate=" . var_export($has_gate, TRUE)
    . " perms=[" . implode("|", $perms) . "]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
