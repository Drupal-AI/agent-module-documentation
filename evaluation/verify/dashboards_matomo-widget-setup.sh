#!/usr/bin/env bash
# Introspection SETUP: create a dashboard containing two matomo widgets (visit statistic + countries).
# NOTE: dashboards_matomo requires matomo + matomo_reporting_api and is not enabled here; the widgets'
# block ids are still stored in the dashboard config, which is what this case inspects.
set -uo pipefail
cd /var/www/html
drush php:eval '
use Drupal\dashboards\Entity\Dashboard;
use Drupal\layout_builder\Section;
use Drupal\layout_builder\SectionComponent;
$s = \Drupal::entityTypeManager()->getStorage("dashboard");
if ($d=$s->load("dm_probe")) $d->delete();
$section = new Section("layout_onecol");
$section->appendComponent(new SectionComponent(\Drupal::service("uuid")->generate(), "content", ["id" => "dashboards_block:dashboard:matomo_visit_statistic", "label_display" => 0]));
$section->appendComponent(new SectionComponent(\Drupal::service("uuid")->generate(), "content", ["id" => "dashboards_block:dashboard:matomo_countries", "label_display" => 0]));
Dashboard::create(["id"=>"dm_probe","admin_label"=>"dm Probe","category"=>"Matomo","weight"=>0,"frontend"=>FALSE,"sections"=>[$section]])->save();
' >/dev/null 2>&1
echo "setup: dashboard dm_probe contains dashboards_block:dashboard:matomo_visit_statistic and dashboards_block:dashboard:matomo_countries"
