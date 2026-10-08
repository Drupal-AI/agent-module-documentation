#!/usr/bin/env bash
# Introspection SETUP (no mutation): baseline for "which class does tracer.tracer resolve to on
# this site". With no tracer_plugin set in settings.php, it is the NoopTracer.
set -uo pipefail
cd /var/www/html
c=$(drush php:eval 'print get_class(\Drupal::service("tracer.tracer"));' 2>/dev/null)
echo "setup: tracer.tracer currently resolves to $c"
