#!/usr/bin/env bash
# Execution RESET: write a source SCSS file at /tmp/scss_compiler-eval/style.scss and remove any
# compiled output, so verify FAILS until the agent compiles it with the scss_compiler service.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $dir = "/tmp/scss_compiler-eval";
  if (!is_dir($dir)) { mkdir($dir, 0777, TRUE); }
  file_put_contents("$dir/style.scss", "\$brand: #123456;\n.box { .title { color: \$brand; } }\n");
  @unlink("$dir/style.css");
  @unlink("$dir/style.css.map");
' >/dev/null 2>&1
echo "reset: /tmp/scss_compiler-eval/style.scss written, style.css removed"
