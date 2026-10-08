#!/usr/bin/env bash
# Execution VERIFY: PASS when the advancedqueue_nightly queue config entity exists with the
# requested configuration - database backend, lease_time 600, daemon processor,
# processing_time 300, stop_when_empty FALSE, locked TRUE and a 30-day success-only
# cleanup threshold. exit 0 = pass, 1 = fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\advancedqueue\Entity\Queue;
  $q = Queue::load("advancedqueue_nightly");
  if (!$q) { print "FAIL queue=missing\n"; return; }
  $t = $q->getThreshold();
  $checks = [
    "backend" => $q->getBackendId() === "database",
    "lease_time" => (int) ($q->getBackendConfiguration()["lease_time"] ?? 0) === 600,
    "processor" => $q->getProcessor() === "daemon",
    "processing_time" => (int) $q->getProcessingTime() === 300,
    "stop_when_empty" => $q->getStopWhenEmpty() == FALSE,
    "locked" => $q->isLocked() === TRUE,
    "threshold_type" => (int) ($t["type"] ?? 0) === 2,
    "threshold_limit" => (int) ($t["limit"] ?? 0) === 30,
    "threshold_state" => ($t["state"] ?? "") === "success",
  ];
  $bad = array_keys(array_filter($checks, fn ($v) => !$v));
  print ($bad ? "FAIL wrong=" . implode(",", $bad) : "PASS") . " actual="
    . json_encode([
        "backend" => $q->getBackendId(),
        "backend_configuration" => $q->getBackendConfiguration(),
        "processor" => $q->getProcessor(),
        "processing_time" => $q->getProcessingTime(),
        "stop_when_empty" => $q->getStopWhenEmpty(),
        "locked" => $q->isLocked(),
        "threshold" => $t,
      ]) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
