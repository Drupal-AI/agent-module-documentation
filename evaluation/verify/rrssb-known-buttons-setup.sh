#!/usr/bin/env bash
# Introspection SETUP: create RRSSB button set rrssb_known with email+facebook enabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\rrssb\Entity\RRSSBButtonSet;
  if ($s = RRSSBButtonSet::load("rrssb_known")) { $s->delete(); }
  RRSSBButtonSet::create([
    "id" => "rrssb_known", "label" => "Known", "follow" => 0,
    "chosen" => [
      "email" => ["enabled" => TRUE, "weight" => -20],
      "facebook" => ["enabled" => TRUE, "weight" => -19],
    ],
  ])->save();
' >/dev/null 2>&1
echo "setup: rrssb.button_set.rrssb_known has email,facebook enabled"
