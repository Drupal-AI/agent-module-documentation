#!/usr/bin/env bash
# Introspection SETUP: create a *.stories.twig under web/modules/custom/storybook_ev_data and
# compile it to *.stories.json with the storybook module, so an agent can read the compiled
# story group title. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
DIR="web/modules/custom/storybook_ev_data"
mkdir -p "$DIR"
cat > "$DIR/widget.stories.twig" <<'TWIG'
{% stories widget with { title: 'Components/StorybookEval/Widget' } %}
  {% story primary with { name: 'Primary', args: { label: 'Click me' } } %}
    <button class="widget">{{ label }}</button>
  {% endstory %}
{% endstories %}
TWIG
rm -f "$DIR/widget.stories.json"
# generate-stories writes JSON relative to CWD, so run from the Drupal docroot (web/):
( cd web && drush storybook:generate-stories modules/custom/storybook_ev_data/widget.stories.twig >/dev/null 2>&1 )
echo "setup: compiled $DIR/widget.stories.json (title Components/StorybookEval/Widget)"
