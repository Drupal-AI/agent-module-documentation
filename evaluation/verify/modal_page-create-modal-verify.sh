#!/usr/bin/env bash
# Execution VERIFY (modal_page H1): PASS when a modal 'mp_task' exists that shows on the front
# page (<front>) and auto-opens. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\modal_page\Entity\Modal;
  $m = Modal::load("mp_task");
  $pages = $m ? (string) $m->getPages() : "";
  $auto = $m ? $m->getAutoOpen() : NULL;
  $ok = $m && (strpos($pages, "<front>") !== FALSE) && !empty($auto);
  print ($ok ? "PASS" : "FAIL")." exists=".var_export((bool)$m,TRUE)." pages=".$pages." auto_open=".var_export($auto,TRUE)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
