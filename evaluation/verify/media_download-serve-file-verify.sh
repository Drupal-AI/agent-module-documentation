#!/usr/bin/env bash
# Execution VERIFY: PASS when a media named 'mdl_task' exists and its canonical /media/{id}
# path serves the source file directly (200 CacheableBinaryFileResponse, inline) via
# media_download. Runs the request as uid 1 (needs 'view media'). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Symfony\Component\HttpFoundation\Request;
  $ms = \Drupal::entityTypeManager()->getStorage("media")->loadByProperties(["name" => "mdl_task"]);
  if (!$ms) { print "FAIL no-media\n"; return; }
  $m = reset($ms); $mid = $m->id();
  \Drupal::service("account_switcher")->switchTo(\Drupal\user\Entity\User::load(1));
  $resp = \Drupal::service("http_kernel")->handle(Request::create("/media/".$mid));
  \Drupal::service("account_switcher")->switchBack();
  $cls = get_class($resp); $code = $resp->getStatusCode(); $disp = (string) $resp->headers->get("Content-Disposition");
  $ok = ($code === 200 && $resp instanceof \Drupal\media_download\CacheableBinaryFileResponse);
  print (($ok ? "PASS" : "FAIL")." status=".$code." class=".$cls." disp=".$disp."\n");
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
