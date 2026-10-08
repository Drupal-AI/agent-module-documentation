#!/usr/bin/env bash
# Execution VERIFY (unified_twig_ext): PASS when unified_twig_ext loads a Twig FILTER `ute_shout`
# (uppercases and appends '!') from the ute_twig theme. Transiently installs+defaults ute_twig,
# renders {{ 'hi'|ute_shout }}, ALWAYS restores default=olivero. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $cfg=\Drupal::configFactory()->getEditable("system.theme");
  $orig=$cfg->get("default");
  $res="";
  try {
    if(!\Drupal::service("theme_handler")->themeExists("ute_twig")){\Drupal::service("theme_installer")->install(["ute_twig"]);}
    $cfg->set("default","ute_twig")->save();
    drupal_flush_all_caches();
    $res=trim((string)\Drupal::service("twig")->renderInline("{{ \"hi\"|ute_shout }}"));
  } catch (\Throwable $e) { $res="ERR:".$e->getMessage(); }
  finally {
    $cfg->set("default",$orig)->save();
    drupal_flush_all_caches();
  }
  print "RESULT=[".$res."]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q 'RESULT=\[HI!\]' && { echo PASS; exit 0; }
echo FAIL; exit 1
