#!/usr/bin/env bash
# Execution RESET (epk H1): (re)create text format 'epk_task' WITHOUT the Empty Paragraph
# filter, so verify FAILS until the agent enables it on that format. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f=FilterFormat::load("epk_task")){$f->delete();}
  FilterFormat::create(["format"=>"epk_task","name"=>"EPK Task","weight"=>23,"filters"=>[]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: text format epk_task exists WITHOUT emptyparagraphkiller filter"
