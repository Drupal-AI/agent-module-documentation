#!/usr/bin/env bash
# Execution VERIFY: PASS when /tmp/wfx_task_export.xlsx exists, PhpSpreadsheet identifies it
# as a real Xlsx workbook, and it holds a header row plus the two submissions.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
if [ ! -f /tmp/wfx_task_export.xlsx ]; then
  echo "FAIL file=/tmp/wfx_task_export.xlsx missing"
  exit 1
fi
out=$(drush php:eval '
  $path = "/tmp/wfx_task_export.xlsx";
  $type = "?"; $rows = 0; $found = "";
  try {
    $type = \PhpOffice\PhpSpreadsheet\IOFactory::identify($path);
    $book = \PhpOffice\PhpSpreadsheet\IOFactory::load($path);
    $sheet = $book->getActiveSheet();
    $rows = $sheet->getHighestRow();
    foreach ($sheet->toArray() as $row) { $found .= implode("|", array_map("strval", $row)); }
  }
  catch (\Throwable $e) { $type = "ERROR:" . $e->getMessage(); }
  $ok = ($type === "Xlsx") && ($rows >= 3)
    && (stripos($found, "Alice") !== FALSE) && (stripos($found, "Bob") !== FALSE);
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " rows=" . $rows . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
