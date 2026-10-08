#!/usr/bin/env bash
# Introspection SETUP: create a Swiper template config entity sf_known with a distinctive
# vertical direction and a 7000ms autoplay delay, so an agent can read the value back from
# live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\swiper_formatter\Entity\SwiperFormatter;
  if ($e = SwiperFormatter::load("sf_known")) { $e->delete(); }
  SwiperFormatter::create([
    "id" => "sf_known", "label" => "SF Known",
    "swiper_options" => ["direction" => "vertical", "autoplay" => ["enabled" => TRUE, "delay" => 7000]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: swiper template sf_known created (direction=vertical, autoplay.delay=7000)"
