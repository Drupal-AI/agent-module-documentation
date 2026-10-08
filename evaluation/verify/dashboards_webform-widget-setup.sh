#!/usr/bin/env bash
# Introspection SETUP: create a dashboard containing the webform_submissions widget (setting period=week).
set -uo pipefail
cd /var/www/html
drush php:eval '
use Drupal\dashboards\Entity\Dashboard;
use Drupal\layout_builder\Section;
use Drupal\layout_builder\SectionComponent;
$s = \Drupal::entityTypeManager()->getStorage("dashboard");
if ($d=$s->load("dw_probe")) $d->delete();
$section = new Section("layout_onecol");
$section->appendComponent(new SectionComponent(\Drupal::service("uuid")->generate(), "content", [
  "id" => "dashboards_block:dashboard:webform_submissions", "period" => "week", "label_display" => 0,
]));
Dashboard::create(["id"=>"dw_probe","admin_label"=>"dw Probe","category"=>"Statistics","weight"=>0,"frontend"=>FALSE,"sections"=>[$section]])->save();
' >/dev/null 2>&1
echo "setup: dashboard dw_probe contains dashboards_block:dashboard:webform_submissions (period=week)"
