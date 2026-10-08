#!/usr/bin/env bash
# Execution VERIFY: PASS when web/sites/default/files/emulsify_twig_eval/card-title.html.twig
# exists, actually calls the emulsify_twig bem() function (not hard-coded classes), and renders
# through the live Twig environment to an <h1> whose classes are exactly
# teaser__title, teaser__title--large, js-teaser and whose text is "Read more".
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
FILE=/var/www/html/web/sites/default/files/emulsify_twig_eval/card-title.html.twig
if [ ! -f "$FILE" ]; then echo "FAIL template missing: $FILE"; exit 1; fi
if ! grep -q 'bem(' "$FILE"; then echo "FAIL template does not call bem()"; exit 1; fi
out=$(drush php:eval '
  $file = "/var/www/html/web/sites/default/files/emulsify_twig_eval/card-title.html.twig";
  try {
    $html = \Drupal::service("twig")->createTemplate(file_get_contents($file))->render([]);
  }
  catch (\Throwable $e) {
    print "FAIL render error: " . $e->getMessage() . "\n"; return;
  }
  $ok = FALSE; $classes = [];
  if (preg_match("#<h1[^>]*class=\"([^\"]*)\"[^>]*>\s*Read more\s*</h1>#i", $html, $m)) {
    $classes = array_values(array_filter(preg_split("/\s+/", trim($m[1]))));
    sort($classes);
    $want = ["js-teaser", "teaser__title", "teaser__title--large"];
    $ok = ($classes === $want);
  }
  print ($ok ? "PASS" : "FAIL") . " classes=" . implode("|", $classes) . " html=" . trim(preg_replace("/\s+/", " ", $html)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
