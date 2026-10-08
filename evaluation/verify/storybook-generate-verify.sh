#!/usr/bin/env bash
# Execution VERIFY: PASS when web/modules/custom/storybook_ev_task/card.stories.json exists,
# is valid JSON, and has title 'Components/StorybookEval/Card'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
JSON="web/modules/custom/storybook_ev_task/card.stories.json"
if [ ! -f "$JSON" ]; then echo "FAIL json missing ($JSON)"; exit 1; fi
title=$(php -r '$d=json_decode(file_get_contents($argv[1]),true); echo is_array($d)&&isset($d["title"])?$d["title"]:"";' "$JSON" 2>/dev/null)
if [ "$title" = "Components/StorybookEval/Card" ]; then
  echo "PASS title=$title"; exit 0
else
  echo "FAIL title=[$title]"; exit 1
fi
