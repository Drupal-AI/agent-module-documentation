#!/usr/bin/env bash
# Execution RESET: restore dblog_filter baseline (log everything) so verify FAILS until the
set -uo pipefail
cd /var/www/html
drush php:eval '$c = \Drupal::configFactory()->getEditable("dblog_filter.settings");
$levels = ["emergency"=>false,"alert"=>false,"critical"=>false,"error"=>false,"warning"=>false,"notice"=>false,"info"=>false,"debug"=>false];
$c->set("severity_levels", $levels)->set("log_values", [])->set("log_values_regex", [])->set("method", "exclude")
  ->set("syslog_severity_levels", $levels)->set("syslog_log_values", [])->set("syslog_log_values_regex", [])->set("syslog_method", "exclude")
  ->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: dblog_filter.settings restored to baseline (nothing filtered)"
