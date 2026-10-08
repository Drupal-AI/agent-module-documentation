#!/usr/bin/env bash
# Execution VERIFY for "create an external_link_popup pop-up elp_task titled 'Warning' for
# example.org". PASS when the entity exists, is enabled, title == 'Warning', and its domains
# include example.org. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\external_link_popup\Entity\ExternalLinkPopup;
  $p = ExternalLinkPopup::load("elp_task");
  $title = $p ? $p->getTitle() : "";
  $domains = $p ? (string) $p->getDomains() : "";
  $ok = ($p && $p->status() && $title === "Warning" && strpos($domains, "example.org") !== FALSE);
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($p ? "yes" : "no") . " title=" . $title . " domains=" . str_replace("\n", ",", $domains) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
