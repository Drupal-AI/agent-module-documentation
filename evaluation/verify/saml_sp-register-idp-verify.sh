#!/usr/bin/env bash
# Execution VERIFY: PASS when an IdP config entity 'smlsp_task' exists with the requested login
# and logout URLs. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\saml_sp\Entity\Idp;
  $i = Idp::load("smlsp_task");
  if (!$i) { print "FAIL no-idp\n"; return; }
  $login = $i->getLoginUrl(); $logout = $i->getLogoutUrl();
  $ok = ($login === "https://idp.acme-eval.example/sso" && $logout === "https://idp.acme-eval.example/slo");
  print ((($ok) ? "PASS" : "FAIL")." login=".$login." logout=".$logout."\n");
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
