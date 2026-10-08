#!/usr/bin/env bash
# Execution VERIFY for "suppress the Gin LB toolbar site-wide via gin_lb's alter hook".
# PASS when at least one enabled module (other than gin_lb itself) implements
# hook_gin_lb_show_toolbar_alter(), AND running that alter chain over a flag that starts TRUE
# turns it FALSE - i.e. the implementation really suppresses the toolbar unconditionally, the
# way gin_lb.api.php documents the hook. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $mh = \Drupal::moduleHandler();
  $implementors = [];
  $mh->invokeAllWith("gin_lb_show_toolbar_alter", static function ($cb, string $module) use (&$implementors) {
    $implementors[] = $module;
  });
  $implementors = \array_values(\array_diff($implementors, ["gin_lb"]));
  $flag = TRUE;
  $mh->alter("gin_lb_show_toolbar", $flag);
  $ok = (\count($implementors) > 0) && ($flag === FALSE);
  print ($ok ? "PASS" : "FAIL")
        . " implementors=" . (\implode(",", $implementors) ?: "none")
        . " show_toolbar=" . \var_export($flag, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
