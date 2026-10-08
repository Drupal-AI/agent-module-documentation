#!/usr/bin/env bash
# Introspection SETUP (no mutation): baseline for "which class is the event_dispatcher service"
# (Tracer decorates it while enabled).
set -uo pipefail
cd /var/www/html
c=$(drush php:eval 'print get_class(\Drupal::service("event_dispatcher"));' 2>/dev/null)
echo "setup: event_dispatcher currently resolves to $c"
