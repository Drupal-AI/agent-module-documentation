#!/usr/bin/env bash
# Execution VERIFY: PASS when web/sites/default/files/emulsify_twig_eval/wrapper.html.twig
# exists, calls emulsify_twig's add_attributes() function, and — rendered through the live Twig
# environment with a context attributes object that already carries class "existing" — produces a
# <div> that keeps "existing", adds "promo", and carries data-promo="true".
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
FILE=/var/www/html/web/sites/default/files/emulsify_twig_eval/wrapper.html.twig
if [ ! -f "$FILE" ]; then echo "FAIL template missing: $FILE"; exit 1; fi
if ! grep -q 'add_attributes(' "$FILE"; then echo "FAIL template does not call add_attributes()"; exit 1; fi
out=$(drush php:eval '
  $file = "/var/www/html/web/sites/default/files/emulsify_twig_eval/wrapper.html.twig";
  try {
    $ctx = ["attributes" => new \Drupal\Core\Template\Attribute(["class" => ["existing"]])];
    $html = \Drupal::service("twig")->createTemplate(file_get_contents($file))->render($ctx);
  }
  catch (\Throwable $e) {
    print "FAIL render error: " . $e->getMessage() . "\n"; return;
  }
  $ok = FALSE; $classes = [];
  if (preg_match("#<div([^>]*)>#i", $html, $m)) {
    $tag = $m[1];
    preg_match("#class=\"([^\"]*)\"#i", $tag, $c);
    $classes = isset($c[1]) ? array_values(array_filter(preg_split("/\s+/", trim($c[1])))) : [];
    $ok = in_array("existing", $classes, TRUE)
      && in_array("promo", $classes, TRUE)
      && (bool) preg_match("#data-promo=\"true\"#i", $tag);
  }
  print ($ok ? "PASS" : "FAIL") . " classes=" . implode("|", $classes) . " html=" . trim(preg_replace("/\s+/", " ", $html)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
