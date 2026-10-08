#!/usr/bin/env bash
# Execution RESET: create a *.stories.twig under web/modules/custom/storybook_ev_task and
# ensure its *.stories.json does NOT exist, so verify FAILS until the agent compiles it.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
DIR="web/modules/custom/storybook_ev_task"
mkdir -p "$DIR"
cat > "$DIR/card.stories.twig" <<'TWIG'
{% stories card with { title: 'Components/StorybookEval/Card' } %}
  {% story default with { name: 'Default', args: { heading: 'Hello world' } } %}
    <div class="sb-card"><h2>{{ heading }}</h2></div>
  {% endstory %}
{% endstories %}
TWIG
rm -f "$DIR/card.stories.json"
echo "reset: $DIR/card.stories.twig present, no card.stories.json"
