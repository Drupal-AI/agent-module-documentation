#!/usr/bin/env bash
# Introspection SETUP: write a Twig template that uses twig_xdebug's breakpoint() with a
# known variable argument, so an inspecting agent can read back which variable is inspected.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
D=/var/www/html/web/sites/default/files/tx_med1
mkdir -p "$D"
cat > "$D/report.html.twig" <<'TWIG'
{# Sample report template #}
<div class="report">
  {{ breakpoint(items) }}
  {% for item in items %}
    <span>{{ item.label }}</span>
  {% endfor %}
</div>
TWIG
echo "setup: wrote $D/report.html.twig with {{ breakpoint(items) }}"
