#!/usr/bin/env bash
# Execution VERIFY: PASS when a media named 'mdl_dl' exists and /media/{id}?dl=1 forces an
# attachment (save-to-disk) download while /media/{id} is inline. Runs as uid 1. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Symfony\Component\HttpFoundation\Request;
  $ms = \Drupal::entityTypeManager()->getStorage("media")->loadByProperties(["name" => "mdl_dl"]);
  if (!$ms) { print "FAIL no-media\n"; return; }
  $m = reset($ms); $mid = $m->id();
  \Drupal::service("account_switcher")->switchTo(\Drupal\user\Entity\User::load(1));
  $dl = \Drupal::service("http_kernel")->handle(Request::create("/media/".$mid, "GET", ["dl" => "1"]));
  $inline = \Drupal::service("http_kernel")->handle(Request::create("/media/".$mid));
  \Drupal::service("account_switcher")->switchBack();
  $dldisp = (string) $dl->headers->get("Content-Disposition");
  $indisp = (string) $inline->headers->get("Content-Disposition");
  $ok = ($dl->getStatusCode() === 200 && strpos($dldisp, "attachment") === 0 && strpos($indisp, "inline") === 0);
  print (($ok ? "PASS" : "FAIL")." dl-disp=".$dldisp." inline-disp=".$indisp."\n");
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
