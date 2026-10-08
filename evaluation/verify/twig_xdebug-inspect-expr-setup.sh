#!/usr/bin/env bash
# Introspection SETUP: write a Twig template using breakpoint() with a nested expression
# argument, so an inspecting agent can read back what is passed to the breakpoint.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
D=/var/www/html/web/sites/default/files/tx_med2
mkdir -p "$D"
cat > "$D/body.html.twig" <<'TWIG'
{# Body field template #}
<article>
  {{ breakpoint(node.field_body.value) }}
  {{ node.field_body.value }}
</article>
TWIG
echo "setup: wrote $D/body.html.twig with {{ breakpoint(node.field_body.value) }}"
